#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <bpf_helpers.h>
#include <bpf_endian.h>
#include <netinet/ip.h>


struct packet_info {
    __u16 protocol;
    __u32 src_ip;
    __u32 dst_ip;
    unsigned char eth_src[6];
    unsigned char eth_dst[6];
    __u16 src_port;
    __u16 dst_port;
};

struct {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
    __uint(key_size, sizeof(__u32));
    __uint(value_size, sizeof(__u32));
} packet_info_map SEC(".maps");

SEC("xdp")
int packet_info_prog(struct xdp_md *ctx) {
    void *data = (void *)(long)ctx->data;
    void *data_end = (void *)(long)ctx->data_end;
    
    struct ethhdr *eth = data;
    if (data + sizeof(struct ethhdr) > data_end)
        return XDP_PASS;

    if (bpf_ntohs(eth->h_proto) != ETH_P_IP)
        return XDP_PASS;

    struct iphdr *iph = data + sizeof(struct ethhdr);
    if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) > data_end)
        return XDP_PASS;

    __u32 key = 0;
    struct packet_info pkt_info = {};

    pkt_info.protocol = iph->protocol;
    pkt_info.src_ip = iph->saddr;
    pkt_info.dst_ip = iph->daddr;
    
    if (iph->protocol == IPPROTO_TCP) {
        struct tcphdr *tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
        if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct tcphdr) > data_end)
            return XDP_PASS;

        pkt_info.src_port = bpf_ntohs(tcph->source);
        pkt_info.dst_port = bpf_ntohs(tcph->dest);
    }
    
    else if (iph->protocol == IPPROTO_UDP) {
        struct udphdr *udph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);
        if (data + sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) > data_end)
            return XDP_PASS;

        pkt_info.src_port = bpf_ntohs(udph->source);
        pkt_info.dst_port = bpf_ntohs(udph->dest);
    }   

    for (int i = 0; i < 6; i++) {
        pkt_info.eth_src[i] = eth->h_source[i];
        pkt_info.eth_dst[i] = eth->h_dest[i];
    }   

    bpf_perf_event_output(ctx, &packet_info_map, BPF_F_CURRENT_CPU, &pkt_info, sizeof(pkt_info));
    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
