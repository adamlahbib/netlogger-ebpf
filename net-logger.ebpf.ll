; ModuleID = 'net-logger.ebpf.c'
source_filename = "net-logger.ebpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { ptr, ptr, ptr }
%struct.packet_info = type { i16, i32, i32, [6 x i8], [6 x i8], i16, i16 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@packet_info_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !59
@llvm.compiler.used = appending global [3 x ptr] [ptr @_license, ptr @packet_info_map, ptr @packet_info_prog], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @packet_info_prog(ptr noundef %0) #0 section "xdp" !dbg !86 {
  %2 = alloca %struct.packet_info, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !100, metadata !DIExpression()), !dbg !191
  %3 = load i32, ptr %0, align 4, !dbg !192, !tbaa !193
  %4 = zext i32 %3 to i64, !dbg !198
  %5 = inttoptr i64 %4 to ptr, !dbg !199
  call void @llvm.dbg.value(metadata ptr %5, metadata !101, metadata !DIExpression()), !dbg !191
  %6 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !200
  %7 = load i32, ptr %6, align 4, !dbg !200, !tbaa !201
  %8 = zext i32 %7 to i64, !dbg !202
  %9 = inttoptr i64 %8 to ptr, !dbg !203
  call void @llvm.dbg.value(metadata ptr %9, metadata !102, metadata !DIExpression()), !dbg !191
  call void @llvm.dbg.value(metadata ptr %5, metadata !103, metadata !DIExpression()), !dbg !191
  %10 = getelementptr i8, ptr %5, i64 14, !dbg !204
  %11 = icmp ugt ptr %10, %9, !dbg !206
  br i1 %11, label %81, label %12, !dbg !207

12:                                               ; preds = %1
  %13 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 2, !dbg !208
  %14 = load i16, ptr %13, align 1, !dbg !208, !tbaa !210
  %15 = icmp eq i16 %14, 8, !dbg !213
  br i1 %15, label %16, label %81, !dbg !214

16:                                               ; preds = %12
  call void @llvm.dbg.value(metadata ptr %10, metadata !117, metadata !DIExpression()), !dbg !191
  %17 = getelementptr i8, ptr %5, i64 34, !dbg !215
  %18 = icmp ugt ptr %17, %9, !dbg !217
  br i1 %18, label %81, label %19, !dbg !218

19:                                               ; preds = %16
  call void @llvm.dbg.value(metadata i32 0, metadata !141, metadata !DIExpression()), !dbg !191
  call void @llvm.lifetime.start.p0(i64 28, ptr nonnull %2) #5, !dbg !219
  call void @llvm.dbg.declare(metadata ptr %2, metadata !142, metadata !DIExpression()), !dbg !220
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(28) %2, i8 0, i64 28, i1 false), !dbg !220
  %20 = getelementptr i8, ptr %5, i64 23, !dbg !221
  %21 = load i8, ptr %20, align 1, !dbg !221, !tbaa !222
  %22 = zext i8 %21 to i16, !dbg !224
  store i16 %22, ptr %2, align 4, !dbg !225, !tbaa !226
  %23 = getelementptr i8, ptr %5, i64 26, !dbg !228
  %24 = load i32, ptr %23, align 4, !dbg !228, !tbaa !229
  %25 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 1, !dbg !230
  store i32 %24, ptr %25, align 4, !dbg !231, !tbaa !232
  %26 = getelementptr i8, ptr %5, i64 30, !dbg !233
  %27 = load i32, ptr %26, align 4, !dbg !233, !tbaa !234
  %28 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 2, !dbg !235
  store i32 %27, ptr %28, align 4, !dbg !236, !tbaa !237
  switch i8 %21, label %43 [
    i8 6, label %29
    i8 17, label %32
  ], !dbg !238

29:                                               ; preds = %19
  call void @llvm.dbg.value(metadata ptr %17, metadata !152, metadata !DIExpression()), !dbg !239
  %30 = getelementptr i8, ptr %5, i64 54, !dbg !240
  %31 = icmp ugt ptr %30, %9, !dbg !242
  br i1 %31, label %80, label %35, !dbg !243

