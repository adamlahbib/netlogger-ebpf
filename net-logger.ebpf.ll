; ModuleID = 'net-logger.ebpf.c'
source_filename = "net-logger.ebpf.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon.1 = type { ptr, ptr, ptr }
%struct.packet_info = type { i16, i32, i32, [6 x i8], [6 x i8], i16, i16 }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }

@packet_info_map = dso_local global %struct.anon.1 zeroinitializer, section ".maps", align 8, !dbg !0
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !27
@llvm.compiler.used = appending global [3 x ptr] [ptr @_license, ptr @packet_info_map, ptr @packet_info_prog], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @packet_info_prog(ptr noundef %0) #0 section "xdp" !dbg !54 {
  %2 = alloca %struct.packet_info, align 4
  call void @llvm.dbg.value(metadata ptr %0, metadata !68, metadata !DIExpression()), !dbg !150
  %3 = load i32, ptr %0, align 4, !dbg !151, !tbaa !152
  %4 = zext i32 %3 to i64, !dbg !157
  %5 = inttoptr i64 %4 to ptr, !dbg !158
  call void @llvm.dbg.value(metadata ptr %5, metadata !69, metadata !DIExpression()), !dbg !150
  %6 = getelementptr inbounds %struct.xdp_md, ptr %0, i64 0, i32 1, !dbg !159
  %7 = load i32, ptr %6, align 4, !dbg !159, !tbaa !160
  %8 = zext i32 %7 to i64, !dbg !161
  %9 = inttoptr i64 %8 to ptr, !dbg !162
  call void @llvm.dbg.value(metadata ptr %9, metadata !70, metadata !DIExpression()), !dbg !150
  call void @llvm.dbg.value(metadata ptr %5, metadata !71, metadata !DIExpression()), !dbg !150
  %10 = getelementptr i8, ptr %5, i64 14, !dbg !163
  %11 = icmp ugt ptr %10, %9, !dbg !165
  br i1 %11, label %75, label %12, !dbg !166

12:                                               ; preds = %1
  %13 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 2, !dbg !167
  %14 = load i16, ptr %13, align 1, !dbg !167, !tbaa !169
  %15 = icmp eq i16 %14, 8, !dbg !172
  br i1 %15, label %16, label %75, !dbg !173

16:                                               ; preds = %12
  call void @llvm.dbg.value(metadata ptr %10, metadata !85, metadata !DIExpression()), !dbg !150
  %17 = getelementptr i8, ptr %5, i64 34, !dbg !174
  %18 = icmp ugt ptr %17, %9, !dbg !176
  %19 = getelementptr i8, ptr %5, i64 54
  %20 = icmp ugt ptr %19, %9
  %21 = or i1 %18, %20, !dbg !177
  call void @llvm.dbg.value(metadata ptr %17, metadata !115, metadata !DIExpression()), !dbg !150
  br i1 %21, label %75, label %22, !dbg !177

