; ModuleID = 'net-logger.ebpf.c'
source_filename = "net-logger.ebpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon.1 = type { ptr, ptr, ptr }
%struct.packet_info = type { i16, i32, i32, [6 x i8], [6 x i8], i16, i16 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@packet_info_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !53
@llvm.compiler.used = appending global [3 x ptr] [ptr @_license, ptr @packet_info_map, ptr @packet_info_prog], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @packet_info_prog(ptr noundef %0) #0 section "xdp" !dbg !80 {
  %2 = alloca %struct.packet_info, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !93, metadata !DIExpression()), !dbg !154
  %3 = load i32, ptr %0, align 4, !dbg !155, !tbaa !156
  %4 = zext i32 %3 to i64, !dbg !161
  %5 = inttoptr i64 %4 to ptr, !dbg !162
  call void @llvm.dbg.value(metadata ptr %5, metadata !96, metadata !DIExpression()), !dbg !154
  %6 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !163
  %7 = load i32, ptr %6, align 4, !dbg !163, !tbaa !164
  %8 = zext i32 %7 to i64, !dbg !165
  %9 = inttoptr i64 %8 to ptr, !dbg !166
  call void @llvm.dbg.value(metadata ptr %9, metadata !97, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.value(metadata ptr %5, metadata !98, metadata !DIExpression()), !dbg !154
  %10 = getelementptr i8, ptr %5, i64 14, !dbg !167
  %11 = icmp ugt ptr %10, %9, !dbg !169
  br i1 %11, label %78, label %12, !dbg !170

12:                                               ; preds = %1
  %13 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 2, !dbg !171
  %14 = load i16, ptr %13, align 1, !dbg !171, !tbaa !173
  %15 = icmp ne i16 %14, 8, !dbg !176
  %16 = getelementptr i8, ptr %5, i64 34
  %17 = icmp ugt ptr %16, %9
  %18 = select i1 %15, i1 true, i1 %17, !dbg !177
  call void @llvm.dbg.value(metadata ptr %10, metadata !110, metadata !DIExpression()), !dbg !154
  br i1 %18, label %78, label %19, !dbg !177

19:                                               ; preds = %12
  %20 = getelementptr i8, ptr %5, i64 23, !dbg !178
  %21 = load i8, ptr %20, align 1, !dbg !178, !tbaa !179
  %22 = icmp eq i8 %21, 6, !dbg !181
  br i1 %22, label %23, label %29, !dbg !182

23:                                               ; preds = %19
  call void @llvm.dbg.value(metadata ptr %16, metadata !138, metadata !DIExpression()), !dbg !183
  %24 = load i16, ptr %16, align 4, !dbg !184, !tbaa !185
  %25 = tail call i16 @llvm.bswap.i16(i16 %24), !dbg !184
  call void @llvm.dbg.value(metadata i16 %25, metadata !94, metadata !DIExpression()), !dbg !154
  %26 = getelementptr i8, ptr %5, i64 36, !dbg !187
  %27 = load i16, ptr %26, align 2, !dbg !187, !tbaa !188
  %28 = tail call i16 @llvm.bswap.i16(i16 %27), !dbg !187
  call void @llvm.dbg.value(metadata i16 %28, metadata !95, metadata !DIExpression()), !dbg !154
  br label %29, !dbg !189

29:                                               ; preds = %23, %19
  %30 = phi i16 [ %28, %23 ], [ undef, %19 ]
  %31 = phi i16 [ %25, %23 ], [ undef, %19 ]
  call void @llvm.dbg.value(metadata i16 %31, metadata !94, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.value(metadata i16 %30, metadata !95, metadata !DIExpression()), !dbg !154
  call void @llvm.dbg.value(metadata i32 0, metadata !141, metadata !DIExpression()), !dbg !154
  call void @llvm.lifetime.start.p0(i64 28, ptr nonnull %2) #4, !dbg !190
  call void @llvm.dbg.declare(metadata ptr %2, metadata !142, metadata !DIExpression()), !dbg !191
  store i32 0, ptr %2, align 4, !dbg !191
  %32 = load i8, ptr %20, align 1, !dbg !192, !tbaa !179
  %33 = zext i8 %32 to i16, !dbg !193
  store i16 %33, ptr %2, align 4, !dbg !194, !tbaa !195
  %34 = getelementptr i8, ptr %5, i64 26, !dbg !197
  %35 = load i32, ptr %34, align 4, !dbg !197, !tbaa !198
  %36 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 1, !dbg !199
  store i32 %35, ptr %36, align 4, !dbg !200, !tbaa !201
  %37 = getelementptr i8, ptr %5, i64 30, !dbg !202
  %38 = load i32, ptr %37, align 4, !dbg !202, !tbaa !198
  %39 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 2, !dbg !203
  store i32 %38, ptr %39, align 4, !dbg !204, !tbaa !205
  %40 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 5, !dbg !206
  store i16 %31, ptr %40, align 4, !dbg !207, !tbaa !208
  %41 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 6, !dbg !209
  store i16 %30, ptr %41, align 2, !dbg !210, !tbaa !211
  call void @llvm.dbg.value(metadata i32 0, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 0, metadata !152, metadata !DIExpression()), !dbg !212
  %42 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 0, !dbg !213
  %43 = load i8, ptr %42, align 1, !dbg !213, !tbaa !198
  %44 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 0, !dbg !216
  store i8 %43, ptr %44, align 4, !dbg !217, !tbaa !198
  %45 = load i8, ptr %5, align 1, !dbg !218, !tbaa !198
  %46 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 0, !dbg !219
  store i8 %45, ptr %46, align 2, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 1, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 1, metadata !152, metadata !DIExpression()), !dbg !212
  %47 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 1, !dbg !213
  %48 = load i8, ptr %47, align 1, !dbg !213, !tbaa !198
  %49 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 1, !dbg !216
  store i8 %48, ptr %49, align 1, !dbg !217, !tbaa !198
  %50 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 1, !dbg !218
  %51 = load i8, ptr %50, align 1, !dbg !218, !tbaa !198
  %52 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 1, !dbg !219
  store i8 %51, ptr %52, align 1, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 2, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 2, metadata !152, metadata !DIExpression()), !dbg !212
  %53 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 2, !dbg !213
  %54 = load i8, ptr %53, align 1, !dbg !213, !tbaa !198
  %55 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 2, !dbg !216
  store i8 %54, ptr %55, align 2, !dbg !217, !tbaa !198
  %56 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 2, !dbg !218
  %57 = load i8, ptr %56, align 1, !dbg !218, !tbaa !198
  %58 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 2, !dbg !219
  store i8 %57, ptr %58, align 4, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 3, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 3, metadata !152, metadata !DIExpression()), !dbg !212
  %59 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 3, !dbg !213
  %60 = load i8, ptr %59, align 1, !dbg !213, !tbaa !198
  %61 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 3, !dbg !216
  store i8 %60, ptr %61, align 1, !dbg !217, !tbaa !198
  %62 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 3, !dbg !218
  %63 = load i8, ptr %62, align 1, !dbg !218, !tbaa !198
  %64 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 3, !dbg !219
  store i8 %63, ptr %64, align 1, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 4, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 4, metadata !152, metadata !DIExpression()), !dbg !212
  %65 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 4, !dbg !213
  %66 = load i8, ptr %65, align 1, !dbg !213, !tbaa !198
  %67 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 4, !dbg !216
  store i8 %66, ptr %67, align 4, !dbg !217, !tbaa !198
  %68 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 4, !dbg !218
  %69 = load i8, ptr %68, align 1, !dbg !218, !tbaa !198
  %70 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 4, !dbg !219
  store i8 %69, ptr %70, align 2, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 5, metadata !152, metadata !DIExpression()), !dbg !212
  call void @llvm.dbg.value(metadata i64 5, metadata !152, metadata !DIExpression()), !dbg !212
  %71 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 5, !dbg !213
  %72 = load i8, ptr %71, align 1, !dbg !213, !tbaa !198
  %73 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 5, !dbg !216
  store i8 %72, ptr %73, align 1, !dbg !217, !tbaa !198
  %74 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 5, !dbg !218
  %75 = load i8, ptr %74, align 1, !dbg !218, !tbaa !198
  %76 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 5, !dbg !219
  store i8 %75, ptr %76, align 1, !dbg !220, !tbaa !198
  call void @llvm.dbg.value(metadata i64 6, metadata !152, metadata !DIExpression()), !dbg !212
  %77 = call i64 inttoptr (i64 25 to ptr)(ptr noundef nonnull %0, ptr noundef nonnull @packet_info_map, i64 noundef 4294967295, ptr noundef nonnull %2, i64 noundef 28) #4, !dbg !221
  call void @llvm.lifetime.end.p0(i64 28, ptr nonnull %2) #4, !dbg !222
  br label %78