32:                                               ; preds = %19
  call void @llvm.dbg.value(metadata ptr %17, metadata !178, metadata !DIExpression()), !dbg !244
  %33 = getelementptr i8, ptr %5, i64 42, !dbg !245
  %34 = icmp ugt ptr %33, %9, !dbg !247
  br i1 %34, label %80, label %35, !dbg !248

35:                                               ; preds = %32, %29
  %36 = load i16, ptr %17, align 2, !dbg !249, !tbaa !250
  %37 = tail call i16 @llvm.bswap.i16(i16 %36), !dbg !249
  %38 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 5, !dbg !249
  store i16 %37, ptr %38, align 4, !dbg !249, !tbaa !251
  %39 = getelementptr i8, ptr %5, i64 36, !dbg !249
  %40 = load i16, ptr %39, align 2, !dbg !249, !tbaa !250
  %41 = tail call i16 @llvm.bswap.i16(i16 %40), !dbg !249
  %42 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 6, !dbg !249
  store i16 %41, ptr %42, align 2, !dbg !249, !tbaa !252
  br label %43, !dbg !253

43:                                               ; preds = %35, %19
  call void @llvm.dbg.value(metadata i32 0, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 0, metadata !189, metadata !DIExpression()), !dbg !256
  %44 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 0, !dbg !253
  %45 = load i8, ptr %44, align 1, !dbg !253, !tbaa !257
  %46 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 0, !dbg !258
  store i8 %45, ptr %46, align 4, !dbg !259, !tbaa !257
  %47 = load i8, ptr %5, align 1, !dbg !260, !tbaa !257
  %48 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 0, !dbg !261
  store i8 %47, ptr %48, align 2, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 1, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 1, metadata !189, metadata !DIExpression()), !dbg !256
  %49 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 1, !dbg !253
  %50 = load i8, ptr %49, align 1, !dbg !253, !tbaa !257
  %51 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 1, !dbg !258
  store i8 %50, ptr %51, align 1, !dbg !259, !tbaa !257
  %52 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 1, !dbg !260
  %53 = load i8, ptr %52, align 1, !dbg !260, !tbaa !257
  %54 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 1, !dbg !261
  store i8 %53, ptr %54, align 1, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 2, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 2, metadata !189, metadata !DIExpression()), !dbg !256
  %55 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 2, !dbg !253
  %56 = load i8, ptr %55, align 1, !dbg !253, !tbaa !257
  %57 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 2, !dbg !258
  store i8 %56, ptr %57, align 2, !dbg !259, !tbaa !257
  %58 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 2, !dbg !260
  %59 = load i8, ptr %58, align 1, !dbg !260, !tbaa !257
  %60 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 2, !dbg !261
  store i8 %59, ptr %60, align 4, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 3, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 3, metadata !189, metadata !DIExpression()), !dbg !256
  %61 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 3, !dbg !253
  %62 = load i8, ptr %61, align 1, !dbg !253, !tbaa !257
  %63 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 3, !dbg !258
  store i8 %62, ptr %63, align 1, !dbg !259, !tbaa !257
  %64 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 3, !dbg !260
  %65 = load i8, ptr %64, align 1, !dbg !260, !tbaa !257
  %66 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 3, !dbg !261
  store i8 %65, ptr %66, align 1, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 4, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 4, metadata !189, metadata !DIExpression()), !dbg !256
  %67 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 4, !dbg !253
  %68 = load i8, ptr %67, align 1, !dbg !253, !tbaa !257
  %69 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 4, !dbg !258
  store i8 %68, ptr %69, align 4, !dbg !259, !tbaa !257
  %70 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 4, !dbg !260
  %71 = load i8, ptr %70, align 1, !dbg !260, !tbaa !257
  %72 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 4, !dbg !261
  store i8 %71, ptr %72, align 2, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 5, metadata !189, metadata !DIExpression()), !dbg !256
  call void @llvm.dbg.value(metadata i64 5, metadata !189, metadata !DIExpression()), !dbg !256
  %73 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 5, !dbg !253
  %74 = load i8, ptr %73, align 1, !dbg !253, !tbaa !257
  %75 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 5, !dbg !258
  store i8 %74, ptr %75, align 1, !dbg !259, !tbaa !257
  %76 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 5, !dbg !260
  %77 = load i8, ptr %76, align 1, !dbg !260, !tbaa !257
  %78 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 5, !dbg !261
  store i8 %77, ptr %78, align 1, !dbg !262, !tbaa !257
  call void @llvm.dbg.value(metadata i64 6, metadata !189, metadata !DIExpression()), !dbg !256
  %79 = call i64 inttoptr (i64 25 to ptr)(ptr noundef nonnull %0, ptr noundef nonnull @packet_info_map, i64 noundef 4294967295, ptr noundef nonnull %2, i64 noundef 28) #5, !dbg !263
  br label %80, !dbg !264

