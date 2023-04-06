; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.auth_hdr = type <{ i8, i32, i32, i64, i32, i32, i64 }>

@cr_db_map = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 32, i32 250000, i32 0 }, section "maps", align 4, !dbg !0
@hashValues = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 4, i32 500, i32 0 }, section "maps", align 4, !dbg !27
@crc32_table = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 4, i32 256, i32 0 }, section "maps", align 4, !dbg !37
@__const.xdp_parsing.____fmt = private unnamed_addr constant [17 x i8] c"hash value - %d \00", align 1
@__const.xdp_parsing.____fmt.1 = private unnamed_addr constant [30 x i8] c"Unavibale map for hash values\00", align 1
@__const.xdp_parsing.____fmt.2 = private unnamed_addr constant [48 x i8] c"Unmatching Hash Values. Authentication Failure\0A\00", align 1
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !39
@__const.make_challenge_header.____fmt = private unnamed_addr constant [46 x i8] c"Msg type is 0, this is a auth request message\00", align 1
@__const.computeHash.____fmt = private unnamed_addr constant [21 x i8] c"No such key exist!!\0A\00", align 1
@llvm.compiler.used = appending global [5 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (%struct.bpf_map_def* @cr_db_map to i8*), i8* bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @xdp_parsing to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @xdp_parsing(%struct.xdp_md* nocapture noundef readonly %0) #0 section "xdp_prog" !dbg !82 {
  %2 = alloca [6 x i8], align 1
  %3 = alloca [6 x i8], align 1
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca [17 x i8], align 1
  %7 = alloca [30 x i8], align 1
  %8 = alloca [48 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !94, metadata !DIExpression()), !dbg !208
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !209
  %10 = load i32, i32* %9, align 4, !dbg !209, !tbaa !210
  %11 = zext i32 %10 to i64, !dbg !215
  %12 = inttoptr i64 %11 to i8*, !dbg !216
  call void @llvm.dbg.value(metadata i8* %12, metadata !147, metadata !DIExpression()), !dbg !208
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !217
  %14 = load i32, i32* %13, align 4, !dbg !217, !tbaa !218
  %15 = zext i32 %14 to i64, !dbg !219
  %16 = inttoptr i64 %15 to i8*, !dbg !220
  call void @llvm.dbg.value(metadata i8* %16, metadata !148, metadata !DIExpression()), !dbg !208
  %17 = icmp ult i8* %16, %12, !dbg !221
  br i1 %17, label %18, label %135, !dbg !222

18:                                               ; preds = %1
  %19 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !223
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !95, metadata !DIExpression()), !dbg !208
  %20 = getelementptr i8, i8* %16, i64 14, !dbg !224
  %21 = icmp ugt i8* %20, %12, !dbg !226
  br i1 %21, label %135, label %22, !dbg !227

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 2, !dbg !228
  %24 = load i16, i16* %23, align 1, !dbg !228, !tbaa !230
  %25 = icmp eq i16 %24, 8, !dbg !233
  br i1 %25, label %26, label %135, !dbg !234

26:                                               ; preds = %22
  call void @llvm.dbg.value(metadata i8* %20, metadata !108, metadata !DIExpression()), !dbg !208
  %27 = getelementptr i8, i8* %16, i64 34, !dbg !235
  %28 = icmp ugt i8* %27, %12, !dbg !237
  br i1 %28, label %135, label %29, !dbg !238

29:                                               ; preds = %26
  %30 = getelementptr i8, i8* %16, i64 23, !dbg !239
  %31 = load i8, i8* %30, align 1, !dbg !239, !tbaa !240
  %32 = icmp eq i8 %31, 17, !dbg !242
  br i1 %32, label %33, label %135, !dbg !243

33:                                               ; preds = %29
  call void @llvm.dbg.value(metadata i8* %27, metadata !138, metadata !DIExpression()), !dbg !208
  %34 = getelementptr i8, i8* %16, i64 42, !dbg !244
  %35 = icmp ugt i8* %34, %12, !dbg !246
  br i1 %35, label %135, label %36, !dbg !247

36:                                               ; preds = %33
  %37 = bitcast i8* %34 to %struct.auth_hdr*, !dbg !248
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %37, metadata !149, metadata !DIExpression()), !dbg !249
  %38 = getelementptr i8, i8* %16, i64 75, !dbg !250
  %39 = icmp ugt i8* %38, %12, !dbg !252
  br i1 %39, label %135, label %40, !dbg !253

40:                                               ; preds = %36
  %41 = load i8, i8* %34, align 1, !dbg !254, !tbaa !255
  call void @llvm.dbg.value(metadata i8 %41, metadata !172, metadata !DIExpression()), !dbg !249
  %42 = bitcast i32* %4 to i8*, !dbg !258
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %42) #7, !dbg !258
  %43 = getelementptr i8, i8* %16, i64 63, !dbg !259
  %44 = bitcast i8* %43 to i32*, !dbg !259
  %45 = load i32, i32* %44, align 1, !dbg !259, !tbaa !260
  %46 = tail call i32 @llvm.bswap.i32(i32 %45), !dbg !259
  %47 = add i32 %46, -1, !dbg !261
  call void @llvm.dbg.value(metadata i32 %47, metadata !173, metadata !DIExpression()), !dbg !249
  store i32 %47, i32* %4, align 4, !dbg !262, !tbaa !263
  switch i8 %41, label %130 [
    i8 0, label %48
    i8 2, label %85
  ], !dbg !264

48:                                               ; preds = %40
  %49 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !265
  call void @llvm.dbg.value(metadata i64 %49, metadata !174, metadata !DIExpression()), !dbg !266
  %50 = bitcast i32* %5 to i8*, !dbg !267
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %50) #7, !dbg !267
  %51 = tail call fastcc i32 @make_challenge_header(%struct.auth_hdr* noundef nonnull %37), !dbg !268
  call void @llvm.dbg.value(metadata i32 %51, metadata !177, metadata !DIExpression()), !dbg !266
  store i32 %51, i32* %5, align 4, !dbg !269, !tbaa !263
  %52 = getelementptr inbounds [17 x i8], [17 x i8]* %6, i64 0, i64 0, !dbg !270
  call void @llvm.lifetime.start.p0i8(i64 17, i8* nonnull %52) #7, !dbg !270
  call void @llvm.dbg.declare(metadata [17 x i8]* %6, metadata !178, metadata !DIExpression()), !dbg !270
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(17) %52, i8* noundef nonnull align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8]* @__const.xdp_parsing.____fmt, i64 0, i64 0), i64 17, i1 false), !dbg !270
  %53 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %52, i32 noundef 17, i32 noundef %51) #7, !dbg !270
  call void @llvm.lifetime.end.p0i8(i64 17, i8* nonnull %52) #7, !dbg !271
  call void @llvm.dbg.value(metadata i32 %51, metadata !177, metadata !DIExpression()), !dbg !266
  %54 = icmp eq i32 %51, -1, !dbg !272
  br i1 %54, label %83, label %55, !dbg !274

55:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i32* %4, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !249
  call void @llvm.dbg.value(metadata i32* %5, metadata !177, metadata !DIExpression(DW_OP_deref)), !dbg !266
  %56 = call i32 inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42, i8* noundef nonnull %50, i64 noundef 0) #7, !dbg !275
  call void @llvm.dbg.value(metadata i8* %20, metadata !277, metadata !DIExpression()), !dbg !284
  %57 = getelementptr i8, i8* %16, i64 26, !dbg !286
  %58 = bitcast i8* %57 to i32*, !dbg !286
  %59 = load i32, i32* %58, align 4, !dbg !286, !tbaa !287
  call void @llvm.dbg.value(metadata i32 %59, metadata !283, metadata !DIExpression()), !dbg !284
  %60 = getelementptr i8, i8* %16, i64 30, !dbg !288
  %61 = bitcast i8* %60 to i32*, !dbg !288
  %62 = load i32, i32* %61, align 4, !dbg !288, !tbaa !287
  store i32 %62, i32* %58, align 4, !dbg !289, !tbaa !287
  store i32 %59, i32* %61, align 4, !dbg !290, !tbaa !287
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !291, metadata !DIExpression()) #7, !dbg !298
  %63 = getelementptr inbounds [6 x i8], [6 x i8]* %3, i64 0, i64 0, !dbg !300
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %63), !dbg !300
  call void @llvm.dbg.declare(metadata [6 x i8]* %3, metadata !296, metadata !DIExpression()) #7, !dbg !301
  %64 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !302
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %63, i8* noundef nonnull align 1 dereferenceable(6) %64, i64 6, i1 false) #7, !dbg !302
  %65 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !303
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %64, i8* noundef nonnull align 1 dereferenceable(6) %65, i64 6, i1 false) #7, !dbg !303
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %65, i8* noundef nonnull align 1 dereferenceable(6) %63, i64 6, i1 false) #7, !dbg !304
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %63), !dbg !305
  %66 = bitcast i8* %27 to i16*, !dbg !306
  %67 = load i16, i16* %66, align 2, !dbg !306, !tbaa !307
  call void @llvm.dbg.value(metadata i16 %67, metadata !183, metadata !DIExpression()), !dbg !266
  %68 = getelementptr i8, i8* %16, i64 36, !dbg !309
  %69 = bitcast i8* %68 to i16*, !dbg !309
  %70 = load i16, i16* %69, align 2, !dbg !309, !tbaa !310
  store i16 %70, i16* %66, align 2, !dbg !311, !tbaa !307
  store i16 %67, i16* %69, align 2, !dbg !312, !tbaa !310
  %71 = getelementptr i8, i8* %16, i64 40, !dbg !313
  %72 = bitcast i8* %71 to i16*, !dbg !313
  store i16 0, i16* %72, align 2, !dbg !314, !tbaa !315
  %73 = getelementptr i8, i8* %16, i64 24, !dbg !316
  %74 = bitcast i8* %73 to i16*, !dbg !316
  store i16 0, i16* %74, align 2, !dbg !317, !tbaa !318
  %75 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !319
  store i16 %75, i16* %74, align 2, !dbg !320, !tbaa !318
  %76 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !321
  call void @llvm.dbg.value(metadata i64 %76, metadata !184, metadata !DIExpression()), !dbg !266
  %77 = sub i64 %76, %49, !dbg !322
  %78 = trunc i64 %77 to i32
  %79 = call i32 @llvm.bswap.i32(i32 %78), !dbg !322
  %80 = zext i32 %79 to i64, !dbg !322
  %81 = getelementptr i8, i8* %16, i64 67, !dbg !323
  %82 = bitcast i8* %81 to i64*, !dbg !323
  store i64 %80, i64* %82, align 1, !dbg !324, !tbaa !325
  br label %83