22:                                               ; preds = %16
  call void @llvm.dbg.value(metadata i32 0, metadata !137, metadata !DIExpression()), !dbg !150
  call void @llvm.lifetime.start.p0(i64 28, ptr nonnull %2) #4, !dbg !178
  call void @llvm.dbg.declare(metadata ptr %2, metadata !138, metadata !DIExpression()), !dbg !179
  store i32 0, ptr %2, align 4, !dbg !179
  %23 = getelementptr i8, ptr %5, i64 23, !dbg !180
  %24 = load i8, ptr %23, align 1, !dbg !180, !tbaa !181
  %25 = zext i8 %24 to i16, !dbg !183
  store i16 %25, ptr %2, align 4, !dbg !184, !tbaa !185
  %26 = getelementptr i8, ptr %5, i64 26, !dbg !187
  %27 = load i32, ptr %26, align 4, !dbg !187, !tbaa !188
  %28 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 1, !dbg !189
  store i32 %27, ptr %28, align 4, !dbg !190, !tbaa !191
  %29 = getelementptr i8, ptr %5, i64 30, !dbg !192
  %30 = load i32, ptr %29, align 4, !dbg !192, !tbaa !188
  %31 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 2, !dbg !193
  store i32 %30, ptr %31, align 4, !dbg !194, !tbaa !195
  %32 = load i16, ptr %17, align 4, !dbg !196, !tbaa !197
  %33 = tail call i16 @llvm.bswap.i16(i16 %32), !dbg !196
  %34 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 5, !dbg !199
  store i16 %33, ptr %34, align 4, !dbg !200, !tbaa !201
  %35 = getelementptr i8, ptr %5, i64 36, !dbg !202
  %36 = load i16, ptr %35, align 2, !dbg !202, !tbaa !203
  %37 = tail call i16 @llvm.bswap.i16(i16 %36), !dbg !202
  %38 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 6, !dbg !204
  store i16 %37, ptr %38, align 2, !dbg !205, !tbaa !206
  call void @llvm.dbg.value(metadata i32 0, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 0, metadata !148, metadata !DIExpression()), !dbg !207
  %39 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 0, !dbg !208
  %40 = load i8, ptr %39, align 1, !dbg !208, !tbaa !188
  %41 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 0, !dbg !211
  store i8 %40, ptr %41, align 4, !dbg !212, !tbaa !188
  %42 = load i8, ptr %5, align 1, !dbg !213, !tbaa !188
  %43 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 0, !dbg !214
  store i8 %42, ptr %43, align 2, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 1, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 1, metadata !148, metadata !DIExpression()), !dbg !207
  %44 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 1, !dbg !208
  %45 = load i8, ptr %44, align 1, !dbg !208, !tbaa !188
  %46 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 1, !dbg !211
  store i8 %45, ptr %46, align 1, !dbg !212, !tbaa !188
  %47 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 1, !dbg !213
  %48 = load i8, ptr %47, align 1, !dbg !213, !tbaa !188
  %49 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 1, !dbg !214
  store i8 %48, ptr %49, align 1, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 2, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 2, metadata !148, metadata !DIExpression()), !dbg !207
  %50 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 2, !dbg !208
  %51 = load i8, ptr %50, align 1, !dbg !208, !tbaa !188
  %52 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 2, !dbg !211
  store i8 %51, ptr %52, align 2, !dbg !212, !tbaa !188
  %53 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 2, !dbg !213
  %54 = load i8, ptr %53, align 1, !dbg !213, !tbaa !188
  %55 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 2, !dbg !214
  store i8 %54, ptr %55, align 4, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 3, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 3, metadata !148, metadata !DIExpression()), !dbg !207
  %56 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 3, !dbg !208
  %57 = load i8, ptr %56, align 1, !dbg !208, !tbaa !188
  %58 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 3, !dbg !211
  store i8 %57, ptr %58, align 1, !dbg !212, !tbaa !188
  %59 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 3, !dbg !213
  %60 = load i8, ptr %59, align 1, !dbg !213, !tbaa !188
  %61 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 3, !dbg !214
  store i8 %60, ptr %61, align 1, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 4, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 4, metadata !148, metadata !DIExpression()), !dbg !207
  %62 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 4, !dbg !208
  %63 = load i8, ptr %62, align 1, !dbg !208, !tbaa !188
  %64 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 4, !dbg !211
  store i8 %63, ptr %64, align 4, !dbg !212, !tbaa !188
  %65 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 4, !dbg !213
  %66 = load i8, ptr %65, align 1, !dbg !213, !tbaa !188
  %67 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 4, !dbg !214
  store i8 %66, ptr %67, align 2, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 5, metadata !148, metadata !DIExpression()), !dbg !207
  call void @llvm.dbg.value(metadata i64 5, metadata !148, metadata !DIExpression()), !dbg !207
  %68 = getelementptr inbounds %struct.ethhdr, ptr %5, i64 0, i32 1, i64 5, !dbg !208
  %69 = load i8, ptr %68, align 1, !dbg !208, !tbaa !188
  %70 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 3, i64 5, !dbg !211
  store i8 %69, ptr %70, align 1, !dbg !212, !tbaa !188
  %71 = getelementptr inbounds [6 x i8], ptr %5, i64 0, i64 5, !dbg !213
  %72 = load i8, ptr %71, align 1, !dbg !213, !tbaa !188
  %73 = getelementptr inbounds %struct.packet_info, ptr %2, i64 0, i32 4, i64 5, !dbg !214
  store i8 %72, ptr %73, align 1, !dbg !215, !tbaa !188
  call void @llvm.dbg.value(metadata i64 6, metadata !148, metadata !DIExpression()), !dbg !207
  %74 = call i64 inttoptr (i64 25 to ptr)(ptr noundef nonnull %0, ptr noundef nonnull @packet_info_map, i64 noundef 4294967295, ptr noundef nonnull %2, i64 noundef 28) #4, !dbg !216
  call void @llvm.lifetime.end.p0(i64 28, ptr nonnull %2) #4, !dbg !217
  br label %75

