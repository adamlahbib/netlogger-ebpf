package main

import (
	"encoding/binary"
	"fmt"
	"net"
	"time"

	"github.com/cilium/ebpf"
	"github.com/cilium/ebpf/link"
	"github.com/cilium/ebpf/perf"
)

const (
	MapName = "packet_info_map" // Match the map name used in your eBPF program
)

type Data struct {
	Protocol uint16
	SrcPort  uint16
	DstPort  uint16
	SrcIP    int32
	DstIP    int32
	DstMac   [6]byte
	SrcMac   [6]byte
}

func main() {

	protocols := map[int]string{
		0:  "HOPOPT",
		1:  "ICMP",
		2:  "IGMP",
		3:  "GGP",
		4:  "IPv4",
		5:  "ST",
		6:  "TCP",
		17: "UDP",
	}

	spec, err := ebpf.LoadCollectionSpec("./net-logger.ebpf.o")
	if err != nil {
		panic(err)
	}
	coll, err := ebpf.NewCollection(spec)
	if err != nil {
		panic(fmt.Sprintf("Failed to create new collection: %v\n", err))
	}
	defer coll.Close()
	prog := coll.Programs["packet_info_prog"]
	if prog == nil {
		panic("No program named 'packet_info_prog' found in collection")
	}
	iface := "wlo1"
	if iface == "" {
		panic("No interface specified. Please set the INTERFACE environment variable to the name of the interface to be use")
	}
	iface_idx, err := net.InterfaceByName(iface)
	if err != nil {
		panic(fmt.Sprintf("Failed to get interface %s: %v\n", iface, err))
	}
	opts := link.XDPOptions{
		Program:   prog,
		Interface: iface_idx.Index,
		// Flags is one of XDPAttachFlags (optional).
	}
	lnk, err := link.AttachXDP(opts)
	if err != nil {
		panic(err)
	}
	defer lnk.Close()
	fmt.Println("Successfully loaded and attached BPF program.")
	// handle perf events
	packetInfoMap := coll.Maps["packet_info_map"]

	perfEvent, err := perf.NewReader(packetInfoMap, 4096)
	if err != nil {
		panic(fmt.Sprintf("Failed to create perf event reader: %v\n", err))
	}
	defer perfEvent.Close()
	fmt.Println("Listening for events...")
	for {
		record, err := perfEvent.Read()
		if err != nil {
			fmt.Println(err)
			continue
		}
		if len(record.RawSample) < 12 {
			fmt.Println("Invalid sample size")
			continue
		}
		var data Data
		//data.Timestamp = binary.LittleEndian.Uint64(record.RawSample[:])
		data.Protocol = binary.LittleEndian.Uint16(record.RawSample[0:2])
		data.SrcIP = int32(binary.LittleEndian.Uint32(record.RawSample[4:8]))
		data.DstIP = int32(binary.LittleEndian.Uint32(record.RawSample[8:12]))
		data.SrcMac = [6]byte(record.RawSample[12:18])
		data.DstMac = [6]byte(record.RawSample[18:24])
		data.SrcPort = binary.LittleEndian.Uint16(record.RawSample[24:26])
		data.DstPort = binary.LittleEndian.Uint16(record.RawSample[26:28])
		fmt.Println(record.RawSample[0:len(record.RawSample)])
		now := time.Now()

		// Format the time as desired
		formattedTime := now.Format("15:04:05.000000")
		fmt.Printf("%s Protocol: %v, SRC IP: %s DST IP: %s SRC MAC %s DST MAC %s\n SRC PORT %v DST PORT %v", formattedTime, protocols[int(data.Protocol)], getIP(data.SrcIP), getIP(data.DstIP), convertToMACAddress(data.SrcMac), convertToMACAddress(data.DstMac), data.SrcPort, data.DstPort)
	}
}

func getIP(ip int32) string {
	a := ip & 0xFF
	b := (ip >> 8) & 0xFF
	c := (ip >> 16) & 0xFF
	d := (ip >> 24) & 0xFF

	return fmt.Sprintf("%d.%d.%d.%d", a, b, c, d)
}

func convertToMACAddress(macBytes [6]byte) string {
	return fmt.Sprintf("%02X:%02X:%02X:%02X:%02X:%02X",
		macBytes[0], macBytes[1], macBytes[2], macBytes[3], macBytes[4], macBytes[5])
}