83:                                               ; preds = %48, %55
  %84 = phi i32 [ 3, %55 ], [ 0, %48 ], !dbg !266
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %50) #7, !dbg !326
  br label %130

85:                                               ; preds = %40
  %86 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !327
  call void @llvm.dbg.value(metadata i64 %86, metadata !185, metadata !DIExpression()), !dbg !328
  %87 = getelementptr i8, i8* %16, i64 59, !dbg !329
  %88 = bitcast i8* %87 to i32*, !dbg !329
  %89 = load i32, i32* %88, align 1, !dbg !329, !tbaa !330
  call void @llvm.dbg.value(metadata i32 undef, metadata !188, metadata !DIExpression()), !dbg !328
  call void @llvm.dbg.value(metadata i32* %4, metadata !173, metadata !DIExpression(DW_OP_deref)), !dbg !249
  %90 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42) #7, !dbg !331
  call void @llvm.dbg.value(metadata i8* %90, metadata !189, metadata !DIExpression()), !dbg !328
  %91 = icmp eq i8* %90, null, !dbg !332
  br i1 %91, label %92, label %95, !dbg !333

92:                                               ; preds = %85
  %93 = getelementptr inbounds [30 x i8], [30 x i8]* %7, i64 0, i64 0, !dbg !334
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %93) #7, !dbg !334
  call void @llvm.dbg.declare(metadata [30 x i8]* %7, metadata !191, metadata !DIExpression()), !dbg !334
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(30) %93, i8* noundef nonnull align 1 dereferenceable(30) getelementptr inbounds ([30 x i8], [30 x i8]* @__const.xdp_parsing.____fmt.1, i64 0, i64 0), i64 30, i1 false), !dbg !334
  %94 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %93, i32 noundef 30) #7, !dbg !334
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %93) #7, !dbg !335
  br label %130, !dbg !336

95:                                               ; preds = %85
  %96 = call i32 @llvm.bswap.i32(i32 %89), !dbg !329
  call void @llvm.dbg.value(metadata i32 %96, metadata !188, metadata !DIExpression()), !dbg !328
  %97 = bitcast i8* %90 to i32*, !dbg !331
  call void @llvm.dbg.value(metadata i32* %97, metadata !189, metadata !DIExpression()), !dbg !328
  %98 = load i32, i32* %97, align 4, !dbg !337, !tbaa !263
  %99 = icmp eq i32 %96, %98, !dbg !338
  br i1 %99, label %100, label %132, !dbg !339

100:                                              ; preds = %95
  store i8 3, i8* %34, align 1, !dbg !340, !tbaa !255
  %101 = load i32, i32* %4, align 4, !dbg !341, !tbaa !263
  call void @llvm.dbg.value(metadata i32 %101, metadata !173, metadata !DIExpression()), !dbg !249
  %102 = add i32 %101, 1, !dbg !341
  %103 = call i32 @llvm.bswap.i32(i32 %102), !dbg !341
  store i32 %103, i32* %44, align 1, !dbg !342, !tbaa !260
  call void @llvm.dbg.value(metadata i8* %20, metadata !277, metadata !DIExpression()), !dbg !343
  %104 = getelementptr i8, i8* %16, i64 26, !dbg !345
  %105 = bitcast i8* %104 to i32*, !dbg !345
  %106 = load i32, i32* %105, align 4, !dbg !345, !tbaa !287
  call void @llvm.dbg.value(metadata i32 %106, metadata !283, metadata !DIExpression()), !dbg !343
  %107 = getelementptr i8, i8* %16, i64 30, !dbg !346
  %108 = bitcast i8* %107 to i32*, !dbg !346
  %109 = load i32, i32* %108, align 4, !dbg !346, !tbaa !287
  store i32 %109, i32* %105, align 4, !dbg !347, !tbaa !287
  store i32 %106, i32* %108, align 4, !dbg !348, !tbaa !287
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !291, metadata !DIExpression()) #7, !dbg !349
  %110 = getelementptr inbounds [6 x i8], [6 x i8]* %2, i64 0, i64 0, !dbg !351
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %110), !dbg !351
  call void @llvm.dbg.declare(metadata [6 x i8]* %2, metadata !296, metadata !DIExpression()) #7, !dbg !352
  %111 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !353
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %110, i8* noundef nonnull align 1 dereferenceable(6) %111, i64 6, i1 false) #7, !dbg !353
  %112 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !354
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %111, i8* noundef nonnull align 1 dereferenceable(6) %112, i64 6, i1 false) #7, !dbg !354
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %112, i8* noundef nonnull align 1 dereferenceable(6) %110, i64 6, i1 false) #7, !dbg !355
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %110), !dbg !356
  %113 = bitcast i8* %27 to i16*, !dbg !357
  %114 = load i16, i16* %113, align 2, !dbg !357, !tbaa !307
  call void @llvm.dbg.value(metadata i16 %114, metadata !198, metadata !DIExpression()), !dbg !358
  %115 = getelementptr i8, i8* %16, i64 36, !dbg !359
  %116 = bitcast i8* %115 to i16*, !dbg !359
  %117 = load i16, i16* %116, align 2, !dbg !359, !tbaa !310
  store i16 %117, i16* %113, align 2, !dbg !360, !tbaa !307
  store i16 %114, i16* %116, align 2, !dbg !361, !tbaa !310
  %118 = getelementptr i8, i8* %16, i64 40, !dbg !362
  %119 = bitcast i8* %118 to i16*, !dbg !362
  store i16 0, i16* %119, align 2, !dbg !363, !tbaa !315
  %120 = getelementptr i8, i8* %16, i64 24, !dbg !364
  %121 = bitcast i8* %120 to i16*, !dbg !364
  store i16 0, i16* %121, align 2, !dbg !365, !tbaa !318
  %122 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !366
  store i16 %122, i16* %121, align 2, !dbg !367, !tbaa !318
  %123 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !368
  call void @llvm.dbg.value(metadata i64 %123, metadata !201, metadata !DIExpression()), !dbg !358
  %124 = sub i64 %123, %86, !dbg !369
  %125 = trunc i64 %124 to i32, !dbg !369
  %126 = call i32 @llvm.bswap.i32(i32 %125), !dbg !369
  %127 = zext i32 %126 to i64, !dbg !369
  %128 = getelementptr i8, i8* %16, i64 67, !dbg !370
  %129 = bitcast i8* %128 to i64*, !dbg !370
  store i64 %127, i64* %129, align 1, !dbg !371, !tbaa !325
  br label %130

130:                                              ; preds = %83, %100, %92, %40
  %131 = phi i32 [ 2, %40 ], [ 0, %92 ], [ 3, %100 ], [ %84, %83 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !372
  br label %135

132:                                              ; preds = %95
  %133 = getelementptr inbounds [48 x i8], [48 x i8]* %8, i64 0, i64 0, !dbg !373
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %133) #7, !dbg !373
  call void @llvm.dbg.declare(metadata [48 x i8]* %8, metadata !202, metadata !DIExpression()), !dbg !373
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(48) %133, i8* noundef nonnull align 1 dereferenceable(48) getelementptr inbounds ([48 x i8], [48 x i8]* @__const.xdp_parsing.____fmt.2, i64 0, i64 0), i64 48, i1 false), !dbg !373
  %134 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %133, i32 noundef 48) #7, !dbg !373
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %133) #7, !dbg !374
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !372
  br label %135, !dbg !375