75:                                               ; preds = %16, %22, %12, %1
  ret i32 2, !dbg !217
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
!llvm.module.flags = !{!49, !50, !51, !52}
!llvm.ident = !{!53}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "packet_info_map", scope: !2, file: !3, line: 23, type: !41, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 15.0.7", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !20, globals: !26, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "net-logger.ebpf.c", directory: "/home/adam/raf-ebpf", checksumkind: CSK_MD5, checksum: "5079c0b41eef7c26b9cb6097a11abe1e")
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
!20 = !{!21, !22, !23}
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !24, line: 24, baseType: !25)
!24 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!25 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!26 = !{!27, !0, !33}
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 63, type: !29, isLocal: false, isDefinition: true)
!29 = !DICompositeType(tag: DW_TAG_array_type, baseType: !30, size: 32, elements: !31)
!30 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!31 = !{!32}
!32 = !DISubrange(count: 4)
!33 = !DIGlobalVariableExpression(var: !34, expr: !DIExpression())
!34 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !35, line: 696, type: !36, isLocal: true, isDefinition: true)
!35 = !DIFile(filename: "./libbpf/src/bpf_helper_defs.h", directory: "/home/adam/raf-ebpf", checksumkind: CSK_MD5, checksum: "6103e0e453f30c696884072404f9b37d")
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = !DISubroutineType(types: !38)
!38 = !{!22, !21, !21, !39, !21, !39}
!39 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !24, line: 31, baseType: !40)
!40 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 19, size: 192, elements: !42)
!42 = !{!43, !47, !48}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !41, file: !3, line: 20, baseType: !44, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DICompositeType(tag: DW_TAG_array_type, baseType: !46, size: 128, elements: !31)
!46 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!47 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !41, file: !3, line: 21, baseType: !44, size: 64, offset: 64)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !41, file: !3, line: 22, baseType: !44, size: 64, offset: 128)
!49 = !{i32 7, !"Dwarf Version", i32 5}
!50 = !{i32 2, !"Debug Info Version", i32 3}
!51 = !{i32 1, !"wchar_size", i32 4}
!52 = !{i32 7, !"frame-pointer", i32 2}
!53 = !{!"clang version 15.0.7"}
!54 = distinct !DISubprogram(name: "packet_info_prog", scope: !3, file: !3, line: 26, type: !55, scopeLine: 26, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !67)
!55 = !DISubroutineType(types: !56)
!56 = !{!46, !57}
!57 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !58, size: 64)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 6063, size: 192, elements: !59)
!59 = !{!60, !62, !63, !64, !65, !66}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !58, file: !6, line: 6064, baseType: !61, size: 32)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !24, line: 27, baseType: !7)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !58, file: !6, line: 6065, baseType: !61, size: 32, offset: 32)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !58, file: !6, line: 6066, baseType: !61, size: 32, offset: 64)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !58, file: !6, line: 6068, baseType: !61, size: 32, offset: 96)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !58, file: !6, line: 6069, baseType: !61, size: 32, offset: 128)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !58, file: !6, line: 6071, baseType: !61, size: 32, offset: 160)
!67 = !{!68, !69, !70, !71, !85, !115, !137, !138, !148}
!68 = !DILocalVariable(name: "ctx", arg: 1, scope: !54, file: !3, line: 26, type: !57)
!69 = !DILocalVariable(name: "data", scope: !54, file: !3, line: 27, type: !21)
!70 = !DILocalVariable(name: "data_end", scope: !54, file: !3, line: 28, type: !21)
!71 = !DILocalVariable(name: "eth", scope: !54, file: !3, line: 30, type: !72)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !74, line: 173, size: 112, elements: !75)
!74 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "163f54fb1af2e21fea410f14eb18fa76")
!75 = !{!76, !81, !82}
!76 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !73, file: !74, line: 174, baseType: !77, size: 48)
!77 = !DICompositeType(tag: DW_TAG_array_type, baseType: !78, size: 48, elements: !79)
!78 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!79 = !{!80}
!80 = !DISubrange(count: 6)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !73, file: !74, line: 175, baseType: !77, size: 48, offset: 48)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !73, file: !74, line: 176, baseType: !83, size: 16, offset: 96)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !84, line: 28, baseType: !23)
!84 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "64bcf4b731906682de6e750679b9f4a2")
!85 = !DILocalVariable(name: "iph", scope: !54, file: !3, line: 37, type: !86)
!86 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !87, size: 64)
!87 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !88, line: 86, size: 160, elements: !89)
!88 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "fbdafb4648dd1c838bddfe5d71e3770a")
!89 = !{!90, !92, !93, !94, !95, !96, !97, !98, !99, !101}
!90 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !87, file: !88, line: 88, baseType: !91, size: 4, flags: DIFlagBitField, extraData: i64 0)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !24, line: 21, baseType: !78)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !87, file: !88, line: 89, baseType: !91, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !87, file: !88, line: 96, baseType: !91, size: 8, offset: 8)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !87, file: !88, line: 97, baseType: !83, size: 16, offset: 16)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !87, file: !88, line: 98, baseType: !83, size: 16, offset: 32)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !87, file: !88, line: 99, baseType: !83, size: 16, offset: 48)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !87, file: !88, line: 100, baseType: !91, size: 8, offset: 64)
!98 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !87, file: !88, line: 101, baseType: !91, size: 8, offset: 72)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !87, file: !88, line: 102, baseType: !100, size: 16, offset: 80)
!100 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !84, line: 34, baseType: !23)
!101 = !DIDerivedType(tag: DW_TAG_member, scope: !87, file: !88, line: 103, baseType: !102, size: 64, offset: 96)
!102 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !87, file: !88, line: 103, size: 64, elements: !103)
!103 = !{!104, !110}
!104 = !DIDerivedType(tag: DW_TAG_member, scope: !102, file: !88, line: 103, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !102, file: !88, line: 103, size: 64, elements: !106)
!106 = !{!107, !109}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !105, file: !88, line: 103, baseType: !108, size: 32)
!108 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !84, line: 30, baseType: !61)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !105, file: !88, line: 103, baseType: !108, size: 32, offset: 32)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !102, file: !88, line: 103, baseType: !111, size: 64)
!111 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !102, file: !88, line: 103, size: 64, elements: !112)
!112 = !{!113, !114}
!113 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !111, file: !88, line: 103, baseType: !108, size: 32)
!114 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !111, file: !88, line: 103, baseType: !108, size: 32, offset: 32)
!115 = !DILocalVariable(name: "tcph", scope: !54, file: !3, line: 41, type: !116)
!116 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !117, size: 64)
!117 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tcphdr", file: !118, line: 25, size: 160, elements: !119)
!118 = !DIFile(filename: "/usr/include/linux/tcp.h", directory: "", checksumkind: CSK_MD5, checksum: "8d74bf2133e7b3dab885994b9916aa13")
!119 = !{!120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132, !133, !134, !135, !136}
!120 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !117, file: !118, line: 26, baseType: !83, size: 16)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !117, file: !118, line: 27, baseType: !83, size: 16, offset: 16)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "seq", scope: !117, file: !118, line: 28, baseType: !108, size: 32, offset: 32)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "ack_seq", scope: !117, file: !118, line: 29, baseType: !108, size: 32, offset: 64)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "res1", scope: !117, file: !118, line: 31, baseType: !23, size: 4, offset: 96, flags: DIFlagBitField, extraData: i64 96)
!125 = !DIDerivedType(tag: DW_TAG_member, name: "doff", scope: !117, file: !118, line: 32, baseType: !23, size: 4, offset: 100, flags: DIFlagBitField, extraData: i64 96)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "fin", scope: !117, file: !118, line: 33, baseType: !23, size: 1, offset: 104, flags: DIFlagBitField, extraData: i64 96)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "syn", scope: !117, file: !118, line: 34, baseType: !23, size: 1, offset: 105, flags: DIFlagBitField, extraData: i64 96)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "rst", scope: !117, file: !118, line: 35, baseType: !23, size: 1, offset: 106, flags: DIFlagBitField, extraData: i64 96)
!129 = !DIDerivedType(tag: DW_TAG_member, name: "psh", scope: !117, file: !118, line: 36, baseType: !23, size: 1, offset: 107, flags: DIFlagBitField, extraData: i64 96)
!130 = !DIDerivedType(tag: DW_TAG_member, name: "ack", scope: !117, file: !118, line: 37, baseType: !23, size: 1, offset: 108, flags: DIFlagBitField, extraData: i64 96)
!131 = !DIDerivedType(tag: DW_TAG_member, name: "urg", scope: !117, file: !118, line: 38, baseType: !23, size: 1, offset: 109, flags: DIFlagBitField, extraData: i64 96)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "ece", scope: !117, file: !118, line: 39, baseType: !23, size: 1, offset: 110, flags: DIFlagBitField, extraData: i64 96)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "cwr", scope: !117, file: !118, line: 40, baseType: !23, size: 1, offset: 111, flags: DIFlagBitField, extraData: i64 96)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "window", scope: !117, file: !118, line: 55, baseType: !83, size: 16, offset: 112)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !117, file: !118, line: 56, baseType: !100, size: 16, offset: 128)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "urg_ptr", scope: !117, file: !118, line: 57, baseType: !83, size: 16, offset: 144)
!137 = !DILocalVariable(name: "key", scope: !54, file: !3, line: 45, type: !61)
!138 = !DILocalVariable(name: "pkt_info", scope: !54, file: !3, line: 46, type: !139)
!139 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "packet_info", file: !3, line: 9, size: 224, elements: !140)
!140 = !{!141, !142, !143, !144, !145, !146, !147}
!141 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !139, file: !3, line: 10, baseType: !23, size: 16)
!142 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip", scope: !139, file: !3, line: 11, baseType: !61, size: 32, offset: 32)
!143 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip", scope: !139, file: !3, line: 12, baseType: !61, size: 32, offset: 64)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "eth_src", scope: !139, file: !3, line: 13, baseType: !77, size: 48, offset: 96)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "eth_dst", scope: !139, file: !3, line: 14, baseType: !77, size: 48, offset: 144)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !139, file: !3, line: 15, baseType: !23, size: 16, offset: 192)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !139, file: !3, line: 16, baseType: !23, size: 16, offset: 208)
!148 = !DILocalVariable(name: "i", scope: !149, file: !3, line: 54, type: !46)
!149 = distinct !DILexicalBlock(scope: !54, file: !3, line: 54, column: 5)
!150 = !DILocation(line: 0, scope: !54)
!151 = !DILocation(line: 27, column: 37, scope: !54)
!152 = !{!153, !154, i64 0}
!153 = !{!"xdp_md", !154, i64 0, !154, i64 4, !154, i64 8, !154, i64 12, !154, i64 16, !154, i64 20}
!154 = !{!"int", !155, i64 0}
!155 = !{!"omnipotent char", !156, i64 0}
!156 = !{!"Simple C/C++ TBAA"}
!157 = !DILocation(line: 27, column: 26, scope: !54)
!158 = !DILocation(line: 27, column: 18, scope: !54)
!159 = !DILocation(line: 28, column: 41, scope: !54)
!160 = !{!153, !154, i64 4}
!161 = !DILocation(line: 28, column: 30, scope: !54)
!162 = !DILocation(line: 28, column: 22, scope: !54)
!163 = !DILocation(line: 31, column: 14, scope: !164)
!164 = distinct !DILexicalBlock(scope: !54, file: !3, line: 31, column: 9)
!165 = !DILocation(line: 31, column: 38, scope: !164)
!166 = !DILocation(line: 31, column: 9, scope: !54)
!167 = !DILocation(line: 34, column: 9, scope: !168)
!168 = distinct !DILexicalBlock(scope: !54, file: !3, line: 34, column: 9)
!169 = !{!170, !171, i64 12}
!170 = !{!"ethhdr", !155, i64 0, !155, i64 6, !171, i64 12}
!171 = !{!"short", !155, i64 0}
!172 = !DILocation(line: 34, column: 33, scope: !168)
!173 = !DILocation(line: 34, column: 9, scope: !54)
!174 = !DILocation(line: 38, column: 38, scope: !175)
!175 = distinct !DILexicalBlock(scope: !54, file: !3, line: 38, column: 9)
!176 = !DILocation(line: 38, column: 61, scope: !175)
!177 = !DILocation(line: 38, column: 9, scope: !54)
!178 = !DILocation(line: 46, column: 5, scope: !54)
!179 = !DILocation(line: 46, column: 24, scope: !54)
!180 = !DILocation(line: 48, column: 30, scope: !54)
!181 = !{!182, !155, i64 9}
!182 = !{!"iphdr", !155, i64 0, !155, i64 0, !155, i64 1, !171, i64 2, !171, i64 4, !171, i64 6, !155, i64 8, !155, i64 9, !171, i64 10, !155, i64 12}
!183 = !DILocation(line: 48, column: 25, scope: !54)
!184 = !DILocation(line: 48, column: 23, scope: !54)
!185 = !{!186, !171, i64 0}
!186 = !{!"packet_info", !171, i64 0, !154, i64 4, !154, i64 8, !155, i64 12, !155, i64 18, !171, i64 24, !171, i64 26}
!187 = !DILocation(line: 49, column: 28, scope: !54)
!188 = !{!155, !155, i64 0}
!189 = !DILocation(line: 49, column: 14, scope: !54)
!190 = !DILocation(line: 49, column: 21, scope: !54)
!191 = !{!186, !154, i64 4}
!192 = !DILocation(line: 50, column: 28, scope: !54)
!193 = !DILocation(line: 50, column: 14, scope: !54)
!194 = !DILocation(line: 50, column: 21, scope: !54)
!195 = !{!186, !154, i64 8}
!196 = !DILocation(line: 51, column: 25, scope: !54)
!197 = !{!198, !171, i64 0}
!198 = !{!"tcphdr", !171, i64 0, !171, i64 2, !154, i64 4, !154, i64 8, !171, i64 12, !171, i64 12, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 13, !171, i64 14, !171, i64 16, !171, i64 18}
!199 = !DILocation(line: 51, column: 14, scope: !54)
!200 = !DILocation(line: 51, column: 23, scope: !54)
!201 = !{!186, !171, i64 24}
!202 = !DILocation(line: 52, column: 25, scope: !54)
!203 = !{!198, !171, i64 2}
!204 = !DILocation(line: 52, column: 14, scope: !54)
!205 = !DILocation(line: 52, column: 23, scope: !54)
!206 = !{!186, !171, i64 26}
!207 = !DILocation(line: 0, scope: !149)
!208 = !DILocation(line: 55, column: 31, scope: !209)
!209 = distinct !DILexicalBlock(scope: !210, file: !3, line: 54, column: 33)
!210 = distinct !DILexicalBlock(scope: !149, file: !3, line: 54, column: 5)
!211 = !DILocation(line: 55, column: 9, scope: !209)
!212 = !DILocation(line: 55, column: 29, scope: !209)
!213 = !DILocation(line: 56, column: 31, scope: !209)
!214 = !DILocation(line: 56, column: 9, scope: !209)
!215 = !DILocation(line: 56, column: 29, scope: !209)
!216 = !DILocation(line: 59, column: 5, scope: !54)
!217 = !DILocation(line: 61, column: 1, scope: !54)