80:                                               ; preds = %32, %29, %43
  call void @llvm.lifetime.end.p0(i64 28, ptr nonnull %2) #5, !dbg !265
  br label %81

81:                                               ; preds = %80, %16, %12, %1
  ret i32 2, !dbg !265
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #4

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nocallback nofree nounwind willreturn writeonly }
attributes #4 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!81, !82, !83, !84}
!llvm.ident = !{!85}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "packet_info_map", scope: !2, file: !3, line: 24, type: !73, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 15.0.7", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !52, globals: !58, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "net-logger.ebpf.c", directory: "/home/adam/netlogger-ebpf", checksumkind: CSK_MD5, checksum: "df94b1dd6823bc2d1fdd715b4699b517")
!4 = !{!5, !14, !46}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 6052, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "9c93a8425305158b421c8b0ca02738ae")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !15, line: 40, baseType: !7, size: 32, elements: !16)
!15 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "", checksumkind: CSK_MD5, checksum: "b19632dbf3144fab79301e846e1f6726")
!16 = !{!17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43, !44, !45}
!17 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!18 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!19 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!20 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!21 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!22 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!23 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!24 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!25 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!26 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!27 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!28 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!29 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!30 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!31 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!32 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!33 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!34 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!35 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!36 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!37 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!38 = !DIEnumerator(name: "IPPROTO_L2TP", value: 115)
!39 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!40 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!41 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!42 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!43 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!44 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!45 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!46 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 5720, baseType: !47, size: 64, elements: !48)
!47 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!48 = !{!49, !50, !51}
!49 = !DIEnumerator(name: "BPF_F_INDEX_MASK", value: 4294967295, isUnsigned: true)
!50 = !DIEnumerator(name: "BPF_F_CURRENT_CPU", value: 4294967295, isUnsigned: true)
!51 = !DIEnumerator(name: "BPF_F_CTXLEN_MASK", value: 4503595332403200, isUnsigned: true)
!52 = !{!53, !54, !55}
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!54 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !56, line: 24, baseType: !57)
!56 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!57 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!58 = !{!59, !0, !65}
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 76, type: !61, isLocal: false, isDefinition: true)
!61 = !DICompositeType(tag: DW_TAG_array_type, baseType: !62, size: 32, elements: !63)
!62 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!63 = !{!64}
!64 = !DISubrange(count: 4)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !67, line: 696, type: !68, isLocal: true, isDefinition: true)
!67 = !DIFile(filename: "./libbpf/src/bpf_helper_defs.h", directory: "/home/adam/netlogger-ebpf", checksumkind: CSK_MD5, checksum: "6103e0e453f30c696884072404f9b37d")
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DISubroutineType(types: !70)
!70 = !{!54, !53, !53, !71, !53, !71}
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !56, line: 31, baseType: !72)
!72 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!73 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 20, size: 192, elements: !74)
!74 = !{!75, !79, !80}
!75 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !73, file: !3, line: 21, baseType: !76, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!77 = !DICompositeType(tag: DW_TAG_array_type, baseType: !78, size: 128, elements: !63)
!78 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !73, file: !3, line: 22, baseType: !76, size: 64, offset: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !73, file: !3, line: 23, baseType: !76, size: 64, offset: 128)
!81 = !{i32 7, !"Dwarf Version", i32 5}
!82 = !{i32 2, !"Debug Info Version", i32 3}
!83 = !{i32 1, !"wchar_size", i32 4}
!84 = !{i32 7, !"frame-pointer", i32 2}
!85 = !{!"clang version 15.0.7"}
!86 = distinct !DISubprogram(name: "packet_info_prog", scope: !3, file: !3, line: 27, type: !87, scopeLine: 27, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !99)
!87 = !DISubroutineType(types: !88)
!88 = !{!78, !89}
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 6063, size: 192, elements: !91)
!91 = !{!92, !94, !95, !96, !97, !98}
!92 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !90, file: !6, line: 6064, baseType: !93, size: 32)
!93 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !56, line: 27, baseType: !7)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !90, file: !6, line: 6065, baseType: !93, size: 32, offset: 32)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !90, file: !6, line: 6066, baseType: !93, size: 32, offset: 64)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !90, file: !6, line: 6068, baseType: !93, size: 32, offset: 96)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !90, file: !6, line: 6069, baseType: !93, size: 32, offset: 128)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !90, file: !6, line: 6071, baseType: !93, size: 32, offset: 160)
!99 = !{!100, !101, !102, !103, !117, !141, !142, !152, !178, !189}
!100 = !DILocalVariable(name: "ctx", arg: 1, scope: !86, file: !3, line: 27, type: !89)
!101 = !DILocalVariable(name: "data", scope: !86, file: !3, line: 28, type: !53)
!102 = !DILocalVariable(name: "data_end", scope: !86, file: !3, line: 29, type: !53)
!103 = !DILocalVariable(name: "eth", scope: !86, file: !3, line: 31, type: !104)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !106, line: 173, size: 112, elements: !107)
!106 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!107 = !{!108, !113, !114}
!108 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !105, file: !106, line: 174, baseType: !109, size: 48)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !110, size: 48, elements: !111)
!110 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!111 = !{!112}
!112 = !DISubrange(count: 6)
!113 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !105, file: !106, line: 175, baseType: !109, size: 48, offset: 48)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !105, file: !106, line: 176, baseType: !115, size: 16, offset: 96)
!115 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !116, line: 28, baseType: !55)
!116 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "64bcf4b731906682de6e750679b9f4a2")
!117 = !DILocalVariable(name: "iph", scope: !86, file: !3, line: 38, type: !118)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !120, line: 44, size: 160, elements: !121)
!120 = !DIFile(filename: "/usr/include/netinet/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "dfda1c4995d671533981865d28817074")
!121 = !{!122, !123, !124, !129, !132, !133, !134, !135, !136, !137, !140}
!122 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !119, file: !120, line: 47, baseType: !7, size: 4, flags: DIFlagBitField, extraData: i64 0)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !119, file: !120, line: 48, baseType: !7, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !119, file: !120, line: 55, baseType: !125, size: 8, offset: 8)
!125 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !126, line: 24, baseType: !127)
!126 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "4ecee94d7257cd86659727d06a979b60")
!127 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !128, line: 38, baseType: !110)
!128 = !DIFile(filename: "/usr/include/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "4a64d909bcfa62a0a7682c3ac78c6965")
!129 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !119, file: !120, line: 56, baseType: !130, size: 16, offset: 16)
!130 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !126, line: 25, baseType: !131)
!131 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !128, line: 40, baseType: !57)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !119, file: !120, line: 57, baseType: !130, size: 16, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !119, file: !120, line: 58, baseType: !130, size: 16, offset: 48)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !119, file: !120, line: 59, baseType: !125, size: 8, offset: 64)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !119, file: !120, line: 60, baseType: !125, size: 8, offset: 72)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !119, file: !120, line: 61, baseType: !130, size: 16, offset: 80)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !119, file: !120, line: 62, baseType: !138, size: 32, offset: 96)
!138 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !126, line: 26, baseType: !139)
!139 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !128, line: 42, baseType: !7)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !119, file: !120, line: 63, baseType: !138, size: 32, offset: 128)
!141 = !DILocalVariable(name: "key", scope: !86, file: !3, line: 42, type: !93)
!142 = !DILocalVariable(name: "pkt_info", scope: !86, file: !3, line: 43, type: !143)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "packet_info", file: !3, line: 10, size: 224, elements: !144)
!144 = !{!145, !146, !147, !148, !149, !150, !151}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !143, file: !3, line: 11, baseType: !55, size: 16)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip", scope: !143, file: !3, line: 12, baseType: !93, size: 32, offset: 32)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip", scope: !143, file: !3, line: 13, baseType: !93, size: 32, offset: 64)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "eth_src", scope: !143, file: !3, line: 14, baseType: !109, size: 48, offset: 96)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "eth_dst", scope: !143, file: !3, line: 15, baseType: !109, size: 48, offset: 144)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !143, file: !3, line: 16, baseType: !55, size: 16, offset: 192)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !143, file: !3, line: 17, baseType: !55, size: 16, offset: 208)
!152 = !DILocalVariable(name: "tcph", scope: !153, file: !3, line: 50, type: !155)
!153 = distinct !DILexicalBlock(scope: !154, file: !3, line: 49, column: 39)
!154 = distinct !DILexicalBlock(scope: !86, file: !3, line: 49, column: 9)
!155 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !156, size: 64)
!156 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !157, line: 25, size: 160, elements: !158)
!157 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!158 = !{!159, !160, !161, !163, !164, !165, !166, !167, !168, !169, !170, !171, !172, !173, !174, !175, !177}
!159 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !156, file: !157, line: 26, baseType: !115, size: 16)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !156, file: !157, line: 27, baseType: !115, size: 16, offset: 16)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !156, file: !157, line: 28, baseType: !162, size: 32, offset: 32)
!162 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !116, line: 30, baseType: !93)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !156, file: !157, line: 29, baseType: !162, size: 32, offset: 64)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !156, file: !157, line: 31, baseType: !55, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !156, file: !157, line: 32, baseType: !55, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !156, file: !157, line: 33, baseType: !55, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!167 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !156, file: !157, line: 34, baseType: !55, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !156, file: !157, line: 35, baseType: !55, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !156, file: !157, line: 36, baseType: !55, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !156, file: !157, line: 37, baseType: !55, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !156, file: !157, line: 38, baseType: !55, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !156, file: !157, line: 39, baseType: !55, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !156, file: !157, line: 40, baseType: !55, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !156, file: !157, line: 55, baseType: !115, size: 16, offset: 112)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !156, file: !157, line: 56, baseType: !176, size: 16, offset: 128)
!176 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !116, line: 34, baseType: !55)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !156, file: !157, line: 57, baseType: !115, size: 16, offset: 144)
!178 = !DILocalVariable(name: "udph", scope: !179, file: !3, line: 59, type: !181)
!179 = distinct !DILexicalBlock(scope: !180, file: !3, line: 58, column: 44)
!180 = distinct !DILexicalBlock(scope: !154, file: !3, line: 58, column: 14)
!181 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !182, size: 64)
!182 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !183, line: 23, size: 64, elements: !184)
!183 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "", checksumkind: CSK_MD5, checksum: "53c0d42e1bf6d93b39151764be2d20fb")
!184 = !{!185, !186, !187, !188}
!185 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !182, file: !183, line: 24, baseType: !115, size: 16)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !182, file: !183, line: 25, baseType: !115, size: 16, offset: 16)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !182, file: !183, line: 26, baseType: !115, size: 16, offset: 32)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !182, file: !183, line: 27, baseType: !176, size: 16, offset: 48)
!189 = !DILocalVariable(name: "i", scope: !190, file: !3, line: 67, type: !78)
!190 = distinct !DILexicalBlock(scope: !86, file: !3, line: 67, column: 5)
!191 = !DILocation(line: 0, scope: !86)
!192 = !DILocation(line: 28, column: 37, scope: !86)
!193 = !{!194, !195, i64 0}
!194 = !{!"xdp_md", !195, i64 0, !195, i64 4, !195, i64 8, !195, i64 12, !195, i64 16, !195, i64 20}
!195 = !{!"int", !196, i64 0}
!196 = !{!"omnipotent char", !197, i64 0}
!197 = !{!"Simple C/C++ TBAA"}
!198 = !DILocation(line: 28, column: 26, scope: !86)
!199 = !DILocation(line: 28, column: 18, scope: !86)
!200 = !DILocation(line: 29, column: 41, scope: !86)
!201 = !{!194, !195, i64 4}
!202 = !DILocation(line: 29, column: 30, scope: !86)
!203 = !DILocation(line: 29, column: 22, scope: !86)
!204 = !DILocation(line: 32, column: 14, scope: !205)
!205 = distinct !DILexicalBlock(scope: !86, file: !3, line: 32, column: 9)
!206 = !DILocation(line: 32, column: 38, scope: !205)
!207 = !DILocation(line: 32, column: 9, scope: !86)
!208 = !DILocation(line: 35, column: 9, scope: !209)
!209 = distinct !DILexicalBlock(scope: !86, file: !3, line: 35, column: 9)
!210 = !{!211, !212, i64 12}
!211 = !{!"ethhdr", !196, i64 0, !196, i64 6, !212, i64 12}
!212 = !{!"short", !196, i64 0}
!213 = !DILocation(line: 35, column: 33, scope: !209)
!214 = !DILocation(line: 35, column: 9, scope: !86)
!215 = !DILocation(line: 39, column: 38, scope: !216)
!216 = distinct !DILexicalBlock(scope: !86, file: !3, line: 39, column: 9)
!217 = !DILocation(line: 39, column: 61, scope: !216)
!218 = !DILocation(line: 39, column: 9, scope: !86)
!219 = !DILocation(line: 43, column: 5, scope: !86)
!220 = !DILocation(line: 43, column: 24, scope: !86)
!221 = !DILocation(line: 45, column: 30, scope: !86)
!222 = !{!223, !196, i64 9}
!223 = !{!"iphdr", !195, i64 0, !195, i64 0, !196, i64 1, !212, i64 2, !212, i64 4, !212, i64 6, !196, i64 8, !196, i64 9, !212, i64 10, !195, i64 12, !195, i64 16}
!224 = !DILocation(line: 45, column: 25, scope: !86)
!225 = !DILocation(line: 45, column: 23, scope: !86)
!226 = !{!227, !212, i64 0}
!227 = !{!"packet_info", !212, i64 0, !195, i64 4, !195, i64 8, !196, i64 12, !196, i64 18, !212, i64 24, !212, i64 26}
!228 = !DILocation(line: 46, column: 28, scope: !86)
!229 = !{!223, !195, i64 12}
!230 = !DILocation(line: 46, column: 14, scope: !86)
!231 = !DILocation(line: 46, column: 21, scope: !86)
!232 = !{!227, !195, i64 4}
!233 = !DILocation(line: 47, column: 28, scope: !86)
!234 = !{!223, !195, i64 16}
!235 = !DILocation(line: 47, column: 14, scope: !86)
!236 = !DILocation(line: 47, column: 21, scope: !86)
!237 = !{!227, !195, i64 8}
!238 = !DILocation(line: 49, column: 9, scope: !86)
!239 = !DILocation(line: 0, scope: !153)
!240 = !DILocation(line: 51, column: 65, scope: !241)
!241 = distinct !DILexicalBlock(scope: !153, file: !3, line: 51, column: 13)
!242 = !DILocation(line: 51, column: 89, scope: !241)
!243 = !DILocation(line: 51, column: 13, scope: !153)
!244 = !DILocation(line: 0, scope: !179)
!245 = !DILocation(line: 60, column: 65, scope: !246)
!246 = distinct !DILexicalBlock(scope: !179, file: !3, line: 60, column: 13)
!247 = !DILocation(line: 60, column: 89, scope: !246)
!248 = !DILocation(line: 60, column: 13, scope: !179)
!249 = !DILocation(line: 0, scope: !154)
!250 = !{!212, !212, i64 0}
!251 = !{!227, !212, i64 24}
!252 = !{!227, !212, i64 26}
!253 = !DILocation(line: 68, column: 31, scope: !254)
!254 = distinct !DILexicalBlock(scope: !255, file: !3, line: 67, column: 33)
!255 = distinct !DILexicalBlock(scope: !190, file: !3, line: 67, column: 5)
!256 = !DILocation(line: 0, scope: !190)
!257 = !{!196, !196, i64 0}
!258 = !DILocation(line: 68, column: 9, scope: !254)
!259 = !DILocation(line: 68, column: 29, scope: !254)
!260 = !DILocation(line: 69, column: 31, scope: !254)
!261 = !DILocation(line: 69, column: 9, scope: !254)
!262 = !DILocation(line: 69, column: 29, scope: !254)
!263 = !DILocation(line: 72, column: 5, scope: !86)
!264 = !DILocation(line: 73, column: 5, scope: !86)
!265 = !DILocation(line: 74, column: 1, scope: !86)