135:                                              ; preds = %36, %130, %1, %33, %29, %26, %22, %18, %132
  %136 = phi i32 [ 2, %132 ], [ 1, %18 ], [ 2, %22 ], [ 1, %26 ], [ 2, %29 ], [ 1, %33 ], [ 1, %1 ], [ %131, %130 ], [ 1, %36 ], !dbg !208
  ret i32 %136, !dbg !376
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: nounwind
define internal fastcc i32 @make_challenge_header(%struct.auth_hdr* nocapture noundef %0) unnamed_addr #0 !dbg !377 {
  %2 = alloca i32, align 4
  %3 = alloca [21 x i8], align 1
  %4 = alloca [24 x i8], align 8, !dbg !417
  %5 = alloca [46 x i8], align 1
  %6 = alloca i32, align 4
  %7 = alloca [21 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %0, metadata !381, metadata !DIExpression()), !dbg !446
  %8 = getelementptr inbounds [46 x i8], [46 x i8]* %5, i64 0, i64 0, !dbg !447
  call void @llvm.lifetime.start.p0i8(i64 46, i8* nonnull %8) #7, !dbg !447
  call void @llvm.dbg.declare(metadata [46 x i8]* %5, metadata !382, metadata !DIExpression()), !dbg !447
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(46) %8, i8* noundef nonnull align 1 dereferenceable(46) getelementptr inbounds ([46 x i8], [46 x i8]* @__const.make_challenge_header.____fmt, i64 0, i64 0), i64 46, i1 false), !dbg !447
  %9 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %8, i32 noundef 46) #7, !dbg !447
  call void @llvm.lifetime.end.p0i8(i64 46, i8* nonnull %8) #7, !dbg !448
  %10 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 5, !dbg !449
  %11 = load i32, i32* %10, align 1, !dbg !449, !tbaa !260
  %12 = call i32 @llvm.bswap.i32(i32 %11), !dbg !449
  call void @llvm.dbg.value(metadata i32 %12, metadata !387, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !446
  %13 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !450
  call void @llvm.dbg.value(metadata i32 %13, metadata !397, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !446
  %14 = urem i32 %13, 500, !dbg !451
  call void @llvm.dbg.value(metadata i32 %14, metadata !398, metadata !DIExpression()), !dbg !446
  %15 = bitcast i32* %6 to i8*, !dbg !452
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %15) #7, !dbg !452
  %16 = mul i32 %12, 500, !dbg !453
  %17 = add i32 %16, -500, !dbg !453
  %18 = add i32 %17, %14, !dbg !454
  call void @llvm.dbg.value(metadata i32 %18, metadata !399, metadata !DIExpression()), !dbg !446
  store i32 %18, i32* %6, align 4, !dbg !455, !tbaa !263
  call void @llvm.dbg.value(metadata i32* %6, metadata !399, metadata !DIExpression(DW_OP_deref)), !dbg !446
  %19 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @cr_db_map to i8*), i8* noundef nonnull %15) #7, !dbg !456
  call void @llvm.dbg.value(metadata i8* %19, metadata !388, metadata !DIExpression()), !dbg !446
  %20 = icmp eq i8* %19, null, !dbg !457
  br i1 %20, label %21, label %24, !dbg !458

21:                                               ; preds = %1
  %22 = getelementptr inbounds [21 x i8], [21 x i8]* %7, i64 0, i64 0, !dbg !459
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %22) #7, !dbg !459
  call void @llvm.dbg.declare(metadata [21 x i8]* %7, metadata !400, metadata !DIExpression()), !dbg !459
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %22, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false), !dbg !459
  %23 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %22, i32 noundef 21) #7, !dbg !459
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %22) #7, !dbg !460
  br label %92, !dbg !461

24:                                               ; preds = %1
  %25 = zext i32 %13 to i64, !dbg !450
  call void @llvm.dbg.value(metadata i64 %25, metadata !397, metadata !DIExpression()), !dbg !446
  call void @llvm.dbg.value(metadata i8* %19, metadata !388, metadata !DIExpression()), !dbg !446
  %26 = bitcast i8* %19 to i32*, !dbg !462
  %27 = load i32, i32* %26, align 8, !dbg !462, !tbaa !463
  call void @llvm.dbg.value(metadata i32 %27, metadata !407, metadata !DIExpression()), !dbg !446
  %28 = getelementptr inbounds i8, i8* %19, i64 16, !dbg !465
  %29 = bitcast i8* %28 to i32*, !dbg !465
  %30 = load i32, i32* %29, align 8, !dbg !465, !tbaa !466
  call void @llvm.dbg.value(metadata i32 %30, metadata !408, metadata !DIExpression()), !dbg !446
  %31 = getelementptr inbounds i8, i8* %19, i64 8, !dbg !467
  %32 = bitcast i8* %31 to i64*, !dbg !467
  %33 = load i64, i64* %32, align 8, !dbg !467, !tbaa !468
  call void @llvm.dbg.value(metadata i64 %33, metadata !409, metadata !DIExpression()), !dbg !446
  %34 = getelementptr inbounds i8, i8* %19, i64 24, !dbg !469
  %35 = bitcast i8* %34 to i64*, !dbg !469
  %36 = load i64, i64* %35, align 8, !dbg !469, !tbaa !470
  call void @llvm.dbg.value(metadata i64 %36, metadata !410, metadata !DIExpression()), !dbg !446
  %37 = or i64 %36, %33, !dbg !471
  call void @llvm.dbg.value(metadata !DIArgList(i64 %37, i32 %13), metadata !411, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !446
  %38 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 0, !dbg !472
  store i8 1, i8* %38, align 1, !dbg !473, !tbaa !255
  %39 = call i32 @llvm.bswap.i32(i32 %27), !dbg !474
  %40 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 1, !dbg !475
  store i32 %39, i32* %40, align 1, !dbg !476, !tbaa !477
  %41 = call i32 @llvm.bswap.i32(i32 %30), !dbg !478
  %42 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 2, !dbg !479
  store i32 %41, i32* %42, align 1, !dbg !480, !tbaa !481
  %43 = trunc i64 %37 to i32, !dbg !482
  %44 = xor i32 %13, %43, !dbg !482
  %45 = call i32 @llvm.bswap.i32(i32 %44), !dbg !482
  %46 = zext i32 %45 to i64, !dbg !482
  %47 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 3, !dbg !483
  store i64 %46, i64* %47, align 1, !dbg !484, !tbaa !485
  store i32 %11, i32* %10, align 1, !dbg !486, !tbaa !260
  call void @llvm.dbg.value(metadata i64 %33, metadata !412, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !446
  call void @llvm.dbg.value(metadata i64 %36, metadata !412, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 64)), !dbg !446
  call void @llvm.dbg.value(metadata i32 %13, metadata !412, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 128, 64)), !dbg !446
  %48 = getelementptr inbounds [24 x i8], [24 x i8]* %4, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %48)
  call void @llvm.dbg.value(metadata i64* undef, metadata !423, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.dbg.value(metadata i32 3, metadata !424, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.dbg.value(metadata i64 24, metadata !425, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.dbg.declare(metadata [24 x i8]* %4, metadata !427, metadata !DIExpression()) #7, !dbg !488
  call void @llvm.dbg.value(metadata i32 0, metadata !431, metadata !DIExpression()) #7, !dbg !489
  %49 = bitcast [24 x i8]* %4 to i64*, !dbg !490
  store i64 %33, i64* %49, align 8, !dbg !490
  %50 = getelementptr inbounds [24 x i8], [24 x i8]* %4, i64 0, i64 8, !dbg !490
  %51 = bitcast i8* %50 to i64*, !dbg !490
  store i64 %36, i64* %51, align 8, !dbg !490
  %52 = getelementptr inbounds [24 x i8], [24 x i8]* %4, i64 0, i64 16, !dbg !490
  %53 = bitcast i8* %52 to i64*, !dbg !490
  store i64 %25, i64* %53, align 8, !dbg !490
  call void @llvm.dbg.value(metadata i32 undef, metadata !431, metadata !DIExpression()) #7, !dbg !489
  call void @llvm.dbg.value(metadata i32 undef, metadata !431, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)) #7, !dbg !489
  %54 = bitcast i32* %2 to i8*
  call void @llvm.dbg.value(metadata i32 0, metadata !434, metadata !DIExpression()) #7, !dbg !493
  call void @llvm.dbg.value(metadata i32 -1, metadata !433, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.dbg.value(metadata i64 0, metadata !434, metadata !DIExpression()) #7, !dbg !493
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %54) #7, !dbg !494
  %55 = trunc i64 %33 to i32, !dbg !495
  %56 = and i32 %55, 255, !dbg !496
  %57 = xor i32 %56, 255, !dbg !496
  call void @llvm.dbg.value(metadata i32 %57, metadata !436, metadata !DIExpression()) #7, !dbg !497
  store i32 %57, i32* %2, align 4, !dbg !498, !tbaa !263
  call void @llvm.dbg.value(metadata i32* %2, metadata !436, metadata !DIExpression(DW_OP_deref)) #7, !dbg !497
  %58 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %54) #7, !dbg !499
  call void @llvm.dbg.value(metadata i8* %58, metadata !439, metadata !DIExpression()) #7, !dbg !497
  %59 = icmp eq i8* %58, null, !dbg !500
  br i1 %59, label %70, label %75, !dbg !501

60:                                               ; preds = %75
  call void @llvm.dbg.value(metadata i64 %83, metadata !434, metadata !DIExpression()) #7, !dbg !493
  call void @llvm.dbg.value(metadata i32 %82, metadata !433, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %54) #7, !dbg !494
  %61 = getelementptr inbounds [24 x i8], [24 x i8]* %4, i64 0, i64 %83, !dbg !495
  %62 = load i8, i8* %61, align 1, !dbg !495, !tbaa !287
  %63 = zext i8 %62 to i32, !dbg !495
  %64 = and i32 %82, 255, !dbg !496
  %65 = xor i32 %64, %63, !dbg !496
  call void @llvm.dbg.value(metadata i32 %65, metadata !436, metadata !DIExpression()) #7, !dbg !497
  store i32 %65, i32* %2, align 4, !dbg !498, !tbaa !263
  call void @llvm.dbg.value(metadata i32* %2, metadata !436, metadata !DIExpression(DW_OP_deref)) #7, !dbg !497
  %66 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %54) #7, !dbg !499
  call void @llvm.dbg.value(metadata i8* %66, metadata !439, metadata !DIExpression()) #7, !dbg !497
  %67 = icmp eq i8* %66, null, !dbg !500
  br i1 %67, label %68, label %75, !dbg !501, !llvm.loop !502

