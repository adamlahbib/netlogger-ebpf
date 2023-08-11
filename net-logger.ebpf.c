#include <linux/bpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>
#include <bpf_helpers.h>
#include <bpf_endian.h>



struct packet_info {
    // __u64 timestamp;
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
    __u16 src_port,dst_port;
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

    if (iph->protocol == 6) {
        struct tcphdr *tcph = (struct tcphdr *)(iph + 1);
        src_port = bpf_ntohs(tcph->source);
        dst_port = bpf_ntohs(tcph->dest);
    } 

    __u32 key = 0;
    struct packet_info pkt_info = {};
    // pkt_info.timestamp = bpf_ktime_get_ns();
    pkt_info.protocol = iph->protocol;
    pkt_info.src_ip = iph->saddr;
    pkt_info.dst_ip = iph->daddr;
    pkt_info.src_port = src_port;
    pkt_info.dst_port = dst_port;
    
    for (int i = 0; i < 6; i++) {
    pkt_info.eth_src[i] = eth->h_source[i];
    pkt_info.eth_dst[i] = eth->h_dest[i];
    }   

    bpf_perf_event_output(ctx, &packet_info_map, BPF_F_CURRENT_CPU, &pkt_info, sizeof(pkt_info));
    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