78:                                               ; preds = %29, %12, %1
  ret i32 2, !dbg !222
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i16 @llvm.bswap.i16(i16) #1

; Function Attrs: argmemonly mustprogress nocallback nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #3

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nocallback nofree nosync nounwind willreturn }
attributes #3 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!75, !76, !77, !78}
!llvm.ident = !{!79}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "packet_info_map", scope: !2, file: !3, line: 25, type: !67, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 15.0.7", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !20, globals: !52, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "net-logger.ebpf.c", directory: "/home/adam/raf-ebpf", checksumkind: CSK_MD5, checksum: "207bde9957229164cbee5c0005429e08")
!4 = !{!5, !14}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 6052, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "/usr/include/linux/bpf.h", directory: "", checksumkind: CSK_MD5, checksum: "9c93a8425305158b421c8b0ca02738ae")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 5720, baseType: !15, size: 64, elements: !16)
!15 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!16 = !{!17, !18, !19}
!17 = !DIEnumerator(name: "BPF_F_INDEX_MASK", value: 4294967295, isUnsigned: true)
!18 = !DIEnumerator(name: "BPF_F_CURRENT_CPU", value: 4294967295, isUnsigned: true)
!19 = !DIEnumerator(name: "BPF_F_CTXLEN_MASK", value: 4503595332403200, isUnsigned: true)
!20 = !{!21, !22, !23, !26}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !24, line: 24, baseType: !25)
!24 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!25 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !27, size: 64)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !28, line: 25, size: 160, elements: !29)
!28 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!29 = !{!30, !33, !34, !37, !38, !39, !40, !41, !42, !43, !44, !45, !46, !47, !48, !49, !51}
!30 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !27, file: !28, line: 26, baseType: !31, size: 16)
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !32, line: 28, baseType: !23)
!32 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "64bcf4b731906682de6e750679b9f4a2")
!33 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !27, file: !28, line: 27, baseType: !31, size: 16, offset: 16)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !27, file: !28, line: 28, baseType: !35, size: 32, offset: 32)
!35 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !32, line: 30, baseType: !36)
!36 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !24, line: 27, baseType: !7)
!37 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !27, file: !28, line: 29, baseType: !35, size: 32, offset: 64)
!38 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !27, file: !28, line: 31, baseType: !23, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!39 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !27, file: !28, line: 32, baseType: !23, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!40 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !27, file: !28, line: 33, baseType: !23, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!41 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !27, file: !28, line: 34, baseType: !23, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!42 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !27, file: !28, line: 35, baseType: !23, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!43 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !27, file: !28, line: 36, baseType: !23, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!44 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !27, file: !28, line: 37, baseType: !23, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!45 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !27, file: !28, line: 38, baseType: !23, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!46 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !27, file: !28, line: 39, baseType: !23, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !27, file: !28, line: 40, baseType: !23, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !27, file: !28, line: 55, baseType: !31, size: 16, offset: 112)
!49 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !27, file: !28, line: 56, baseType: !50, size: 16, offset: 128)
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !32, line: 34, baseType: !23)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !27, file: !28, line: 57, baseType: !31, size: 16, offset: 144)
!52 = !{!53, !0, !59}
!53 = !DIGlobalVariableExpression(var: !54, expr: !DIExpression())
!54 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 69, type: !55, isLocal: false, isDefinition: true)
!55 = !DICompositeType(tag: DW_TAG_array_type, baseType: !56, size: 32, elements: !57)
!56 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!57 = !{!58}
!58 = !DISubrange(count: 4)
!59 = !DIGlobalVariableExpression(var: !60, expr: !DIExpression())
!60 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !61, line: 696, type: !62, isLocal: true, isDefinition: true)
!61 = !DIFile(filename: "./libbpf/src/bpf_helper_defs.h", directory: "/home/adam/raf-ebpf", checksumkind: CSK_MD5, checksum: "6103e0e453f30c696884072404f9b37d")
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!63 = !DISubroutineType(types: !64)
!64 = !{!22, !21, !21, !65, !21, !65}
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !24, line: 31, baseType: !66)
!66 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!67 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 21, size: 192, elements: !68)
!68 = !{!69, !73, !74}
!69 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !67, file: !3, line: 22, baseType: !70, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DICompositeType(tag: DW_TAG_array_type, baseType: !72, size: 128, elements: !57)
!72 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !67, file: !3, line: 23, baseType: !70, size: 64, offset: 64)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !67, file: !3, line: 24, baseType: !70, size: 64, offset: 128)
!75 = !{i32 7, !"Dwarf Version", i32 5}
!76 = !{i32 2, !"Debug Info Version", i32 3}
!77 = !{i32 1, !"wchar_size", i32 4}
!78 = !{i32 7, !"frame-pointer", i32 2}
!79 = !{!"clang version 15.0.7"}
!80 = distinct !DISubprogram(name: "packet_info_prog", scope: !3, file: !3, line: 29, type: !81, scopeLine: 29, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !92)
!81 = !DISubroutineType(types: !82)
!82 = !{!72, !83}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!84 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 6063, size: 192, elements: !85)
!85 = !{!86, !87, !88, !89, !90, !91}
!86 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !84, file: !6, line: 6064, baseType: !36, size: 32)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !84, file: !6, line: 6065, baseType: !36, size: 32, offset: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !84, file: !6, line: 6066, baseType: !36, size: 32, offset: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !84, file: !6, line: 6068, baseType: !36, size: 32, offset: 96)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !84, file: !6, line: 6069, baseType: !36, size: 32, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !84, file: !6, line: 6071, baseType: !36, size: 32, offset: 160)
!92 = !{!93, !94, !95, !96, !97, !98, !110, !138, !141, !142, !152}
!93 = !DILocalVariable(name: "ctx", arg: 1, scope: !80, file: !3, line: 29, type: !83)
!94 = !DILocalVariable(name: "src_port", scope: !80, file: !3, line: 30, type: !23)
!95 = !DILocalVariable(name: "dst_port", scope: !80, file: !3, line: 30, type: !23)
!96 = !DILocalVariable(name: "data", scope: !80, file: !3, line: 31, type: !21)
!97 = !DILocalVariable(name: "data_end", scope: !80, file: !3, line: 32, type: !21)
!98 = !DILocalVariable(name: "eth", scope: !80, file: !3, line: 34, type: !99)
!99 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !100, size: 64)
!100 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !101, line: 173, size: 112, elements: !102)
!101 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!102 = !{!103, !108, !109}
!103 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !100, file: !101, line: 174, baseType: !104, size: 48)
!104 = !DICompositeType(tag: DW_TAG_array_type, baseType: !105, size: 48, elements: !106)
!105 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!106 = !{!107}
!107 = !DISubrange(count: 6)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !100, file: !101, line: 175, baseType: !104, size: 48, offset: 48)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !100, file: !101, line: 176, baseType: !31, size: 16, offset: 96)
!110 = !DILocalVariable(name: "iph", scope: !80, file: !3, line: 41, type: !111)
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!112 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !113, line: 86, size: 160, elements: !114)
!113 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "fbdafb4648dd1c838bddfe5d71e3770a")
!114 = !{!115, !117, !118, !119, !120, !121, !122, !123, !124, !125}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !112, file: !113, line: 88, baseType: !116, size: 4, flags: DIFlagBitField, extraData: i64 0)
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !24, line: 21, baseType: !105)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !112, file: !113, line: 89, baseType: !116, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !112, file: !113, line: 96, baseType: !116, size: 8, offset: 8)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !112, file: !113, line: 97, baseType: !31, size: 16, offset: 16)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !112, file: !113, line: 98, baseType: !31, size: 16, offset: 32)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !112, file: !113, line: 99, baseType: !31, size: 16, offset: 48)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !112, file: !113, line: 100, baseType: !116, size: 8, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !112, file: !113, line: 101, baseType: !116, size: 8, offset: 72)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !112, file: !113, line: 102, baseType: !50, size: 16, offset: 80)
!125 = !DIDerivedType(tag: DW_TAG_member, scope: !112, file: !113, line: 103, baseType: !126, size: 64, offset: 96)
!126 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !112, file: !113, line: 103, size: 64, elements: !127)
!127 = !{!128, !133}
!128 = !DIDerivedType(tag: DW_TAG_member, scope: !126, file: !113, line: 103, baseType: !129, size: 64)
!129 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !126, file: !113, line: 103, size: 64, elements: !130)
!130 = !{!131, !132}
!131 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !129, file: !113, line: 103, baseType: !35, size: 32)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !129, file: !113, line: 103, baseType: !35, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !126, file: !113, line: 103, baseType: !134, size: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !126, file: !113, line: 103, size: 64, elements: !135)
!135 = !{!136, !137}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !134, file: !113, line: 103, baseType: !35, size: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !134, file: !113, line: 103, baseType: !35, size: 32, offset: 32)
!138 = !DILocalVariable(name: "tcph", scope: !139, file: !3, line: 46, type: !26)
!139 = distinct !DILexicalBlock(scope: !140, file: !3, line: 45, column: 29)
!140 = distinct !DILexicalBlock(scope: !80, file: !3, line: 45, column: 9)
!141 = !DILocalVariable(name: "key", scope: !80, file: !3, line: 51, type: !36)
!142 = !DILocalVariable(name: "pkt_info", scope: !80, file: !3, line: 52, type: !143)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "packet_info", file: !3, line: 11, size: 224, elements: !144)
!144 = !{!145, !146, !147, !148, !149, !150, !151}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !143, file: !3, line: 13, baseType: !23, size: 16)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip", scope: !143, file: !3, line: 14, baseType: !36, size: 32, offset: 32)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip", scope: !143, file: !3, line: 15, baseType: !36, size: 32, offset: 64)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "eth_src", scope: !143, file: !3, line: 16, baseType: !104, size: 48, offset: 96)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "eth_dst", scope: !143, file: !3, line: 17, baseType: !104, size: 48, offset: 144)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !143, file: !3, line: 18, baseType: !23, size: 16, offset: 192)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !143, file: !3, line: 19, baseType: !23, size: 16, offset: 208)
!152 = !DILocalVariable(name: "i", scope: !153, file: !3, line: 60, type: !72)
!153 = distinct !DILexicalBlock(scope: !80, file: !3, line: 60, column: 5)
!154 = !DILocation(line: 0, scope: !80)
!155 = !DILocation(line: 31, column: 37, scope: !80)
!156 = !{!157, !158, i64 0}
!157 = !{!"xdp_md", !158, i64 0, !158, i64 4, !158, i64 8, !158, i64 12, !158, i64 16, !158, i64 20}
!158 = !{!"int", !159, i64 0}
!159 = !{!"omnipotent char", !160, i64 0}
!160 = !{!"Simple C/C++ TBAA"}
!161 = !DILocation(line: 31, column: 26, scope: !80)
!162 = !DILocation(line: 31, column: 18, scope: !80)
!163 = !DILocation(line: 32, column: 41, scope: !80)
!164 = !{!157, !158, i64 4}
!165 = !DILocation(line: 32, column: 30, scope: !80)
!166 = !DILocation(line: 32, column: 22, scope: !80)
!167 = !DILocation(line: 35, column: 14, scope: !168)
!168 = distinct !DILexicalBlock(scope: !80, file: !3, line: 35, column: 9)
!169 = !DILocation(line: 35, column: 38, scope: !168)
!170 = !DILocation(line: 35, column: 9, scope: !80)
!171 = !DILocation(line: 38, column: 9, scope: !172)
!172 = distinct !DILexicalBlock(scope: !80, file: !3, line: 38, column: 9)
!173 = !{!174, !175, i64 12}
!174 = !{!"ethhdr", !159, i64 0, !159, i64 6, !175, i64 12}
!175 = !{!"short", !159, i64 0}
!176 = !DILocation(line: 38, column: 33, scope: !172)
!177 = !DILocation(line: 38, column: 9, scope: !80)
!178 = !DILocation(line: 45, column: 14, scope: !140)
!179 = !{!180, !159, i64 9}
!180 = !{!"iphdr", !159, i64 0, !159, i64 0, !159, i64 1, !175, i64 2, !175, i64 4, !175, i64 6, !159, i64 8, !159, i64 9, !175, i64 10, !159, i64 12}
!181 = !DILocation(line: 45, column: 23, scope: !140)
!182 = !DILocation(line: 45, column: 9, scope: !80)
!183 = !DILocation(line: 0, scope: !139)
!184 = !DILocation(line: 47, column: 20, scope: !139)
!185 = !{!186, !175, i64 0}
!186 = !{!"tcphdr", !175, i64 0, !175, i64 2, !158, i64 4, !158, i64 8, !175, i64 12, !175, i64 12, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 13, !175, i64 14, !175, i64 16, !175, i64 18}
!187 = !DILocation(line: 48, column: 20, scope: !139)
!188 = !{!186, !175, i64 2}
!189 = !DILocation(line: 49, column: 5, scope: !139)
!190 = !DILocation(line: 52, column: 5, scope: !80)
!191 = !DILocation(line: 52, column: 24, scope: !80)
!192 = !DILocation(line: 54, column: 30, scope: !80)
!193 = !DILocation(line: 54, column: 25, scope: !80)
!194 = !DILocation(line: 54, column: 23, scope: !80)
!195 = !{!196, !175, i64 0}
!196 = !{!"packet_info", !175, i64 0, !158, i64 4, !158, i64 8, !159, i64 12, !159, i64 18, !175, i64 24, !175, i64 26}
!197 = !DILocation(line: 55, column: 28, scope: !80)
!198 = !{!159, !159, i64 0}
!199 = !DILocation(line: 55, column: 14, scope: !80)
!200 = !DILocation(line: 55, column: 21, scope: !80)
!201 = !{!196, !158, i64 4}
!202 = !DILocation(line: 56, column: 28, scope: !80)
!203 = !DILocation(line: 56, column: 14, scope: !80)
!204 = !DILocation(line: 56, column: 21, scope: !80)
!205 = !{!196, !158, i64 8}
!206 = !DILocation(line: 57, column: 14, scope: !80)
!207 = !DILocation(line: 57, column: 23, scope: !80)
!208 = !{!196, !175, i64 24}
!209 = !DILocation(line: 58, column: 14, scope: !80)
!210 = !DILocation(line: 58, column: 23, scope: !80)
!211 = !{!196, !175, i64 26}
!212 = !DILocation(line: 0, scope: !153)
!213 = !DILocation(line: 61, column: 27, scope: !214)
!214 = distinct !DILexicalBlock(scope: !215, file: !3, line: 60, column: 33)
!215 = distinct !DILexicalBlock(scope: !153, file: !3, line: 60, column: 5)
!216 = !DILocation(line: 61, column: 5, scope: !214)
!217 = !DILocation(line: 61, column: 25, scope: !214)
!218 = !DILocation(line: 62, column: 27, scope: !214)
!219 = !DILocation(line: 62, column: 5, scope: !214)
!220 = !DILocation(line: 62, column: 25, scope: !214)
!221 = !DILocation(line: 65, column: 5, scope: !80)
!222 = !DILocation(line: 67, column: 1, scope: !80)