68:                                               ; preds = %60
  %69 = icmp ult i64 %78, 23, !dbg !506
  br label %70, !dbg !507

70:                                               ; preds = %68, %24
  %71 = phi i1 [ true, %24 ], [ %69, %68 ]
  %72 = phi i32 [ -1, %24 ], [ %82, %68 ]
  %73 = getelementptr inbounds [21 x i8], [21 x i8]* %3, i64 0, i64 0, !dbg !507
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %73) #7, !dbg !507
  call void @llvm.dbg.declare(metadata [21 x i8]* %3, metadata !441, metadata !DIExpression()) #7, !dbg !507
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %73, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false) #7, !dbg !507
  %74 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %73, i32 noundef 21) #7, !dbg !507
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %73) #7, !dbg !508
  call void @llvm.dbg.value(metadata i32 undef, metadata !433, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %54) #7, !dbg !509
  br label %87

75:                                               ; preds = %24, %60
  %76 = phi i8* [ %66, %60 ], [ %58, %24 ]
  %77 = phi i32 [ %82, %60 ], [ -1, %24 ]
  %78 = phi i64 [ %83, %60 ], [ 0, %24 ]
  call void @llvm.dbg.value(metadata i32 %77, metadata !433, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.dbg.value(metadata i64 %78, metadata !434, metadata !DIExpression()) #7, !dbg !493
  %79 = bitcast i8* %76 to i32*, !dbg !499
  call void @llvm.dbg.value(metadata i32* %79, metadata !439, metadata !DIExpression()) #7, !dbg !497
  %80 = lshr i32 %77, 8, !dbg !510
  %81 = load i32, i32* %79, align 4, !dbg !511, !tbaa !263
  %82 = xor i32 %81, %80, !dbg !512
  call void @llvm.dbg.value(metadata i32 %82, metadata !433, metadata !DIExpression()) #7, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %54) #7, !dbg !509
  %83 = add nuw nsw i64 %78, 1, !dbg !513
  call void @llvm.dbg.value(metadata i64 %83, metadata !434, metadata !DIExpression()) #7, !dbg !493
  %84 = icmp eq i64 %83, 24, !dbg !506
  br i1 %84, label %85, label %60, !dbg !503, !llvm.loop !502

85:                                               ; preds = %75
  %86 = icmp ult i64 %78, 23, !dbg !506
  br label %87

87:                                               ; preds = %85, %70
  %88 = phi i32 [ %72, %70 ], [ %82, %85 ]
  %89 = phi i1 [ %71, %70 ], [ %86, %85 ]
  call void @llvm.dbg.value(metadata i32 %88, metadata !433, metadata !DIExpression()) #7, !dbg !487
  %90 = xor i32 %88, -1
  %91 = select i1 %89, i32 0, i32 %90
  call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %48), !dbg !514
  call void @llvm.dbg.value(metadata i32 %91, metadata !416, metadata !DIExpression()), !dbg !446
  br label %92

92:                                               ; preds = %87, %21
  %93 = phi i32 [ %91, %87 ], [ 0, %21 ], !dbg !446
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %15) #7, !dbg !515
  ret i32 %93, !dbg !515
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree norecurse nosync nounwind readonly
define internal fastcc zeroext i16 @ip_checksum(i8* nocapture noundef readonly %0) unnamed_addr #4 !dbg !516 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !520, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 20, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 0, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 0, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 20, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 18, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 18, metadata !521, metadata !DIExpression()), !dbg !524
  %2 = bitcast i8* %0 to <8 x i16>*, !dbg !525
  %3 = load <8 x i16>, <8 x i16>* %2, align 2, !dbg !525, !tbaa !527
  %4 = zext <8 x i16> %3 to <8 x i32>, !dbg !525
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 16, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 16, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 14, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 14, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 12, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 12, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 10, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 10, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 8, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 8, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 6, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %0, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 6, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  %5 = getelementptr inbounds i8, i8* %0, i64 16, !dbg !528
  call void @llvm.dbg.value(metadata i8* %5, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 4, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %5, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 4, metadata !521, metadata !DIExpression()), !dbg !524
  %6 = bitcast i8* %5 to i16*, !dbg !525
  %7 = load i16, i16* %6, align 2, !dbg !525, !tbaa !527
  %8 = zext i16 %7 to i32, !dbg !525
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  %9 = getelementptr inbounds i8, i8* %0, i64 18, !dbg !528
  call void @llvm.dbg.value(metadata i8* %9, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 2, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 undef, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %9, metadata !522, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 2, metadata !521, metadata !DIExpression()), !dbg !524
  %10 = bitcast i8* %9 to i16*, !dbg !525
  %11 = load i16, i16* %10, align 2, !dbg !525, !tbaa !527
  %12 = zext i16 %11 to i32, !dbg !525
  %13 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %4), !dbg !529
  %14 = add nuw nsw i32 %13, %8, !dbg !525
  %15 = add nuw nsw i32 %14, %12, !dbg !525
  call void @llvm.dbg.value(metadata i32 %15, metadata !523, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i8* %9, metadata !522, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !524
  call void @llvm.dbg.value(metadata i32 0, metadata !521, metadata !DIExpression()), !dbg !524
  call void @llvm.dbg.value(metadata i32 %15, metadata !523, metadata !DIExpression()), !dbg !524
  %16 = icmp ult i32 %15, 65536, !dbg !530
  br i1 %16, label %23, label %17, !dbg !530

17:                                               ; preds = %1, %17
  %18 = phi i32 [ %21, %17 ], [ %15, %1 ]
  call void @llvm.dbg.value(metadata i32 %18, metadata !523, metadata !DIExpression()), !dbg !524
  %19 = lshr i32 %18, 16, !dbg !531
  %20 = and i32 %18, 65535, !dbg !532
  %21 = add nuw nsw i32 %20, %19, !dbg !534
  call void @llvm.dbg.value(metadata i32 %21, metadata !523, metadata !DIExpression()), !dbg !524
  %22 = icmp ult i32 %21, 65536, !dbg !530
  br i1 %22, label %23, label %17, !dbg !530, !llvm.loop !535

23:                                               ; preds = %17, %1
  %24 = phi i32 [ %15, %1 ], [ %21, %17 ], !dbg !524
  %25 = trunc i32 %24 to i16, !dbg !537
  %26 = xor i16 %25, -1, !dbg !537
  ret i16 %26, !dbg !538
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #5

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i32 @llvm.vector.reduce.add.v8i32(<8 x i32>) #6

attributes #0 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #3 = { argmemonly mustprogress nofree nounwind willreturn }
attributes #4 = { nofree norecurse nosync nounwind readonly "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #5 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #6 = { nofree nosync nounwind readnone willreturn }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!77, !78, !79, !80}
!llvm.ident = !{!81}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "cr_db_map", scope: !2, file: !3, line: 49, type: !29, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !26, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "a77d2e910e611047f96ef75a52cc80f1")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "db1ce4e5e29770657167bc8f57af9388")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !{!15, !16, !17, !20, !21, !23, !24, !19}
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!16 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!17 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !18, line: 24, baseType: !19)
!18 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!19 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !18, line: 27, baseType: !7)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!24 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !25, size: 64)
!25 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!26 = !{!0, !27, !37, !39, !44, !52, !57, !65, !72}
!27 = !DIGlobalVariableExpression(var: !28, expr: !DIExpression())
!28 = distinct !DIGlobalVariable(name: "hashValues", scope: !2, file: !3, line: 56, type: !29, isLocal: false, isDefinition: true)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !30, line: 33, size: 160, elements: !31)
!30 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "9e37b5f46a8fb7f5ed35ab69309bf15d")
!31 = !{!32, !33, !34, !35, !36}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !29, file: !30, line: 34, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !29, file: !30, line: 35, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !29, file: !30, line: 36, baseType: !7, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !29, file: !30, line: 37, baseType: !7, size: 32, offset: 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !29, file: !30, line: 38, baseType: !7, size: 32, offset: 128)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "crc32_table", scope: !2, file: !3, line: 65, type: !29, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 350, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 32, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 4)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !46, line: 89, type: !47, isLocal: true, isDefinition: true)
!46 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "2601bcf9d7985cb46bfbd904b60f5aaf")
!47 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !48, size: 64)
!48 = !DISubroutineType(types: !49)
!49 = !{!50}
!50 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !18, line: 31, baseType: !51)
!51 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!52 = !DIGlobalVariableExpression(var: !53, expr: !DIExpression())
!53 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !46, line: 168, type: !54, isLocal: true, isDefinition: true)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = !DISubroutineType(types: !56)
!56 = !{!20}
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !46, line: 152, type: !59, isLocal: true, isDefinition: true)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !60, size: 64)
!60 = !DISubroutineType(types: !61)
!61 = !{!62, !63, !20, null}
!62 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !64, size: 64)
!64 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !22)
!65 = !DIGlobalVariableExpression(var: !66, expr: !DIExpression())
!66 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !46, line: 55, type: !67, isLocal: true, isDefinition: true)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !68, size: 64)
!68 = !DISubroutineType(types: !69)
!69 = !{!62, !15, !70, !70, !50}
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!72 = !DIGlobalVariableExpression(var: !73, expr: !DIExpression())
!73 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !46, line: 33, type: !74, isLocal: true, isDefinition: true)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = !DISubroutineType(types: !76)
!76 = !{!15, !15, !70}
!77 = !{i32 7, !"Dwarf Version", i32 5}
!78 = !{i32 2, !"Debug Info Version", i32 3}
!79 = !{i32 1, !"wchar_size", i32 4}
!80 = !{i32 7, !"frame-pointer", i32 2}
!81 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!82 = distinct !DISubprogram(name: "xdp_parsing", scope: !3, file: !3, line: 196, type: !83, scopeLine: 196, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
!83 = !DISubroutineType(types: !84)
!84 = !{!62, !85}
!85 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !86, size: 64)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 2856, size: 160, elements: !87)
!87 = !{!88, !89, !90, !91, !92}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !86, file: !6, line: 2857, baseType: !20, size: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !86, file: !6, line: 2858, baseType: !20, size: 32, offset: 32)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !86, file: !6, line: 2859, baseType: !20, size: 32, offset: 64)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !86, file: !6, line: 2861, baseType: !20, size: 32, offset: 96)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !86, file: !6, line: 2862, baseType: !20, size: 32, offset: 128)
!93 = !{!94, !95, !108, !138, !147, !148, !149, !172, !173, !174, !177, !178, !183, !184, !185, !188, !189, !191, !198, !201, !202}
!94 = !DILocalVariable(name: "ctx", arg: 1, scope: !82, file: !3, line: 196, type: !85)
!95 = !DILocalVariable(name: "eth", scope: !82, file: !3, line: 199, type: !96)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !98, line: 168, size: 112, elements: !99)
!98 = !DIFile(filename: "/usr/include/linux/if_ether.h", directory: "", checksumkind: CSK_MD5, checksum: "ab0320da726e75d904811ce344979934")
!99 = !{!100, !104, !105}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !97, file: !98, line: 169, baseType: !101, size: 48)
!101 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 48, elements: !102)
!102 = !{!103}
!103 = !DISubrange(count: 6)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !97, file: !98, line: 170, baseType: !101, size: 48, offset: 48)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !97, file: !98, line: 171, baseType: !106, size: 16, offset: 96)
!106 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !107, line: 25, baseType: !17)
!107 = !DIFile(filename: "/usr/include/linux/types.h", directory: "", checksumkind: CSK_MD5, checksum: "52ec79a38e49ac7d1dc9e146ba88a7b1")
!108 = !DILocalVariable(name: "iph", scope: !82, file: !3, line: 200, type: !109)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !111, line: 86, size: 160, elements: !112)
!111 = !DIFile(filename: "/usr/include/linux/ip.h", directory: "", checksumkind: CSK_MD5, checksum: "4e88ed297bc3832dfa96a5c9b60cec92")
!112 = !{!113, !115, !116, !117, !118, !119, !120, !121, !122, !124}
!113 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !110, file: !111, line: 88, baseType: !114, size: 4, flags: DIFlagBitField, extraData: i64 0)
!114 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !18, line: 21, baseType: !25)
!115 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !110, file: !111, line: 89, baseType: !114, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!116 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !110, file: !111, line: 96, baseType: !114, size: 8, offset: 8)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !110, file: !111, line: 97, baseType: !106, size: 16, offset: 16)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !110, file: !111, line: 98, baseType: !106, size: 16, offset: 32)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !110, file: !111, line: 99, baseType: !106, size: 16, offset: 48)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !110, file: !111, line: 100, baseType: !114, size: 8, offset: 64)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !110, file: !111, line: 101, baseType: !114, size: 8, offset: 72)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !110, file: !111, line: 102, baseType: !123, size: 16, offset: 80)
!123 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !107, line: 31, baseType: !17)
!124 = !DIDerivedType(tag: DW_TAG_member, scope: !110, file: !111, line: 103, baseType: !125, size: 64, offset: 96)
!125 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !110, file: !111, line: 103, size: 64, elements: !126)
!126 = !{!127, !133}
!127 = !DIDerivedType(tag: DW_TAG_member, scope: !125, file: !111, line: 103, baseType: !128, size: 64)
!128 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !125, file: !111, line: 103, size: 64, elements: !129)
!129 = !{!130, !132}
!130 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !128, file: !111, line: 103, baseType: !131, size: 32)
!131 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !107, line: 27, baseType: !20)
!132 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !128, file: !111, line: 103, baseType: !131, size: 32, offset: 32)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "addrs", scope: !125, file: !111, line: 103, baseType: !134, size: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !125, file: !111, line: 103, size: 64, elements: !135)
!135 = !{!136, !137}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !134, file: !111, line: 103, baseType: !131, size: 32)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !134, file: !111, line: 103, baseType: !131, size: 32, offset: 32)
!138 = !DILocalVariable(name: "udph", scope: !82, file: !3, line: 201, type: !139)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !140, size: 64)
!140 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !141, line: 23, size: 64, elements: !142)
!141 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "", checksumkind: CSK_MD5, checksum: "53c0d42e1bf6d93b39151764be2d20fb")
!142 = !{!143, !144, !145, !146}
!143 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !140, file: !141, line: 24, baseType: !106, size: 16)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !140, file: !141, line: 25, baseType: !106, size: 16, offset: 16)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !140, file: !141, line: 26, baseType: !106, size: 16, offset: 32)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !140, file: !141, line: 27, baseType: !123, size: 16, offset: 48)
!147 = !DILocalVariable(name: "data_end", scope: !82, file: !3, line: 203, type: !15)
!148 = !DILocalVariable(name: "data", scope: !82, file: !3, line: 204, type: !15)
!149 = !DILocalVariable(name: "payload", scope: !150, file: !3, line: 233, type: !154)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 226, column: 9)
!151 = distinct !DILexicalBlock(scope: !152, file: !3, line: 221, column: 13)
!152 = distinct !DILexicalBlock(scope: !153, file: !3, line: 207, column: 3)
!153 = distinct !DILexicalBlock(scope: !82, file: !3, line: 206, column: 6)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "auth_hdr", file: !3, line: 37, size: 264, elements: !156)
!156 = !{!157, !162, !165, !166, !169, !170, !171}
!157 = !DIDerivedType(tag: DW_TAG_member, name: "msgType", scope: !155, file: !3, line: 38, baseType: !158, size: 8)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !159, line: 24, baseType: !160)
!159 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "2bf2ae53c58c01b1a1b9383b5195125c")
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !161, line: 38, baseType: !25)
!161 = !DIFile(filename: "/usr/include/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!162 = !DIDerivedType(tag: DW_TAG_member, name: "challenge1", scope: !155, file: !3, line: 39, baseType: !163, size: 32, offset: 8)
!163 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !159, line: 26, baseType: !164)
!164 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !161, line: 42, baseType: !7)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "challenge2", scope: !155, file: !3, line: 40, baseType: !163, size: 32, offset: 40)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "randomnumber", scope: !155, file: !3, line: 41, baseType: !167, size: 64, offset: 72)
!167 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !159, line: 27, baseType: !168)
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !161, line: 48, baseType: !51)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !155, file: !3, line: 42, baseType: !163, size: 32, offset: 136)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "identifier", scope: !155, file: !3, line: 43, baseType: !163, size: 32, offset: 168)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "prTime", scope: !155, file: !3, line: 44, baseType: !167, size: 64, offset: 200)
!172 = !DILocalVariable(name: "msg_type", scope: !150, file: !3, line: 245, type: !158)
!173 = !DILocalVariable(name: "id", scope: !150, file: !3, line: 246, type: !163)
!174 = !DILocalVariable(name: "t1", scope: !175, file: !3, line: 252, type: !167)
!175 = distinct !DILexicalBlock(scope: !176, file: !3, line: 251, column: 12)
!176 = distinct !DILexicalBlock(scope: !150, file: !3, line: 250, column: 15)
!177 = !DILocalVariable(name: "h", scope: !175, file: !3, line: 253, type: !163)
!178 = !DILocalVariable(name: "____fmt", scope: !179, file: !3, line: 254, type: !180)
!179 = distinct !DILexicalBlock(scope: !175, file: !3, line: 254, column: 13)
!180 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 136, elements: !181)
!181 = !{!182}
!182 = !DISubrange(count: 17)
!183 = !DILocalVariable(name: "src_port", scope: !175, file: !3, line: 269, type: !106)
!184 = !DILocalVariable(name: "t2", scope: !175, file: !3, line: 283, type: !167)
!185 = !DILocalVariable(name: "t1", scope: !186, file: !3, line: 291, type: !167)
!186 = distinct !DILexicalBlock(scope: !187, file: !3, line: 290, column: 12)
!187 = distinct !DILexicalBlock(scope: !176, file: !3, line: 289, column: 20)
!188 = !DILocalVariable(name: "h1", scope: !186, file: !3, line: 292, type: !163)
!189 = !DILocalVariable(name: "h2", scope: !186, file: !3, line: 293, type: !190)
!190 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!191 = !DILocalVariable(name: "____fmt", scope: !192, file: !3, line: 297, type: !195)
!192 = distinct !DILexicalBlock(scope: !193, file: !3, line: 297, column: 14)
!193 = distinct !DILexicalBlock(scope: !194, file: !3, line: 296, column: 13)
!194 = distinct !DILexicalBlock(scope: !186, file: !3, line: 295, column: 16)
!195 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 240, elements: !196)
!196 = !{!197}
!197 = !DISubrange(count: 30)
!198 = !DILocalVariable(name: "src_port", scope: !199, file: !3, line: 314, type: !106)
!199 = distinct !DILexicalBlock(scope: !200, file: !3, line: 303, column: 13)
!200 = distinct !DILexicalBlock(scope: !186, file: !3, line: 302, column: 16)
!201 = !DILocalVariable(name: "t2", scope: !199, file: !3, line: 326, type: !167)
!202 = !DILocalVariable(name: "____fmt", scope: !203, file: !3, line: 332, type: !205)
!203 = distinct !DILexicalBlock(scope: !204, file: !3, line: 332, column: 4)
!204 = distinct !DILexicalBlock(scope: !200, file: !3, line: 331, column: 3)
!205 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 384, elements: !206)
!206 = !{!207}
!207 = !DISubrange(count: 48)
!208 = !DILocation(line: 0, scope: !82)
!209 = !DILocation(line: 203, column: 44, scope: !82)
!210 = !{!211, !212, i64 4}
!211 = !{!"xdp_md", !212, i64 0, !212, i64 4, !212, i64 8, !212, i64 12, !212, i64 16}
!212 = !{!"int", !213, i64 0}
!213 = !{!"omnipotent char", !214, i64 0}
!214 = !{!"Simple C/C++ TBAA"}
!215 = !DILocation(line: 203, column: 30, scope: !82)
!216 = !DILocation(line: 203, column: 21, scope: !82)
!217 = !DILocation(line: 204, column: 40, scope: !82)
!218 = !{!211, !212, i64 0}
!219 = !DILocation(line: 204, column: 26, scope: !82)
!220 = !DILocation(line: 204, column: 17, scope: !82)
!221 = !DILocation(line: 206, column: 11, scope: !153)
!222 = !DILocation(line: 206, column: 6, scope: !82)
!223 = !DILocation(line: 208, column: 15, scope: !152)
!224 = !DILocation(line: 209, column: 18, scope: !225)
!225 = distinct !DILexicalBlock(scope: !152, file: !3, line: 209, column: 13)
!226 = !DILocation(line: 209, column: 33, scope: !225)
!227 = !DILocation(line: 209, column: 13, scope: !152)
!228 = !DILocation(line: 212, column: 13, scope: !229)
!229 = distinct !DILexicalBlock(scope: !152, file: !3, line: 212, column: 13)
!230 = !{!231, !232, i64 12}
!231 = !{!"ethhdr", !213, i64 0, !213, i64 6, !232, i64 12}
!232 = !{!"short", !213, i64 0}
!233 = !DILocation(line: 212, column: 37, scope: !229)
!234 = !DILocation(line: 212, column: 13, scope: !152)
!235 = !DILocation(line: 218, column: 33, scope: !236)
!236 = distinct !DILexicalBlock(scope: !152, file: !3, line: 218, column: 13)
!237 = !DILocation(line: 218, column: 48, scope: !236)
!238 = !DILocation(line: 218, column: 13, scope: !152)
!239 = !DILocation(line: 221, column: 18, scope: !151)
!240 = !{!241, !213, i64 9}
!241 = !{!"iphdr", !213, i64 0, !213, i64 0, !213, i64 1, !232, i64 2, !232, i64 4, !232, i64 6, !213, i64 8, !213, i64 9, !232, i64 10, !213, i64 12}
!242 = !DILocation(line: 221, column: 27, scope: !151)
!243 = !DILocation(line: 221, column: 13, scope: !152)
!244 = !DILocation(line: 228, column: 51, scope: !245)
!245 = distinct !DILexicalBlock(scope: !150, file: !3, line: 228, column: 16)
!246 = !DILocation(line: 228, column: 67, scope: !245)
!247 = !DILocation(line: 228, column: 16, scope: !150)
!248 = !DILocation(line: 233, column: 39, scope: !150)
!249 = !DILocation(line: 0, scope: !150)
!250 = !DILocation(line: 235, column: 59, scope: !251)
!251 = distinct !DILexicalBlock(scope: !150, file: !3, line: 235, column: 8)
!252 = !DILocation(line: 235, column: 77, scope: !251)
!253 = !DILocation(line: 235, column: 8, scope: !150)
!254 = !DILocation(line: 245, column: 40, scope: !150)
!255 = !{!256, !213, i64 0}
!256 = !{!"auth_hdr", !213, i64 0, !212, i64 1, !212, i64 5, !257, i64 9, !212, i64 17, !212, i64 21, !257, i64 25}
!257 = !{!"long long", !213, i64 0}
!258 = !DILocation(line: 246, column: 12, scope: !150)
!259 = !DILocation(line: 246, column: 26, scope: !150)
!260 = !{!256, !212, i64 21}
!261 = !DILocation(line: 246, column: 56, scope: !150)
!262 = !DILocation(line: 246, column: 21, scope: !150)
!263 = !{!212, !212, i64 0}
!264 = !DILocation(line: 250, column: 15, scope: !150)
!265 = !DILocation(line: 252, column: 17, scope: !175)
!266 = !DILocation(line: 0, scope: !175)
!267 = !DILocation(line: 253, column: 13, scope: !175)
!268 = !DILocation(line: 253, column: 26, scope: !175)
!269 = !DILocation(line: 253, column: 22, scope: !175)
!270 = !DILocation(line: 254, column: 13, scope: !179)
!271 = !DILocation(line: 254, column: 13, scope: !175)
!272 = !DILocation(line: 255, column: 8, scope: !273)
!273 = distinct !DILexicalBlock(scope: !175, file: !3, line: 255, column: 6)
!274 = !DILocation(line: 255, column: 6, scope: !175)
!275 = !DILocation(line: 259, column: 14, scope: !276)
!276 = distinct !DILexicalBlock(scope: !273, file: !3, line: 258, column: 13)
!277 = !DILocalVariable(name: "iphdr", arg: 1, scope: !278, file: !279, line: 136, type: !109)
!278 = distinct !DISubprogram(name: "swap_src_dst_ipv4", scope: !279, file: !279, line: 136, type: !280, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !282)
!279 = !DIFile(filename: "./../common/rewrite_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "75040841dc53cbf2ffc17c0802a4440a")
!280 = !DISubroutineType(types: !281)
!281 = !{null, !109}
!282 = !{!277, !283}
!283 = !DILocalVariable(name: "tmp", scope: !278, file: !279, line: 138, type: !131)
!284 = !DILocation(line: 0, scope: !278, inlinedAt: !285)
!285 = distinct !DILocation(line: 265, column: 7, scope: !175)
!286 = !DILocation(line: 138, column: 22, scope: !278, inlinedAt: !285)
!287 = !{!213, !213, i64 0}
!288 = !DILocation(line: 140, column: 24, scope: !278, inlinedAt: !285)
!289 = !DILocation(line: 140, column: 15, scope: !278, inlinedAt: !285)
!290 = !DILocation(line: 141, column: 15, scope: !278, inlinedAt: !285)
!291 = !DILocalVariable(name: "eth", arg: 1, scope: !292, file: !279, line: 113, type: !96)
!292 = distinct !DISubprogram(name: "swap_src_dst_mac", scope: !279, file: !279, line: 113, type: !293, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !295)
!293 = !DISubroutineType(types: !294)
!294 = !{null, !96}
!295 = !{!291, !296}
!296 = !DILocalVariable(name: "h_tmp", scope: !292, file: !279, line: 115, type: !297)
!297 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, size: 48, elements: !102)
!298 = !DILocation(line: 0, scope: !292, inlinedAt: !299)
!299 = distinct !DILocation(line: 267, column: 7, scope: !175)
!300 = !DILocation(line: 115, column: 2, scope: !292, inlinedAt: !299)
!301 = !DILocation(line: 115, column: 7, scope: !292, inlinedAt: !299)
!302 = !DILocation(line: 117, column: 2, scope: !292, inlinedAt: !299)
!303 = !DILocation(line: 118, column: 2, scope: !292, inlinedAt: !299)
!304 = !DILocation(line: 119, column: 2, scope: !292, inlinedAt: !299)
!305 = !DILocation(line: 120, column: 1, scope: !292, inlinedAt: !299)
!306 = !DILocation(line: 269, column: 31, scope: !175)
!307 = !{!308, !232, i64 0}
!308 = !{!"udphdr", !232, i64 0, !232, i64 2, !232, i64 4, !232, i64 6}
!309 = !DILocation(line: 270, column: 28, scope: !175)
!310 = !{!308, !232, i64 2}
!311 = !DILocation(line: 270, column: 20, scope: !175)
!312 = !DILocation(line: 271, column: 18, scope: !175)
!313 = !DILocation(line: 276, column: 13, scope: !175)
!314 = !DILocation(line: 276, column: 19, scope: !175)
!315 = !{!308, !232, i64 6}
!316 = !DILocation(line: 279, column: 12, scope: !175)
!317 = !DILocation(line: 279, column: 18, scope: !175)
!318 = !{!241, !232, i64 10}
!319 = !DILocation(line: 280, column: 20, scope: !175)
!320 = !DILocation(line: 280, column: 18, scope: !175)
!321 = !DILocation(line: 283, column: 17, scope: !175)
!322 = !DILocation(line: 284, column: 20, scope: !175)
!323 = !DILocation(line: 284, column: 12, scope: !175)
!324 = !DILocation(line: 284, column: 18, scope: !175)
!325 = !{!256, !257, i64 25}
!326 = !DILocation(line: 287, column: 12, scope: !176)
!327 = !DILocation(line: 291, column: 17, scope: !186)
!328 = !DILocation(line: 0, scope: !186)
!329 = !DILocation(line: 292, column: 27, scope: !186)
!330 = !{!256, !212, i64 17}
!331 = !DILocation(line: 293, column: 28, scope: !186)
!332 = !DILocation(line: 295, column: 17, scope: !194)
!333 = !DILocation(line: 295, column: 16, scope: !186)
!334 = !DILocation(line: 297, column: 14, scope: !192)
!335 = !DILocation(line: 297, column: 14, scope: !193)
!336 = !DILocation(line: 298, column: 14, scope: !193)
!337 = !DILocation(line: 302, column: 22, scope: !200)
!338 = !DILocation(line: 302, column: 19, scope: !200)
!339 = !DILocation(line: 302, column: 16, scope: !186)
!340 = !DILocation(line: 304, column: 31, scope: !199)
!341 = !DILocation(line: 305, column: 36, scope: !199)
!342 = !DILocation(line: 305, column: 34, scope: !199)
!343 = !DILocation(line: 0, scope: !278, inlinedAt: !344)
!344 = distinct !DILocation(line: 310, column: 8, scope: !199)
!345 = !DILocation(line: 138, column: 22, scope: !278, inlinedAt: !344)
!346 = !DILocation(line: 140, column: 24, scope: !278, inlinedAt: !344)
!347 = !DILocation(line: 140, column: 15, scope: !278, inlinedAt: !344)
!348 = !DILocation(line: 141, column: 15, scope: !278, inlinedAt: !344)
!349 = !DILocation(line: 0, scope: !292, inlinedAt: !350)
!350 = distinct !DILocation(line: 312, column: 8, scope: !199)
!351 = !DILocation(line: 115, column: 2, scope: !292, inlinedAt: !350)
!352 = !DILocation(line: 115, column: 7, scope: !292, inlinedAt: !350)
!353 = !DILocation(line: 117, column: 2, scope: !292, inlinedAt: !350)
!354 = !DILocation(line: 118, column: 2, scope: !292, inlinedAt: !350)
!355 = !DILocation(line: 119, column: 2, scope: !292, inlinedAt: !350)
!356 = !DILocation(line: 120, column: 1, scope: !292, inlinedAt: !350)
!357 = !DILocation(line: 314, column: 32, scope: !199)
!358 = !DILocation(line: 0, scope: !199)
!359 = !DILocation(line: 315, column: 29, scope: !199)
!360 = !DILocation(line: 315, column: 21, scope: !199)
!361 = !DILocation(line: 316, column: 19, scope: !199)
!362 = !DILocation(line: 320, column: 14, scope: !199)
!363 = !DILocation(line: 320, column: 20, scope: !199)
!364 = !DILocation(line: 323, column: 13, scope: !199)
!365 = !DILocation(line: 323, column: 19, scope: !199)
!366 = !DILocation(line: 324, column: 21, scope: !199)
!367 = !DILocation(line: 324, column: 19, scope: !199)
!368 = !DILocation(line: 326, column: 22, scope: !199)
!369 = !DILocation(line: 327, column: 21, scope: !199)
!370 = !DILocation(line: 327, column: 13, scope: !199)
!371 = !DILocation(line: 327, column: 19, scope: !199)
!372 = !DILocation(line: 338, column: 9, scope: !151)
!373 = !DILocation(line: 332, column: 4, scope: !203)
!374 = !DILocation(line: 332, column: 4, scope: !204)
!375 = !DILocation(line: 347, column: 3, scope: !82)
!376 = !DILocation(line: 349, column: 1, scope: !82)
!377 = distinct !DISubprogram(name: "make_challenge_header", scope: !3, file: !3, line: 109, type: !378, scopeLine: 110, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !380)
!378 = !DISubroutineType(types: !379)
!379 = !{!163, !154}
!380 = !{!381, !382, !387, !388, !397, !398, !399, !400, !407, !408, !409, !410, !411, !412, !416}
!381 = !DILocalVariable(name: "payload", arg: 1, scope: !377, file: !3, line: 109, type: !154)
!382 = !DILocalVariable(name: "____fmt", scope: !383, file: !3, line: 111, type: !384)
!383 = distinct !DILexicalBlock(scope: !377, file: !3, line: 111, column: 2)
!384 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 368, elements: !385)
!385 = !{!386}
!386 = !DISubrange(count: 46)
!387 = !DILocalVariable(name: "id", scope: !377, file: !3, line: 113, type: !163)
!388 = !DILocalVariable(name: "rec", scope: !377, file: !3, line: 115, type: !389)
!389 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !390, size: 64)
!390 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "crPair", file: !391, line: 13, size: 256, elements: !392)
!391 = !DIFile(filename: "./common_kern_user.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/xdp-puf", checksumkind: CSK_MD5, checksum: "cf181cfa91b808d00c3d46c58e57846f")
!392 = !{!393, !394, !395, !396}
!393 = !DIDerivedType(tag: DW_TAG_member, name: "ch1", scope: !390, file: !391, line: 14, baseType: !163, size: 32)
!394 = !DIDerivedType(tag: DW_TAG_member, name: "resp1", scope: !390, file: !391, line: 15, baseType: !167, size: 64, offset: 64)
!395 = !DIDerivedType(tag: DW_TAG_member, name: "ch2", scope: !390, file: !391, line: 16, baseType: !163, size: 32, offset: 128)
!396 = !DIDerivedType(tag: DW_TAG_member, name: "resp2", scope: !390, file: !391, line: 17, baseType: !167, size: 64, offset: 192)
!397 = !DILocalVariable(name: "RN", scope: !377, file: !3, line: 117, type: !167)
!398 = !DILocalVariable(name: "i", scope: !377, file: !3, line: 119, type: !20)
!399 = !DILocalVariable(name: "key", scope: !377, file: !3, line: 121, type: !20)
!400 = !DILocalVariable(name: "____fmt", scope: !401, file: !3, line: 127, type: !404)
!401 = distinct !DILexicalBlock(scope: !402, file: !3, line: 127, column: 10)
!402 = distinct !DILexicalBlock(scope: !403, file: !3, line: 126, column: 9)
!403 = distinct !DILexicalBlock(scope: !377, file: !3, line: 125, column: 13)
!404 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 168, elements: !405)
!405 = !{!406}
!406 = !DISubrange(count: 21)
!407 = !DILocalVariable(name: "c1", scope: !377, file: !3, line: 131, type: !163)
!408 = !DILocalVariable(name: "c2", scope: !377, file: !3, line: 132, type: !163)
!409 = !DILocalVariable(name: "r1", scope: !377, file: !3, line: 133, type: !167)
!410 = !DILocalVariable(name: "r2", scope: !377, file: !3, line: 134, type: !167)
!411 = !DILocalVariable(name: "RN1", scope: !377, file: !3, line: 138, type: !167)
!412 = !DILocalVariable(name: "input_ints", scope: !377, file: !3, line: 148, type: !413)
!413 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 192, elements: !414)
!414 = !{!415}
!415 = !DISubrange(count: 3)
!416 = !DILocalVariable(name: "hash", scope: !377, file: !3, line: 155, type: !163)
!417 = !DILocation(line: 83, column: 5, scope: !418, inlinedAt: !445)
!418 = distinct !DISubprogram(name: "computeHash", scope: !3, file: !3, line: 73, type: !419, scopeLine: 74, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !422)
!419 = !DISubroutineType(types: !420)
!420 = !{!20, !421, !20}
!421 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!422 = !{!423, !424, !425, !427, !431, !433, !434, !436, !439, !441}
!423 = !DILocalVariable(name: "input_ints", arg: 1, scope: !418, file: !3, line: 73, type: !421)
!424 = !DILocalVariable(name: "num_ints", arg: 2, scope: !418, file: !3, line: 73, type: !20)
!425 = !DILocalVariable(name: "__vla_expr0", scope: !418, type: !426, flags: DIFlagArtificial)
!426 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!427 = !DILocalVariable(name: "buffer", scope: !418, file: !3, line: 83, type: !428)
!428 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, elements: !429)
!429 = !{!430}
!430 = !DISubrange(count: !425)
!431 = !DILocalVariable(name: "i", scope: !432, file: !3, line: 84, type: !20)
!432 = distinct !DILexicalBlock(scope: !418, file: !3, line: 84, column: 5)
!433 = !DILocalVariable(name: "crc", scope: !418, file: !3, line: 89, type: !20)
!434 = !DILocalVariable(name: "i", scope: !435, file: !3, line: 90, type: !20)
!435 = distinct !DILexicalBlock(scope: !418, file: !3, line: 90, column: 5)
!436 = !DILocalVariable(name: "index", scope: !437, file: !3, line: 92, type: !20)
!437 = distinct !DILexicalBlock(scope: !438, file: !3, line: 90, column: 48)
!438 = distinct !DILexicalBlock(scope: !435, file: !3, line: 90, column: 5)
!439 = !DILocalVariable(name: "rec", scope: !437, file: !3, line: 93, type: !440)
!440 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !62, size: 64)
!441 = !DILocalVariable(name: "____fmt", scope: !442, file: !3, line: 97, type: !404)
!442 = distinct !DILexicalBlock(scope: !443, file: !3, line: 97, column: 17)
!443 = distinct !DILexicalBlock(scope: !444, file: !3, line: 96, column: 9)
!444 = distinct !DILexicalBlock(scope: !437, file: !3, line: 95, column: 13)
!445 = distinct !DILocation(line: 155, column: 18, scope: !377)
!446 = !DILocation(line: 0, scope: !377)
!447 = !DILocation(line: 111, column: 2, scope: !383)
!448 = !DILocation(line: 111, column: 2, scope: !377)
!449 = !DILocation(line: 113, column: 16, scope: !377)
!450 = !DILocation(line: 117, column: 23, scope: !377)
!451 = !DILocation(line: 119, column: 21, scope: !377)
!452 = !DILocation(line: 121, column: 9, scope: !377)
!453 = !DILocation(line: 121, column: 24, scope: !377)
!454 = !DILocation(line: 121, column: 35, scope: !377)
!455 = !DILocation(line: 121, column: 15, scope: !377)
!456 = !DILocation(line: 123, column: 8, scope: !377)
!457 = !DILocation(line: 125, column: 14, scope: !403)
!458 = !DILocation(line: 125, column: 13, scope: !377)
!459 = !DILocation(line: 127, column: 10, scope: !401)
!460 = !DILocation(line: 127, column: 10, scope: !402)
!461 = !DILocation(line: 128, column: 3, scope: !402)
!462 = !DILocation(line: 131, column: 26, scope: !377)
!463 = !{!464, !212, i64 0}
!464 = !{!"crPair", !212, i64 0, !257, i64 8, !212, i64 16, !257, i64 24}
!465 = !DILocation(line: 132, column: 26, scope: !377)
!466 = !{!464, !212, i64 16}
!467 = !DILocation(line: 133, column: 19, scope: !377)
!468 = !{!464, !257, i64 8}
!469 = !DILocation(line: 134, column: 19, scope: !377)
!470 = !{!464, !257, i64 24}
!471 = !DILocation(line: 138, column: 34, scope: !377)
!472 = !DILocation(line: 142, column: 11, scope: !377)
!473 = !DILocation(line: 142, column: 19, scope: !377)
!474 = !DILocation(line: 143, column: 24, scope: !377)
!475 = !DILocation(line: 143, column: 11, scope: !377)
!476 = !DILocation(line: 143, column: 22, scope: !377)
!477 = !{!256, !212, i64 1}
!478 = !DILocation(line: 144, column: 24, scope: !377)
!479 = !DILocation(line: 144, column: 11, scope: !377)
!480 = !DILocation(line: 144, column: 22, scope: !377)
!481 = !{!256, !212, i64 5}
!482 = !DILocation(line: 145, column: 26, scope: !377)
!483 = !DILocation(line: 145, column: 11, scope: !377)
!484 = !DILocation(line: 145, column: 24, scope: !377)
!485 = !{!256, !257, i64 9}
!486 = !DILocation(line: 146, column: 22, scope: !377)
!487 = !DILocation(line: 0, scope: !418, inlinedAt: !445)
!488 = !DILocation(line: 83, column: 10, scope: !418, inlinedAt: !445)
!489 = !DILocation(line: 0, scope: !432, inlinedAt: !445)
!490 = !DILocation(line: 85, column: 9, scope: !491, inlinedAt: !445)
!491 = distinct !DILexicalBlock(scope: !492, file: !3, line: 84, column: 42)
!492 = distinct !DILexicalBlock(scope: !432, file: !3, line: 84, column: 5)
!493 = !DILocation(line: 0, scope: !435, inlinedAt: !445)
!494 = !DILocation(line: 92, column: 2, scope: !437, inlinedAt: !445)
!495 = !DILocation(line: 92, column: 24, scope: !437, inlinedAt: !445)
!496 = !DILocation(line: 92, column: 35, scope: !437, inlinedAt: !445)
!497 = !DILocation(line: 0, scope: !437, inlinedAt: !445)
!498 = !DILocation(line: 92, column: 8, scope: !437, inlinedAt: !445)
!499 = !DILocation(line: 93, column: 20, scope: !437, inlinedAt: !445)
!500 = !DILocation(line: 95, column: 14, scope: !444, inlinedAt: !445)
!501 = !DILocation(line: 95, column: 13, scope: !437, inlinedAt: !445)
!502 = distinct !{!502, !503, !504, !505}
!503 = !DILocation(line: 90, column: 5, scope: !435, inlinedAt: !445)
!504 = !DILocation(line: 103, column: 5, scope: !435, inlinedAt: !445)
!505 = !{!"llvm.loop.mustprogress"}
!506 = !DILocation(line: 90, column: 25, scope: !438, inlinedAt: !445)
!507 = !DILocation(line: 97, column: 17, scope: !442, inlinedAt: !445)
!508 = !DILocation(line: 97, column: 17, scope: !443, inlinedAt: !445)
!509 = !DILocation(line: 103, column: 5, scope: !438, inlinedAt: !445)
!510 = !DILocation(line: 102, column: 13, scope: !437, inlinedAt: !445)
!511 = !DILocation(line: 102, column: 22, scope: !437, inlinedAt: !445)
!512 = !DILocation(line: 102, column: 19, scope: !437, inlinedAt: !445)
!513 = !DILocation(line: 90, column: 44, scope: !438, inlinedAt: !445)
!514 = !DILocation(line: 107, column: 1, scope: !418, inlinedAt: !445)
!515 = !DILocation(line: 163, column: 1, scope: !377)
!516 = distinct !DISubprogram(name: "ip_checksum", scope: !3, file: !3, line: 165, type: !517, scopeLine: 165, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !519)
!517 = !DISubroutineType(types: !518)
!518 = !{!19, !15, !7}
!519 = !{!520, !521, !522, !523}
!520 = !DILocalVariable(name: "vdata", arg: 1, scope: !516, file: !3, line: 165, type: !15)
!521 = !DILocalVariable(name: "length", arg: 2, scope: !516, file: !3, line: 165, type: !7)
!522 = !DILocalVariable(name: "data", scope: !516, file: !3, line: 167, type: !21)
!523 = !DILocalVariable(name: "sum", scope: !516, file: !3, line: 170, type: !7)
!524 = !DILocation(line: 0, scope: !516)
!525 = !DILocation(line: 174, column: 16, scope: !526)
!526 = distinct !DILexicalBlock(scope: !516, file: !3, line: 173, column: 24)
!527 = !{!232, !232, i64 0}
!528 = !DILocation(line: 175, column: 14, scope: !526)
!529 = !DILocation(line: 174, column: 13, scope: !526)
!530 = !DILocation(line: 185, column: 5, scope: !516)
!531 = !DILocation(line: 185, column: 16, scope: !516)
!532 = !DILocation(line: 186, column: 20, scope: !533)
!533 = distinct !DILexicalBlock(scope: !516, file: !3, line: 185, column: 23)
!534 = !DILocation(line: 186, column: 30, scope: !533)
!535 = distinct !{!535, !530, !536, !505}
!536 = !DILocation(line: 187, column: 5, scope: !516)
!537 = !DILocation(line: 190, column: 12, scope: !516)
!538 = !DILocation(line: 190, column: 5, scope: !516)
