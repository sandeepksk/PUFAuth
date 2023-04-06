; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.auth_hdr = type <{ i8, i32, i32, i64, i64, i32, i32, i64 }>

@cr_db_map = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 48, i32 250000, i32 0 }, section "maps", align 4, !dbg !0
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
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !94, metadata !DIExpression()), !dbg !209
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !210
  %10 = load i32, i32* %9, align 4, !dbg !210, !tbaa !211
  %11 = zext i32 %10 to i64, !dbg !216
  %12 = inttoptr i64 %11 to i8*, !dbg !217
  call void @llvm.dbg.value(metadata i8* %12, metadata !147, metadata !DIExpression()), !dbg !209
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !218
  %14 = load i32, i32* %13, align 4, !dbg !218, !tbaa !219
  %15 = zext i32 %14 to i64, !dbg !220
  %16 = inttoptr i64 %15 to i8*, !dbg !221
  call void @llvm.dbg.value(metadata i8* %16, metadata !148, metadata !DIExpression()), !dbg !209
  %17 = icmp ult i8* %16, %12, !dbg !222
  br i1 %17, label %18, label %135, !dbg !223

18:                                               ; preds = %1
  %19 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !224
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !95, metadata !DIExpression()), !dbg !209
  %20 = getelementptr i8, i8* %16, i64 14, !dbg !225
  %21 = icmp ugt i8* %20, %12, !dbg !227
  br i1 %21, label %135, label %22, !dbg !228

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 2, !dbg !229
  %24 = load i16, i16* %23, align 1, !dbg !229, !tbaa !231
  %25 = icmp eq i16 %24, 8, !dbg !234
  br i1 %25, label %26, label %135, !dbg !235

26:                                               ; preds = %22
  call void @llvm.dbg.value(metadata i8* %20, metadata !108, metadata !DIExpression()), !dbg !209
  %27 = getelementptr i8, i8* %16, i64 34, !dbg !236
  %28 = icmp ugt i8* %27, %12, !dbg !238
  br i1 %28, label %135, label %29, !dbg !239

29:                                               ; preds = %26
  %30 = getelementptr i8, i8* %16, i64 23, !dbg !240
  %31 = load i8, i8* %30, align 1, !dbg !240, !tbaa !241
  %32 = icmp eq i8 %31, 17, !dbg !243
  br i1 %32, label %33, label %135, !dbg !244

33:                                               ; preds = %29
  call void @llvm.dbg.value(metadata i8* %27, metadata !138, metadata !DIExpression()), !dbg !209
  %34 = getelementptr i8, i8* %16, i64 42, !dbg !245
  %35 = icmp ugt i8* %34, %12, !dbg !247
  br i1 %35, label %135, label %36, !dbg !248

36:                                               ; preds = %33
  %37 = bitcast i8* %34 to %struct.auth_hdr*, !dbg !249
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %37, metadata !149, metadata !DIExpression()), !dbg !250
  %38 = getelementptr i8, i8* %16, i64 83, !dbg !251
  %39 = icmp ugt i8* %38, %12, !dbg !253
  br i1 %39, label %135, label %40, !dbg !254

40:                                               ; preds = %36
  %41 = load i8, i8* %34, align 1, !dbg !255, !tbaa !256
  call void @llvm.dbg.value(metadata i8 %41, metadata !173, metadata !DIExpression()), !dbg !250
  %42 = bitcast i32* %4 to i8*, !dbg !259
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %42) #7, !dbg !259
  %43 = getelementptr i8, i8* %16, i64 71, !dbg !260
  %44 = bitcast i8* %43 to i32*, !dbg !260
  %45 = load i32, i32* %44, align 1, !dbg !260, !tbaa !261
  %46 = tail call i32 @llvm.bswap.i32(i32 %45), !dbg !260
  %47 = add i32 %46, -1, !dbg !262
  call void @llvm.dbg.value(metadata i32 %47, metadata !174, metadata !DIExpression()), !dbg !250
  store i32 %47, i32* %4, align 4, !dbg !263, !tbaa !264
  switch i8 %41, label %130 [
    i8 0, label %48
    i8 2, label %85
  ], !dbg !265

48:                                               ; preds = %40
  %49 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !266
  call void @llvm.dbg.value(metadata i64 %49, metadata !175, metadata !DIExpression()), !dbg !267
  %50 = bitcast i32* %5 to i8*, !dbg !268
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %50) #7, !dbg !268
  %51 = tail call fastcc i32 @make_challenge_header(%struct.auth_hdr* noundef nonnull %37), !dbg !269
  call void @llvm.dbg.value(metadata i32 %51, metadata !178, metadata !DIExpression()), !dbg !267
  store i32 %51, i32* %5, align 4, !dbg !270, !tbaa !264
  %52 = getelementptr inbounds [17 x i8], [17 x i8]* %6, i64 0, i64 0, !dbg !271
  call void @llvm.lifetime.start.p0i8(i64 17, i8* nonnull %52) #7, !dbg !271
  call void @llvm.dbg.declare(metadata [17 x i8]* %6, metadata !179, metadata !DIExpression()), !dbg !271
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(17) %52, i8* noundef nonnull align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8]* @__const.xdp_parsing.____fmt, i64 0, i64 0), i64 17, i1 false), !dbg !271
  %53 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %52, i32 noundef 17, i32 noundef %51) #7, !dbg !271
  call void @llvm.lifetime.end.p0i8(i64 17, i8* nonnull %52) #7, !dbg !272
  call void @llvm.dbg.value(metadata i32 %51, metadata !178, metadata !DIExpression()), !dbg !267
  %54 = icmp eq i32 %51, -1, !dbg !273
  br i1 %54, label %83, label %55, !dbg !275

55:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i32* %4, metadata !174, metadata !DIExpression(DW_OP_deref)), !dbg !250
  call void @llvm.dbg.value(metadata i32* %5, metadata !178, metadata !DIExpression(DW_OP_deref)), !dbg !267
  %56 = call i32 inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42, i8* noundef nonnull %50, i64 noundef 0) #7, !dbg !276
  call void @llvm.dbg.value(metadata i8* %20, metadata !278, metadata !DIExpression()), !dbg !285
  %57 = getelementptr i8, i8* %16, i64 26, !dbg !287
  %58 = bitcast i8* %57 to i32*, !dbg !287
  %59 = load i32, i32* %58, align 4, !dbg !287, !tbaa !288
  call void @llvm.dbg.value(metadata i32 %59, metadata !284, metadata !DIExpression()), !dbg !285
  %60 = getelementptr i8, i8* %16, i64 30, !dbg !289
  %61 = bitcast i8* %60 to i32*, !dbg !289
  %62 = load i32, i32* %61, align 4, !dbg !289, !tbaa !288
  store i32 %62, i32* %58, align 4, !dbg !290, !tbaa !288
  store i32 %59, i32* %61, align 4, !dbg !291, !tbaa !288
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !292, metadata !DIExpression()) #7, !dbg !299
  %63 = getelementptr inbounds [6 x i8], [6 x i8]* %3, i64 0, i64 0, !dbg !301
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %63), !dbg !301
  call void @llvm.dbg.declare(metadata [6 x i8]* %3, metadata !297, metadata !DIExpression()) #7, !dbg !302
  %64 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !303
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %63, i8* noundef nonnull align 1 dereferenceable(6) %64, i64 6, i1 false) #7, !dbg !303
  %65 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !304
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %64, i8* noundef nonnull align 1 dereferenceable(6) %65, i64 6, i1 false) #7, !dbg !304
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %65, i8* noundef nonnull align 1 dereferenceable(6) %63, i64 6, i1 false) #7, !dbg !305
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %63), !dbg !306
  %66 = bitcast i8* %27 to i16*, !dbg !307
  %67 = load i16, i16* %66, align 2, !dbg !307, !tbaa !308
  call void @llvm.dbg.value(metadata i16 %67, metadata !184, metadata !DIExpression()), !dbg !267
  %68 = getelementptr i8, i8* %16, i64 36, !dbg !310
  %69 = bitcast i8* %68 to i16*, !dbg !310
  %70 = load i16, i16* %69, align 2, !dbg !310, !tbaa !311
  store i16 %70, i16* %66, align 2, !dbg !312, !tbaa !308
  store i16 %67, i16* %69, align 2, !dbg !313, !tbaa !311
  %71 = getelementptr i8, i8* %16, i64 40, !dbg !314
  %72 = bitcast i8* %71 to i16*, !dbg !314
  store i16 0, i16* %72, align 2, !dbg !315, !tbaa !316
  %73 = getelementptr i8, i8* %16, i64 24, !dbg !317
  %74 = bitcast i8* %73 to i16*, !dbg !317
  store i16 0, i16* %74, align 2, !dbg !318, !tbaa !319
  %75 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !320
  store i16 %75, i16* %74, align 2, !dbg !321, !tbaa !319
  %76 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !322
  call void @llvm.dbg.value(metadata i64 %76, metadata !185, metadata !DIExpression()), !dbg !267
  %77 = sub i64 %76, %49, !dbg !323
  %78 = trunc i64 %77 to i32
  %79 = call i32 @llvm.bswap.i32(i32 %78), !dbg !323
  %80 = zext i32 %79 to i64, !dbg !323
  %81 = getelementptr i8, i8* %16, i64 75, !dbg !324
  %82 = bitcast i8* %81 to i64*, !dbg !324
  store i64 %80, i64* %82, align 1, !dbg !325, !tbaa !326
  br label %83

83:                                               ; preds = %48, %55
  %84 = phi i32 [ 3, %55 ], [ 0, %48 ], !dbg !267
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %50) #7, !dbg !327
  br label %130

85:                                               ; preds = %40
  %86 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !328
  call void @llvm.dbg.value(metadata i64 %86, metadata !186, metadata !DIExpression()), !dbg !329
  %87 = getelementptr i8, i8* %16, i64 67, !dbg !330
  %88 = bitcast i8* %87 to i32*, !dbg !330
  %89 = load i32, i32* %88, align 1, !dbg !330, !tbaa !331
  call void @llvm.dbg.value(metadata i32 undef, metadata !189, metadata !DIExpression()), !dbg !329
  call void @llvm.dbg.value(metadata i32* %4, metadata !174, metadata !DIExpression(DW_OP_deref)), !dbg !250
  %90 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42) #7, !dbg !332
  call void @llvm.dbg.value(metadata i8* %90, metadata !190, metadata !DIExpression()), !dbg !329
  %91 = icmp eq i8* %90, null, !dbg !333
  br i1 %91, label %92, label %95, !dbg !334

92:                                               ; preds = %85
  %93 = getelementptr inbounds [30 x i8], [30 x i8]* %7, i64 0, i64 0, !dbg !335
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %93) #7, !dbg !335
  call void @llvm.dbg.declare(metadata [30 x i8]* %7, metadata !192, metadata !DIExpression()), !dbg !335
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(30) %93, i8* noundef nonnull align 1 dereferenceable(30) getelementptr inbounds ([30 x i8], [30 x i8]* @__const.xdp_parsing.____fmt.1, i64 0, i64 0), i64 30, i1 false), !dbg !335
  %94 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %93, i32 noundef 30) #7, !dbg !335
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %93) #7, !dbg !336
  br label %130, !dbg !337

95:                                               ; preds = %85
  %96 = call i32 @llvm.bswap.i32(i32 %89), !dbg !330
  call void @llvm.dbg.value(metadata i32 %96, metadata !189, metadata !DIExpression()), !dbg !329
  %97 = bitcast i8* %90 to i32*, !dbg !332
  call void @llvm.dbg.value(metadata i32* %97, metadata !190, metadata !DIExpression()), !dbg !329
  %98 = load i32, i32* %97, align 4, !dbg !338, !tbaa !264
  %99 = icmp eq i32 %96, %98, !dbg !339
  br i1 %99, label %100, label %132, !dbg !340

100:                                              ; preds = %95
  store i8 3, i8* %34, align 1, !dbg !341, !tbaa !256
  %101 = load i32, i32* %4, align 4, !dbg !342, !tbaa !264
  call void @llvm.dbg.value(metadata i32 %101, metadata !174, metadata !DIExpression()), !dbg !250
  %102 = add i32 %101, 1, !dbg !342
  %103 = call i32 @llvm.bswap.i32(i32 %102), !dbg !342
  store i32 %103, i32* %44, align 1, !dbg !343, !tbaa !261
  call void @llvm.dbg.value(metadata i8* %20, metadata !278, metadata !DIExpression()), !dbg !344
  %104 = getelementptr i8, i8* %16, i64 26, !dbg !346
  %105 = bitcast i8* %104 to i32*, !dbg !346
  %106 = load i32, i32* %105, align 4, !dbg !346, !tbaa !288
  call void @llvm.dbg.value(metadata i32 %106, metadata !284, metadata !DIExpression()), !dbg !344
  %107 = getelementptr i8, i8* %16, i64 30, !dbg !347
  %108 = bitcast i8* %107 to i32*, !dbg !347
  %109 = load i32, i32* %108, align 4, !dbg !347, !tbaa !288
  store i32 %109, i32* %105, align 4, !dbg !348, !tbaa !288
  store i32 %106, i32* %108, align 4, !dbg !349, !tbaa !288
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !292, metadata !DIExpression()) #7, !dbg !350
  %110 = getelementptr inbounds [6 x i8], [6 x i8]* %2, i64 0, i64 0, !dbg !352
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %110), !dbg !352
  call void @llvm.dbg.declare(metadata [6 x i8]* %2, metadata !297, metadata !DIExpression()) #7, !dbg !353
  %111 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !354
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %110, i8* noundef nonnull align 1 dereferenceable(6) %111, i64 6, i1 false) #7, !dbg !354
  %112 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !355
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %111, i8* noundef nonnull align 1 dereferenceable(6) %112, i64 6, i1 false) #7, !dbg !355
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %112, i8* noundef nonnull align 1 dereferenceable(6) %110, i64 6, i1 false) #7, !dbg !356
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %110), !dbg !357
  %113 = bitcast i8* %27 to i16*, !dbg !358
  %114 = load i16, i16* %113, align 2, !dbg !358, !tbaa !308
  call void @llvm.dbg.value(metadata i16 %114, metadata !199, metadata !DIExpression()), !dbg !359
  %115 = getelementptr i8, i8* %16, i64 36, !dbg !360
  %116 = bitcast i8* %115 to i16*, !dbg !360
  %117 = load i16, i16* %116, align 2, !dbg !360, !tbaa !311
  store i16 %117, i16* %113, align 2, !dbg !361, !tbaa !308
  store i16 %114, i16* %116, align 2, !dbg !362, !tbaa !311
  %118 = getelementptr i8, i8* %16, i64 40, !dbg !363
  %119 = bitcast i8* %118 to i16*, !dbg !363
  store i16 0, i16* %119, align 2, !dbg !364, !tbaa !316
  %120 = getelementptr i8, i8* %16, i64 24, !dbg !365
  %121 = bitcast i8* %120 to i16*, !dbg !365
  store i16 0, i16* %121, align 2, !dbg !366, !tbaa !319
  %122 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !367
  store i16 %122, i16* %121, align 2, !dbg !368, !tbaa !319
  %123 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !369
  call void @llvm.dbg.value(metadata i64 %123, metadata !202, metadata !DIExpression()), !dbg !359
  %124 = sub i64 %123, %86, !dbg !370
  %125 = trunc i64 %124 to i32, !dbg !370
  %126 = call i32 @llvm.bswap.i32(i32 %125), !dbg !370
  %127 = zext i32 %126 to i64, !dbg !370
  %128 = getelementptr i8, i8* %16, i64 75, !dbg !371
  %129 = bitcast i8* %128 to i64*, !dbg !371
  store i64 %127, i64* %129, align 1, !dbg !372, !tbaa !326
  br label %130

130:                                              ; preds = %83, %100, %92, %40
  %131 = phi i32 [ 2, %40 ], [ 0, %92 ], [ 3, %100 ], [ %84, %83 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !373
  br label %135

132:                                              ; preds = %95
  %133 = getelementptr inbounds [48 x i8], [48 x i8]* %8, i64 0, i64 0, !dbg !374
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %133) #7, !dbg !374
  call void @llvm.dbg.declare(metadata [48 x i8]* %8, metadata !203, metadata !DIExpression()), !dbg !374
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(48) %133, i8* noundef nonnull align 1 dereferenceable(48) getelementptr inbounds ([48 x i8], [48 x i8]* @__const.xdp_parsing.____fmt.2, i64 0, i64 0), i64 48, i1 false), !dbg !374
  %134 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %133, i32 noundef 48) #7, !dbg !374
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %133) #7, !dbg !375
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !373
  br label %135, !dbg !376

135:                                              ; preds = %36, %130, %1, %33, %29, %26, %22, %18, %132
  %136 = phi i32 [ 2, %132 ], [ 1, %18 ], [ 2, %22 ], [ 1, %26 ], [ 2, %29 ], [ 1, %33 ], [ 1, %1 ], [ %131, %130 ], [ 1, %36 ], !dbg !209
  ret i32 %136, !dbg !377
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: nounwind
define internal fastcc i32 @make_challenge_header(%struct.auth_hdr* nocapture noundef %0) unnamed_addr #0 !dbg !378 {
  %2 = alloca i32, align 4
  %3 = alloca [21 x i8], align 1
  %4 = alloca [48 x i8], align 8, !dbg !424
  %5 = alloca [46 x i8], align 1
  %6 = alloca i32, align 4
  %7 = alloca [21 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %0, metadata !382, metadata !DIExpression()), !dbg !453
  %8 = getelementptr inbounds [46 x i8], [46 x i8]* %5, i64 0, i64 0, !dbg !454
  call void @llvm.lifetime.start.p0i8(i64 46, i8* nonnull %8) #7, !dbg !454
  call void @llvm.dbg.declare(metadata [46 x i8]* %5, metadata !383, metadata !DIExpression()), !dbg !454
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(46) %8, i8* noundef nonnull align 1 dereferenceable(46) getelementptr inbounds ([46 x i8], [46 x i8]* @__const.make_challenge_header.____fmt, i64 0, i64 0), i64 46, i1 false), !dbg !454
  %9 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %8, i32 noundef 46) #7, !dbg !454
  call void @llvm.lifetime.end.p0i8(i64 46, i8* nonnull %8) #7, !dbg !455
  %10 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 6, !dbg !456
  %11 = load i32, i32* %10, align 1, !dbg !456, !tbaa !261
  %12 = call i32 @llvm.bswap.i32(i32 %11), !dbg !456
  call void @llvm.dbg.value(metadata i32 %12, metadata !388, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !453
  %13 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !457
  call void @llvm.dbg.value(metadata i32 %13, metadata !400, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !453
  %14 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !458
  call void @llvm.dbg.value(metadata i32 %14, metadata !401, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !453
  %15 = urem i32 %13, 500, !dbg !459
  call void @llvm.dbg.value(metadata i32 %15, metadata !402, metadata !DIExpression()), !dbg !453
  %16 = bitcast i32* %6 to i8*, !dbg !460
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %16) #7, !dbg !460
  %17 = mul i32 %12, 500, !dbg !461
  %18 = add i32 %17, -500, !dbg !461
  %19 = add i32 %18, %15, !dbg !462
  call void @llvm.dbg.value(metadata i32 %19, metadata !403, metadata !DIExpression()), !dbg !453
  store i32 %19, i32* %6, align 4, !dbg !463, !tbaa !264
  call void @llvm.dbg.value(metadata i32* %6, metadata !403, metadata !DIExpression(DW_OP_deref)), !dbg !453
  %20 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @cr_db_map to i8*), i8* noundef nonnull %16) #7, !dbg !464
  call void @llvm.dbg.value(metadata i8* %20, metadata !389, metadata !DIExpression()), !dbg !453
  %21 = icmp eq i8* %20, null, !dbg !465
  br i1 %21, label %22, label %25, !dbg !466

22:                                               ; preds = %1
  %23 = getelementptr inbounds [21 x i8], [21 x i8]* %7, i64 0, i64 0, !dbg !467
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %23) #7, !dbg !467
  call void @llvm.dbg.declare(metadata [21 x i8]* %7, metadata !404, metadata !DIExpression()), !dbg !467
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %23, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false), !dbg !467
  %24 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %23, i32 noundef 21) #7, !dbg !467
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %23) #7, !dbg !468
  br label %112, !dbg !469

25:                                               ; preds = %1
  %26 = zext i32 %14 to i64, !dbg !458
  call void @llvm.dbg.value(metadata i64 %26, metadata !401, metadata !DIExpression()), !dbg !453
  %27 = zext i32 %13 to i64, !dbg !457
  call void @llvm.dbg.value(metadata i64 %27, metadata !400, metadata !DIExpression()), !dbg !453
  call void @llvm.dbg.value(metadata i8* %20, metadata !389, metadata !DIExpression()), !dbg !453
  %28 = bitcast i8* %20 to i32*, !dbg !470
  %29 = load i32, i32* %28, align 8, !dbg !470, !tbaa !471
  call void @llvm.dbg.value(metadata i32 %29, metadata !411, metadata !DIExpression()), !dbg !453
  %30 = getelementptr inbounds i8, i8* %20, i64 24, !dbg !473
  %31 = bitcast i8* %30 to i32*, !dbg !473
  %32 = load i32, i32* %31, align 8, !dbg !473, !tbaa !474
  call void @llvm.dbg.value(metadata i32 %32, metadata !412, metadata !DIExpression()), !dbg !453
  %33 = getelementptr inbounds i8, i8* %20, i64 8, !dbg !475
  %34 = bitcast i8* %33 to i64*, !dbg !475
  %35 = load i64, i64* %34, align 8, !dbg !475, !tbaa !476
  call void @llvm.dbg.value(metadata i64 %35, metadata !413, metadata !DIExpression()), !dbg !453
  %36 = getelementptr inbounds i8, i8* %20, i64 16, !dbg !477
  %37 = bitcast i8* %36 to i64*, !dbg !477
  %38 = load i64, i64* %37, align 8, !dbg !477, !tbaa !478
  call void @llvm.dbg.value(metadata i64 %38, metadata !414, metadata !DIExpression()), !dbg !453
  %39 = getelementptr inbounds i8, i8* %20, i64 32, !dbg !479
  %40 = bitcast i8* %39 to i64*, !dbg !479
  %41 = load i64, i64* %40, align 8, !dbg !479, !tbaa !480
  call void @llvm.dbg.value(metadata i64 %41, metadata !415, metadata !DIExpression()), !dbg !453
  %42 = getelementptr inbounds i8, i8* %20, i64 40, !dbg !481
  %43 = bitcast i8* %42 to i64*, !dbg !481
  %44 = load i64, i64* %43, align 8, !dbg !481, !tbaa !482
  call void @llvm.dbg.value(metadata i64 %44, metadata !416, metadata !DIExpression()), !dbg !453
  %45 = or i64 %41, %35, !dbg !483
  call void @llvm.dbg.value(metadata i64 %45, metadata !417, metadata !DIExpression()), !dbg !453
  %46 = or i64 %44, %38, !dbg !484
  call void @llvm.dbg.value(metadata i64 %46, metadata !418, metadata !DIExpression()), !dbg !453
  call void @llvm.dbg.value(metadata !DIArgList(i64 %45, i32 %13), metadata !419, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !453
  call void @llvm.dbg.value(metadata !DIArgList(i64 %46, i32 %14), metadata !420, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !453
  %47 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 0, !dbg !485
  store i8 1, i8* %47, align 1, !dbg !486, !tbaa !256
  %48 = call i32 @llvm.bswap.i32(i32 %29), !dbg !487
  %49 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 1, !dbg !488
  store i32 %48, i32* %49, align 1, !dbg !489, !tbaa !490
  %50 = call i32 @llvm.bswap.i32(i32 %32), !dbg !491
  %51 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 2, !dbg !492
  store i32 %50, i32* %51, align 1, !dbg !493, !tbaa !494
  %52 = trunc i64 %45 to i32, !dbg !495
  %53 = xor i32 %13, %52, !dbg !495
  %54 = call i32 @llvm.bswap.i32(i32 %53), !dbg !495
  %55 = zext i32 %54 to i64, !dbg !495
  %56 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 3, !dbg !496
  store i64 %55, i64* %56, align 1, !dbg !497, !tbaa !498
  %57 = trunc i64 %46 to i32, !dbg !499
  %58 = xor i32 %14, %57, !dbg !499
  %59 = call i32 @llvm.bswap.i32(i32 %58), !dbg !499
  %60 = zext i32 %59 to i64, !dbg !499
  %61 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 4, !dbg !500
  store i64 %60, i64* %61, align 1, !dbg !501, !tbaa !502
  store i32 %11, i32* %10, align 1, !dbg !503, !tbaa !261
  call void @llvm.dbg.value(metadata i64 %35, metadata !421, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !453
  call void @llvm.dbg.value(metadata i64 %38, metadata !421, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 64)), !dbg !453
  call void @llvm.dbg.value(metadata i64 %41, metadata !421, metadata !DIExpression(DW_OP_LLVM_fragment, 128, 64)), !dbg !453
  call void @llvm.dbg.value(metadata i64 %44, metadata !421, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 64)), !dbg !453
  call void @llvm.dbg.value(metadata i32 %13, metadata !421, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 256, 64)), !dbg !453
  call void @llvm.dbg.value(metadata i32 %14, metadata !421, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 320, 64)), !dbg !453
  %62 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %62)
  call void @llvm.dbg.value(metadata i64* undef, metadata !430, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.dbg.value(metadata i32 6, metadata !431, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.dbg.value(metadata i64 48, metadata !432, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.dbg.declare(metadata [48 x i8]* %4, metadata !434, metadata !DIExpression()) #7, !dbg !505
  call void @llvm.dbg.value(metadata i32 0, metadata !438, metadata !DIExpression()) #7, !dbg !506
  %63 = bitcast [48 x i8]* %4 to i64*, !dbg !507
  store i64 %35, i64* %63, align 8, !dbg !507
  %64 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 8, !dbg !507
  %65 = bitcast i8* %64 to i64*, !dbg !507
  store i64 %38, i64* %65, align 8, !dbg !507
  %66 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 16, !dbg !507
  %67 = bitcast i8* %66 to i64*, !dbg !507
  store i64 %41, i64* %67, align 8, !dbg !507
  %68 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 24, !dbg !507
  %69 = bitcast i8* %68 to i64*, !dbg !507
  store i64 %44, i64* %69, align 8, !dbg !507
  %70 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 32, !dbg !507
  %71 = bitcast i8* %70 to i64*, !dbg !507
  store i64 %27, i64* %71, align 8, !dbg !507
  %72 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 40, !dbg !507
  %73 = bitcast i8* %72 to i64*, !dbg !507
  store i64 %26, i64* %73, align 8, !dbg !507
  call void @llvm.dbg.value(metadata i32 undef, metadata !438, metadata !DIExpression()) #7, !dbg !506
  call void @llvm.dbg.value(metadata i32 undef, metadata !438, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)) #7, !dbg !506
  %74 = bitcast i32* %2 to i8*
  call void @llvm.dbg.value(metadata i32 0, metadata !441, metadata !DIExpression()) #7, !dbg !510
  call void @llvm.dbg.value(metadata i32 -1, metadata !440, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.dbg.value(metadata i64 0, metadata !441, metadata !DIExpression()) #7, !dbg !510
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %74) #7, !dbg !511
  %75 = trunc i64 %35 to i32, !dbg !512
  %76 = and i32 %75, 255, !dbg !513
  %77 = xor i32 %76, 255, !dbg !513
  call void @llvm.dbg.value(metadata i32 %77, metadata !443, metadata !DIExpression()) #7, !dbg !514
  store i32 %77, i32* %2, align 4, !dbg !515, !tbaa !264
  call void @llvm.dbg.value(metadata i32* %2, metadata !443, metadata !DIExpression(DW_OP_deref)) #7, !dbg !514
  %78 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %74) #7, !dbg !516
  call void @llvm.dbg.value(metadata i8* %78, metadata !446, metadata !DIExpression()) #7, !dbg !514
  %79 = icmp eq i8* %78, null, !dbg !517
  br i1 %79, label %90, label %95, !dbg !518

80:                                               ; preds = %95
  call void @llvm.dbg.value(metadata i64 %103, metadata !441, metadata !DIExpression()) #7, !dbg !510
  call void @llvm.dbg.value(metadata i32 %102, metadata !440, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %74) #7, !dbg !511
  %81 = getelementptr inbounds [48 x i8], [48 x i8]* %4, i64 0, i64 %103, !dbg !512
  %82 = load i8, i8* %81, align 1, !dbg !512, !tbaa !288
  %83 = zext i8 %82 to i32, !dbg !512
  %84 = and i32 %102, 255, !dbg !513
  %85 = xor i32 %84, %83, !dbg !513
  call void @llvm.dbg.value(metadata i32 %85, metadata !443, metadata !DIExpression()) #7, !dbg !514
  store i32 %85, i32* %2, align 4, !dbg !515, !tbaa !264
  call void @llvm.dbg.value(metadata i32* %2, metadata !443, metadata !DIExpression(DW_OP_deref)) #7, !dbg !514
  %86 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %74) #7, !dbg !516
  call void @llvm.dbg.value(metadata i8* %86, metadata !446, metadata !DIExpression()) #7, !dbg !514
  %87 = icmp eq i8* %86, null, !dbg !517
  br i1 %87, label %88, label %95, !dbg !518, !llvm.loop !519

88:                                               ; preds = %80
  %89 = icmp ult i64 %98, 47, !dbg !523
  br label %90, !dbg !524

90:                                               ; preds = %88, %25
  %91 = phi i1 [ true, %25 ], [ %89, %88 ]
  %92 = phi i32 [ -1, %25 ], [ %102, %88 ]
  %93 = getelementptr inbounds [21 x i8], [21 x i8]* %3, i64 0, i64 0, !dbg !524
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %93) #7, !dbg !524
  call void @llvm.dbg.declare(metadata [21 x i8]* %3, metadata !448, metadata !DIExpression()) #7, !dbg !524
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %93, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false) #7, !dbg !524
  %94 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %93, i32 noundef 21) #7, !dbg !524
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %93) #7, !dbg !525
  call void @llvm.dbg.value(metadata i32 undef, metadata !440, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %74) #7, !dbg !526
  br label %107

95:                                               ; preds = %25, %80
  %96 = phi i8* [ %86, %80 ], [ %78, %25 ]
  %97 = phi i32 [ %102, %80 ], [ -1, %25 ]
  %98 = phi i64 [ %103, %80 ], [ 0, %25 ]
  call void @llvm.dbg.value(metadata i32 %97, metadata !440, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.dbg.value(metadata i64 %98, metadata !441, metadata !DIExpression()) #7, !dbg !510
  %99 = bitcast i8* %96 to i32*, !dbg !516
  call void @llvm.dbg.value(metadata i32* %99, metadata !446, metadata !DIExpression()) #7, !dbg !514
  %100 = lshr i32 %97, 8, !dbg !527
  %101 = load i32, i32* %99, align 4, !dbg !528, !tbaa !264
  %102 = xor i32 %101, %100, !dbg !529
  call void @llvm.dbg.value(metadata i32 %102, metadata !440, metadata !DIExpression()) #7, !dbg !504
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %74) #7, !dbg !526
  %103 = add nuw nsw i64 %98, 1, !dbg !530
  call void @llvm.dbg.value(metadata i64 %103, metadata !441, metadata !DIExpression()) #7, !dbg !510
  %104 = icmp eq i64 %103, 48, !dbg !523
  br i1 %104, label %105, label %80, !dbg !520, !llvm.loop !519

105:                                              ; preds = %95
  %106 = icmp ult i64 %98, 47, !dbg !523
  br label %107

107:                                              ; preds = %105, %90
  %108 = phi i32 [ %92, %90 ], [ %102, %105 ]
  %109 = phi i1 [ %91, %90 ], [ %106, %105 ]
  call void @llvm.dbg.value(metadata i32 %108, metadata !440, metadata !DIExpression()) #7, !dbg !504
  %110 = xor i32 %108, -1
  %111 = select i1 %109, i32 0, i32 %110
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %62), !dbg !531
  call void @llvm.dbg.value(metadata i32 %111, metadata !423, metadata !DIExpression()), !dbg !453
  br label %112

112:                                              ; preds = %107, %22
  %113 = phi i32 [ %111, %107 ], [ 0, %22 ], !dbg !453
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %16) #7, !dbg !532
  ret i32 %113, !dbg !532
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree norecurse nosync nounwind readonly
define internal fastcc zeroext i16 @ip_checksum(i8* nocapture noundef readonly %0) unnamed_addr #4 !dbg !533 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !537, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 20, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 0, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 0, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 20, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 18, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 18, metadata !538, metadata !DIExpression()), !dbg !541
  %2 = bitcast i8* %0 to <8 x i16>*, !dbg !542
  %3 = load <8 x i16>, <8 x i16>* %2, align 2, !dbg !542, !tbaa !544
  %4 = zext <8 x i16> %3 to <8 x i32>, !dbg !542
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 16, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 16, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 14, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 14, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 12, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 12, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 10, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 10, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 8, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 8, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 6, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %0, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 6, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  %5 = getelementptr inbounds i8, i8* %0, i64 16, !dbg !545
  call void @llvm.dbg.value(metadata i8* %5, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 4, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %5, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 4, metadata !538, metadata !DIExpression()), !dbg !541
  %6 = bitcast i8* %5 to i16*, !dbg !542
  %7 = load i16, i16* %6, align 2, !dbg !542, !tbaa !544
  %8 = zext i16 %7 to i32, !dbg !542
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  %9 = getelementptr inbounds i8, i8* %0, i64 18, !dbg !545
  call void @llvm.dbg.value(metadata i8* %9, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 2, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 undef, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %9, metadata !539, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 2, metadata !538, metadata !DIExpression()), !dbg !541
  %10 = bitcast i8* %9 to i16*, !dbg !542
  %11 = load i16, i16* %10, align 2, !dbg !542, !tbaa !544
  %12 = zext i16 %11 to i32, !dbg !542
  %13 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %4), !dbg !546
  %14 = add nuw nsw i32 %13, %8, !dbg !542
  %15 = add nuw nsw i32 %14, %12, !dbg !542
  call void @llvm.dbg.value(metadata i32 %15, metadata !540, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i8* %9, metadata !539, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !541
  call void @llvm.dbg.value(metadata i32 0, metadata !538, metadata !DIExpression()), !dbg !541
  call void @llvm.dbg.value(metadata i32 %15, metadata !540, metadata !DIExpression()), !dbg !541
  %16 = icmp ult i32 %15, 65536, !dbg !547
  br i1 %16, label %23, label %17, !dbg !547

17:                                               ; preds = %1, %17
  %18 = phi i32 [ %21, %17 ], [ %15, %1 ]
  call void @llvm.dbg.value(metadata i32 %18, metadata !540, metadata !DIExpression()), !dbg !541
  %19 = lshr i32 %18, 16, !dbg !548
  %20 = and i32 %18, 65535, !dbg !549
  %21 = add nuw nsw i32 %20, %19, !dbg !551
  call void @llvm.dbg.value(metadata i32 %21, metadata !540, metadata !DIExpression()), !dbg !541
  %22 = icmp ult i32 %21, 65536, !dbg !547
  br i1 %22, label %23, label %17, !dbg !547, !llvm.loop !552

23:                                               ; preds = %17, %1
  %24 = phi i32 [ %15, %1 ], [ %21, %17 ], !dbg !541
  %25 = trunc i32 %24 to i16, !dbg !554
  %26 = xor i16 %25, -1, !dbg !554
  ret i16 %26, !dbg !555
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
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "889e799a07462cdbd7eb298637581bbe")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "db1ce4e5e29770657167bc8f57af9388")
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
!30 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "9e37b5f46a8fb7f5ed35ab69309bf15d")
!31 = !{!32, !33, !34, !35, !36}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !29, file: !30, line: 34, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !29, file: !30, line: 35, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !29, file: !30, line: 36, baseType: !7, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !29, file: !30, line: 37, baseType: !7, size: 32, offset: 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !29, file: !30, line: 38, baseType: !7, size: 32, offset: 128)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "crc32_table", scope: !2, file: !3, line: 65, type: !29, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 360, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 32, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 4)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !46, line: 89, type: !47, isLocal: true, isDefinition: true)
!46 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "2601bcf9d7985cb46bfbd904b60f5aaf")
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
!82 = distinct !DISubprogram(name: "xdp_parsing", scope: !3, file: !3, line: 206, type: !83, scopeLine: 206, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
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
!93 = !{!94, !95, !108, !138, !147, !148, !149, !173, !174, !175, !178, !179, !184, !185, !186, !189, !190, !192, !199, !202, !203}
!94 = !DILocalVariable(name: "ctx", arg: 1, scope: !82, file: !3, line: 206, type: !85)
!95 = !DILocalVariable(name: "eth", scope: !82, file: !3, line: 209, type: !96)
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
!108 = !DILocalVariable(name: "iph", scope: !82, file: !3, line: 210, type: !109)
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
!138 = !DILocalVariable(name: "udph", scope: !82, file: !3, line: 211, type: !139)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !140, size: 64)
!140 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !141, line: 23, size: 64, elements: !142)
!141 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "", checksumkind: CSK_MD5, checksum: "53c0d42e1bf6d93b39151764be2d20fb")
!142 = !{!143, !144, !145, !146}
!143 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !140, file: !141, line: 24, baseType: !106, size: 16)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !140, file: !141, line: 25, baseType: !106, size: 16, offset: 16)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !140, file: !141, line: 26, baseType: !106, size: 16, offset: 32)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !140, file: !141, line: 27, baseType: !123, size: 16, offset: 48)
!147 = !DILocalVariable(name: "data_end", scope: !82, file: !3, line: 213, type: !15)
!148 = !DILocalVariable(name: "data", scope: !82, file: !3, line: 214, type: !15)
!149 = !DILocalVariable(name: "payload", scope: !150, file: !3, line: 243, type: !154)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 236, column: 9)
!151 = distinct !DILexicalBlock(scope: !152, file: !3, line: 231, column: 13)
!152 = distinct !DILexicalBlock(scope: !153, file: !3, line: 217, column: 3)
!153 = distinct !DILexicalBlock(scope: !82, file: !3, line: 216, column: 6)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "auth_hdr", file: !3, line: 36, size: 328, elements: !156)
!156 = !{!157, !162, !165, !166, !169, !170, !171, !172}
!157 = !DIDerivedType(tag: DW_TAG_member, name: "msgType", scope: !155, file: !3, line: 37, baseType: !158, size: 8)
!158 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !159, line: 24, baseType: !160)
!159 = !DIFile(filename: "/usr/include/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "2bf2ae53c58c01b1a1b9383b5195125c")
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !161, line: 38, baseType: !25)
!161 = !DIFile(filename: "/usr/include/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "d108b5f93a74c50510d7d9bc0ab36df9")
!162 = !DIDerivedType(tag: DW_TAG_member, name: "challenge1", scope: !155, file: !3, line: 38, baseType: !163, size: 32, offset: 8)
!163 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !159, line: 26, baseType: !164)
!164 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !161, line: 42, baseType: !7)
!165 = !DIDerivedType(tag: DW_TAG_member, name: "challenge2", scope: !155, file: !3, line: 39, baseType: !163, size: 32, offset: 40)
!166 = !DIDerivedType(tag: DW_TAG_member, name: "randomnumber1", scope: !155, file: !3, line: 40, baseType: !167, size: 64, offset: 72)
!167 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !159, line: 27, baseType: !168)
!168 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !161, line: 48, baseType: !51)
!169 = !DIDerivedType(tag: DW_TAG_member, name: "randomnumber2", scope: !155, file: !3, line: 41, baseType: !167, size: 64, offset: 136)
!170 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !155, file: !3, line: 42, baseType: !163, size: 32, offset: 200)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "identifier", scope: !155, file: !3, line: 43, baseType: !163, size: 32, offset: 232)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "prTime", scope: !155, file: !3, line: 44, baseType: !167, size: 64, offset: 264)
!173 = !DILocalVariable(name: "msg_type", scope: !150, file: !3, line: 255, type: !158)
!174 = !DILocalVariable(name: "id", scope: !150, file: !3, line: 256, type: !163)
!175 = !DILocalVariable(name: "t1", scope: !176, file: !3, line: 262, type: !167)
!176 = distinct !DILexicalBlock(scope: !177, file: !3, line: 261, column: 12)
!177 = distinct !DILexicalBlock(scope: !150, file: !3, line: 260, column: 15)
!178 = !DILocalVariable(name: "h", scope: !176, file: !3, line: 263, type: !163)
!179 = !DILocalVariable(name: "____fmt", scope: !180, file: !3, line: 264, type: !181)
!180 = distinct !DILexicalBlock(scope: !176, file: !3, line: 264, column: 13)
!181 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 136, elements: !182)
!182 = !{!183}
!183 = !DISubrange(count: 17)
!184 = !DILocalVariable(name: "src_port", scope: !176, file: !3, line: 279, type: !106)
!185 = !DILocalVariable(name: "t2", scope: !176, file: !3, line: 292, type: !167)
!186 = !DILocalVariable(name: "t1", scope: !187, file: !3, line: 301, type: !167)
!187 = distinct !DILexicalBlock(scope: !188, file: !3, line: 300, column: 12)
!188 = distinct !DILexicalBlock(scope: !177, file: !3, line: 299, column: 20)
!189 = !DILocalVariable(name: "h1", scope: !187, file: !3, line: 302, type: !163)
!190 = !DILocalVariable(name: "h2", scope: !187, file: !3, line: 303, type: !191)
!191 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!192 = !DILocalVariable(name: "____fmt", scope: !193, file: !3, line: 307, type: !196)
!193 = distinct !DILexicalBlock(scope: !194, file: !3, line: 307, column: 14)
!194 = distinct !DILexicalBlock(scope: !195, file: !3, line: 306, column: 13)
!195 = distinct !DILexicalBlock(scope: !187, file: !3, line: 305, column: 16)
!196 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 240, elements: !197)
!197 = !{!198}
!198 = !DISubrange(count: 30)
!199 = !DILocalVariable(name: "src_port", scope: !200, file: !3, line: 324, type: !106)
!200 = distinct !DILexicalBlock(scope: !201, file: !3, line: 313, column: 13)
!201 = distinct !DILexicalBlock(scope: !187, file: !3, line: 312, column: 16)
!202 = !DILocalVariable(name: "t2", scope: !200, file: !3, line: 336, type: !167)
!203 = !DILocalVariable(name: "____fmt", scope: !204, file: !3, line: 342, type: !206)
!204 = distinct !DILexicalBlock(scope: !205, file: !3, line: 342, column: 4)
!205 = distinct !DILexicalBlock(scope: !201, file: !3, line: 341, column: 3)
!206 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 384, elements: !207)
!207 = !{!208}
!208 = !DISubrange(count: 48)
!209 = !DILocation(line: 0, scope: !82)
!210 = !DILocation(line: 213, column: 44, scope: !82)
!211 = !{!212, !213, i64 4}
!212 = !{!"xdp_md", !213, i64 0, !213, i64 4, !213, i64 8, !213, i64 12, !213, i64 16}
!213 = !{!"int", !214, i64 0}
!214 = !{!"omnipotent char", !215, i64 0}
!215 = !{!"Simple C/C++ TBAA"}
!216 = !DILocation(line: 213, column: 30, scope: !82)
!217 = !DILocation(line: 213, column: 21, scope: !82)
!218 = !DILocation(line: 214, column: 40, scope: !82)
!219 = !{!212, !213, i64 0}
!220 = !DILocation(line: 214, column: 26, scope: !82)
!221 = !DILocation(line: 214, column: 17, scope: !82)
!222 = !DILocation(line: 216, column: 11, scope: !153)
!223 = !DILocation(line: 216, column: 6, scope: !82)
!224 = !DILocation(line: 218, column: 15, scope: !152)
!225 = !DILocation(line: 219, column: 18, scope: !226)
!226 = distinct !DILexicalBlock(scope: !152, file: !3, line: 219, column: 13)
!227 = !DILocation(line: 219, column: 33, scope: !226)
!228 = !DILocation(line: 219, column: 13, scope: !152)
!229 = !DILocation(line: 222, column: 13, scope: !230)
!230 = distinct !DILexicalBlock(scope: !152, file: !3, line: 222, column: 13)
!231 = !{!232, !233, i64 12}
!232 = !{!"ethhdr", !214, i64 0, !214, i64 6, !233, i64 12}
!233 = !{!"short", !214, i64 0}
!234 = !DILocation(line: 222, column: 37, scope: !230)
!235 = !DILocation(line: 222, column: 13, scope: !152)
!236 = !DILocation(line: 228, column: 33, scope: !237)
!237 = distinct !DILexicalBlock(scope: !152, file: !3, line: 228, column: 13)
!238 = !DILocation(line: 228, column: 48, scope: !237)
!239 = !DILocation(line: 228, column: 13, scope: !152)
!240 = !DILocation(line: 231, column: 18, scope: !151)
!241 = !{!242, !214, i64 9}
!242 = !{!"iphdr", !214, i64 0, !214, i64 0, !214, i64 1, !233, i64 2, !233, i64 4, !233, i64 6, !214, i64 8, !214, i64 9, !233, i64 10, !214, i64 12}
!243 = !DILocation(line: 231, column: 27, scope: !151)
!244 = !DILocation(line: 231, column: 13, scope: !152)
!245 = !DILocation(line: 238, column: 51, scope: !246)
!246 = distinct !DILexicalBlock(scope: !150, file: !3, line: 238, column: 16)
!247 = !DILocation(line: 238, column: 67, scope: !246)
!248 = !DILocation(line: 238, column: 16, scope: !150)
!249 = !DILocation(line: 243, column: 39, scope: !150)
!250 = !DILocation(line: 0, scope: !150)
!251 = !DILocation(line: 245, column: 59, scope: !252)
!252 = distinct !DILexicalBlock(scope: !150, file: !3, line: 245, column: 8)
!253 = !DILocation(line: 245, column: 77, scope: !252)
!254 = !DILocation(line: 245, column: 8, scope: !150)
!255 = !DILocation(line: 255, column: 40, scope: !150)
!256 = !{!257, !214, i64 0}
!257 = !{!"auth_hdr", !214, i64 0, !213, i64 1, !213, i64 5, !258, i64 9, !258, i64 17, !213, i64 25, !213, i64 29, !258, i64 33}
!258 = !{!"long long", !214, i64 0}
!259 = !DILocation(line: 256, column: 12, scope: !150)
!260 = !DILocation(line: 256, column: 26, scope: !150)
!261 = !{!257, !213, i64 29}
!262 = !DILocation(line: 256, column: 56, scope: !150)
!263 = !DILocation(line: 256, column: 21, scope: !150)
!264 = !{!213, !213, i64 0}
!265 = !DILocation(line: 260, column: 15, scope: !150)
!266 = !DILocation(line: 262, column: 17, scope: !176)
!267 = !DILocation(line: 0, scope: !176)
!268 = !DILocation(line: 263, column: 13, scope: !176)
!269 = !DILocation(line: 263, column: 26, scope: !176)
!270 = !DILocation(line: 263, column: 22, scope: !176)
!271 = !DILocation(line: 264, column: 13, scope: !180)
!272 = !DILocation(line: 264, column: 13, scope: !176)
!273 = !DILocation(line: 265, column: 8, scope: !274)
!274 = distinct !DILexicalBlock(scope: !176, file: !3, line: 265, column: 6)
!275 = !DILocation(line: 265, column: 6, scope: !176)
!276 = !DILocation(line: 269, column: 14, scope: !277)
!277 = distinct !DILexicalBlock(scope: !274, file: !3, line: 268, column: 13)
!278 = !DILocalVariable(name: "iphdr", arg: 1, scope: !279, file: !280, line: 136, type: !109)
!279 = distinct !DISubprogram(name: "swap_src_dst_ipv4", scope: !280, file: !280, line: 136, type: !281, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !283)
!280 = !DIFile(filename: "./../common/rewrite_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "75040841dc53cbf2ffc17c0802a4440a")
!281 = !DISubroutineType(types: !282)
!282 = !{null, !109}
!283 = !{!278, !284}
!284 = !DILocalVariable(name: "tmp", scope: !279, file: !280, line: 138, type: !131)
!285 = !DILocation(line: 0, scope: !279, inlinedAt: !286)
!286 = distinct !DILocation(line: 275, column: 7, scope: !176)
!287 = !DILocation(line: 138, column: 22, scope: !279, inlinedAt: !286)
!288 = !{!214, !214, i64 0}
!289 = !DILocation(line: 140, column: 24, scope: !279, inlinedAt: !286)
!290 = !DILocation(line: 140, column: 15, scope: !279, inlinedAt: !286)
!291 = !DILocation(line: 141, column: 15, scope: !279, inlinedAt: !286)
!292 = !DILocalVariable(name: "eth", arg: 1, scope: !293, file: !280, line: 113, type: !96)
!293 = distinct !DISubprogram(name: "swap_src_dst_mac", scope: !280, file: !280, line: 113, type: !294, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !296)
!294 = !DISubroutineType(types: !295)
!295 = !{null, !96}
!296 = !{!292, !297}
!297 = !DILocalVariable(name: "h_tmp", scope: !293, file: !280, line: 115, type: !298)
!298 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, size: 48, elements: !102)
!299 = !DILocation(line: 0, scope: !293, inlinedAt: !300)
!300 = distinct !DILocation(line: 277, column: 7, scope: !176)
!301 = !DILocation(line: 115, column: 2, scope: !293, inlinedAt: !300)
!302 = !DILocation(line: 115, column: 7, scope: !293, inlinedAt: !300)
!303 = !DILocation(line: 117, column: 2, scope: !293, inlinedAt: !300)
!304 = !DILocation(line: 118, column: 2, scope: !293, inlinedAt: !300)
!305 = !DILocation(line: 119, column: 2, scope: !293, inlinedAt: !300)
!306 = !DILocation(line: 120, column: 1, scope: !293, inlinedAt: !300)
!307 = !DILocation(line: 279, column: 31, scope: !176)
!308 = !{!309, !233, i64 0}
!309 = !{!"udphdr", !233, i64 0, !233, i64 2, !233, i64 4, !233, i64 6}
!310 = !DILocation(line: 280, column: 28, scope: !176)
!311 = !{!309, !233, i64 2}
!312 = !DILocation(line: 280, column: 20, scope: !176)
!313 = !DILocation(line: 281, column: 18, scope: !176)
!314 = !DILocation(line: 286, column: 13, scope: !176)
!315 = !DILocation(line: 286, column: 19, scope: !176)
!316 = !{!309, !233, i64 6}
!317 = !DILocation(line: 289, column: 12, scope: !176)
!318 = !DILocation(line: 289, column: 18, scope: !176)
!319 = !{!242, !233, i64 10}
!320 = !DILocation(line: 290, column: 20, scope: !176)
!321 = !DILocation(line: 290, column: 18, scope: !176)
!322 = !DILocation(line: 292, column: 17, scope: !176)
!323 = !DILocation(line: 294, column: 20, scope: !176)
!324 = !DILocation(line: 294, column: 12, scope: !176)
!325 = !DILocation(line: 294, column: 18, scope: !176)
!326 = !{!257, !258, i64 33}
!327 = !DILocation(line: 297, column: 12, scope: !177)
!328 = !DILocation(line: 301, column: 17, scope: !187)
!329 = !DILocation(line: 0, scope: !187)
!330 = !DILocation(line: 302, column: 27, scope: !187)
!331 = !{!257, !213, i64 25}
!332 = !DILocation(line: 303, column: 28, scope: !187)
!333 = !DILocation(line: 305, column: 17, scope: !195)
!334 = !DILocation(line: 305, column: 16, scope: !187)
!335 = !DILocation(line: 307, column: 14, scope: !193)
!336 = !DILocation(line: 307, column: 14, scope: !194)
!337 = !DILocation(line: 308, column: 14, scope: !194)
!338 = !DILocation(line: 312, column: 22, scope: !201)
!339 = !DILocation(line: 312, column: 19, scope: !201)
!340 = !DILocation(line: 312, column: 16, scope: !187)
!341 = !DILocation(line: 314, column: 31, scope: !200)
!342 = !DILocation(line: 315, column: 36, scope: !200)
!343 = !DILocation(line: 315, column: 34, scope: !200)
!344 = !DILocation(line: 0, scope: !279, inlinedAt: !345)
!345 = distinct !DILocation(line: 320, column: 8, scope: !200)
!346 = !DILocation(line: 138, column: 22, scope: !279, inlinedAt: !345)
!347 = !DILocation(line: 140, column: 24, scope: !279, inlinedAt: !345)
!348 = !DILocation(line: 140, column: 15, scope: !279, inlinedAt: !345)
!349 = !DILocation(line: 141, column: 15, scope: !279, inlinedAt: !345)
!350 = !DILocation(line: 0, scope: !293, inlinedAt: !351)
!351 = distinct !DILocation(line: 322, column: 8, scope: !200)
!352 = !DILocation(line: 115, column: 2, scope: !293, inlinedAt: !351)
!353 = !DILocation(line: 115, column: 7, scope: !293, inlinedAt: !351)
!354 = !DILocation(line: 117, column: 2, scope: !293, inlinedAt: !351)
!355 = !DILocation(line: 118, column: 2, scope: !293, inlinedAt: !351)
!356 = !DILocation(line: 119, column: 2, scope: !293, inlinedAt: !351)
!357 = !DILocation(line: 120, column: 1, scope: !293, inlinedAt: !351)
!358 = !DILocation(line: 324, column: 32, scope: !200)
!359 = !DILocation(line: 0, scope: !200)
!360 = !DILocation(line: 325, column: 29, scope: !200)
!361 = !DILocation(line: 325, column: 21, scope: !200)
!362 = !DILocation(line: 326, column: 19, scope: !200)
!363 = !DILocation(line: 330, column: 14, scope: !200)
!364 = !DILocation(line: 330, column: 20, scope: !200)
!365 = !DILocation(line: 333, column: 13, scope: !200)
!366 = !DILocation(line: 333, column: 19, scope: !200)
!367 = !DILocation(line: 334, column: 21, scope: !200)
!368 = !DILocation(line: 334, column: 19, scope: !200)
!369 = !DILocation(line: 336, column: 18, scope: !200)
!370 = !DILocation(line: 337, column: 21, scope: !200)
!371 = !DILocation(line: 337, column: 13, scope: !200)
!372 = !DILocation(line: 337, column: 19, scope: !200)
!373 = !DILocation(line: 348, column: 9, scope: !151)
!374 = !DILocation(line: 342, column: 4, scope: !204)
!375 = !DILocation(line: 342, column: 4, scope: !205)
!376 = !DILocation(line: 357, column: 3, scope: !82)
!377 = !DILocation(line: 359, column: 1, scope: !82)
!378 = distinct !DISubprogram(name: "make_challenge_header", scope: !3, file: !3, line: 109, type: !379, scopeLine: 110, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !381)
!379 = !DISubroutineType(types: !380)
!380 = !{!163, !154}
!381 = !{!382, !383, !388, !389, !400, !401, !402, !403, !404, !411, !412, !413, !414, !415, !416, !417, !418, !419, !420, !421, !423}
!382 = !DILocalVariable(name: "payload", arg: 1, scope: !378, file: !3, line: 109, type: !154)
!383 = !DILocalVariable(name: "____fmt", scope: !384, file: !3, line: 111, type: !385)
!384 = distinct !DILexicalBlock(scope: !378, file: !3, line: 111, column: 2)
!385 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 368, elements: !386)
!386 = !{!387}
!387 = !DISubrange(count: 46)
!388 = !DILocalVariable(name: "id", scope: !378, file: !3, line: 113, type: !163)
!389 = !DILocalVariable(name: "rec", scope: !378, file: !3, line: 115, type: !390)
!390 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !391, size: 64)
!391 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "crPair", file: !392, line: 13, size: 384, elements: !393)
!392 = !DIFile(filename: "./common_kern_user.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_128", checksumkind: CSK_MD5, checksum: "4dd0c7a3bafa12f70d19123188a13578")
!393 = !{!394, !395, !396, !397, !398, !399}
!394 = !DIDerivedType(tag: DW_TAG_member, name: "ch1", scope: !391, file: !392, line: 14, baseType: !163, size: 32)
!395 = !DIDerivedType(tag: DW_TAG_member, name: "resp11", scope: !391, file: !392, line: 15, baseType: !167, size: 64, offset: 64)
!396 = !DIDerivedType(tag: DW_TAG_member, name: "resp12", scope: !391, file: !392, line: 16, baseType: !167, size: 64, offset: 128)
!397 = !DIDerivedType(tag: DW_TAG_member, name: "ch2", scope: !391, file: !392, line: 17, baseType: !163, size: 32, offset: 192)
!398 = !DIDerivedType(tag: DW_TAG_member, name: "resp21", scope: !391, file: !392, line: 18, baseType: !167, size: 64, offset: 256)
!399 = !DIDerivedType(tag: DW_TAG_member, name: "resp22", scope: !391, file: !392, line: 19, baseType: !167, size: 64, offset: 320)
!400 = !DILocalVariable(name: "RN", scope: !378, file: !3, line: 117, type: !167)
!401 = !DILocalVariable(name: "RN1", scope: !378, file: !3, line: 118, type: !167)
!402 = !DILocalVariable(name: "i", scope: !378, file: !3, line: 120, type: !20)
!403 = !DILocalVariable(name: "key", scope: !378, file: !3, line: 122, type: !20)
!404 = !DILocalVariable(name: "____fmt", scope: !405, file: !3, line: 128, type: !408)
!405 = distinct !DILexicalBlock(scope: !406, file: !3, line: 128, column: 10)
!406 = distinct !DILexicalBlock(scope: !407, file: !3, line: 127, column: 9)
!407 = distinct !DILexicalBlock(scope: !378, file: !3, line: 126, column: 13)
!408 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 168, elements: !409)
!409 = !{!410}
!410 = !DISubrange(count: 21)
!411 = !DILocalVariable(name: "c1", scope: !378, file: !3, line: 132, type: !163)
!412 = !DILocalVariable(name: "c2", scope: !378, file: !3, line: 133, type: !163)
!413 = !DILocalVariable(name: "r11", scope: !378, file: !3, line: 134, type: !167)
!414 = !DILocalVariable(name: "r12", scope: !378, file: !3, line: 135, type: !167)
!415 = !DILocalVariable(name: "r21", scope: !378, file: !3, line: 136, type: !167)
!416 = !DILocalVariable(name: "r22", scope: !378, file: !3, line: 137, type: !167)
!417 = !DILocalVariable(name: "temp1", scope: !378, file: !3, line: 139, type: !167)
!418 = !DILocalVariable(name: "temp2", scope: !378, file: !3, line: 140, type: !167)
!419 = !DILocalVariable(name: "result1", scope: !378, file: !3, line: 141, type: !167)
!420 = !DILocalVariable(name: "result2", scope: !378, file: !3, line: 142, type: !167)
!421 = !DILocalVariable(name: "input_ints", scope: !378, file: !3, line: 155, type: !422)
!422 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 384, elements: !102)
!423 = !DILocalVariable(name: "hash", scope: !378, file: !3, line: 165, type: !163)
!424 = !DILocation(line: 83, column: 5, scope: !425, inlinedAt: !452)
!425 = distinct !DISubprogram(name: "computeHash", scope: !3, file: !3, line: 73, type: !426, scopeLine: 74, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !429)
!426 = !DISubroutineType(types: !427)
!427 = !{!20, !428, !20}
!428 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!429 = !{!430, !431, !432, !434, !438, !440, !441, !443, !446, !448}
!430 = !DILocalVariable(name: "input_ints", arg: 1, scope: !425, file: !3, line: 73, type: !428)
!431 = !DILocalVariable(name: "num_ints", arg: 2, scope: !425, file: !3, line: 73, type: !20)
!432 = !DILocalVariable(name: "__vla_expr0", scope: !425, type: !433, flags: DIFlagArtificial)
!433 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!434 = !DILocalVariable(name: "buffer", scope: !425, file: !3, line: 83, type: !435)
!435 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, elements: !436)
!436 = !{!437}
!437 = !DISubrange(count: !432)
!438 = !DILocalVariable(name: "i", scope: !439, file: !3, line: 84, type: !20)
!439 = distinct !DILexicalBlock(scope: !425, file: !3, line: 84, column: 5)
!440 = !DILocalVariable(name: "crc", scope: !425, file: !3, line: 89, type: !20)
!441 = !DILocalVariable(name: "i", scope: !442, file: !3, line: 90, type: !20)
!442 = distinct !DILexicalBlock(scope: !425, file: !3, line: 90, column: 5)
!443 = !DILocalVariable(name: "index", scope: !444, file: !3, line: 92, type: !20)
!444 = distinct !DILexicalBlock(scope: !445, file: !3, line: 90, column: 48)
!445 = distinct !DILexicalBlock(scope: !442, file: !3, line: 90, column: 5)
!446 = !DILocalVariable(name: "rec", scope: !444, file: !3, line: 93, type: !447)
!447 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !62, size: 64)
!448 = !DILocalVariable(name: "____fmt", scope: !449, file: !3, line: 97, type: !408)
!449 = distinct !DILexicalBlock(scope: !450, file: !3, line: 97, column: 17)
!450 = distinct !DILexicalBlock(scope: !451, file: !3, line: 96, column: 9)
!451 = distinct !DILexicalBlock(scope: !444, file: !3, line: 95, column: 13)
!452 = distinct !DILocation(line: 165, column: 18, scope: !378)
!453 = !DILocation(line: 0, scope: !378)
!454 = !DILocation(line: 111, column: 2, scope: !384)
!455 = !DILocation(line: 111, column: 2, scope: !378)
!456 = !DILocation(line: 113, column: 16, scope: !378)
!457 = !DILocation(line: 117, column: 23, scope: !378)
!458 = !DILocation(line: 118, column: 24, scope: !378)
!459 = !DILocation(line: 120, column: 21, scope: !378)
!460 = !DILocation(line: 122, column: 9, scope: !378)
!461 = !DILocation(line: 122, column: 24, scope: !378)
!462 = !DILocation(line: 122, column: 35, scope: !378)
!463 = !DILocation(line: 122, column: 15, scope: !378)
!464 = !DILocation(line: 124, column: 8, scope: !378)
!465 = !DILocation(line: 126, column: 14, scope: !407)
!466 = !DILocation(line: 126, column: 13, scope: !378)
!467 = !DILocation(line: 128, column: 10, scope: !405)
!468 = !DILocation(line: 128, column: 10, scope: !406)
!469 = !DILocation(line: 129, column: 3, scope: !406)
!470 = !DILocation(line: 132, column: 26, scope: !378)
!471 = !{!472, !213, i64 0}
!472 = !{!"crPair", !213, i64 0, !258, i64 8, !258, i64 16, !213, i64 24, !258, i64 32, !258, i64 40}
!473 = !DILocation(line: 133, column: 26, scope: !378)
!474 = !{!472, !213, i64 24}
!475 = !DILocation(line: 134, column: 20, scope: !378)
!476 = !{!472, !258, i64 8}
!477 = !DILocation(line: 135, column: 23, scope: !378)
!478 = !{!472, !258, i64 16}
!479 = !DILocation(line: 136, column: 20, scope: !378)
!480 = !{!472, !258, i64 32}
!481 = !DILocation(line: 137, column: 23, scope: !378)
!482 = !{!472, !258, i64 40}
!483 = !DILocation(line: 139, column: 26, scope: !378)
!484 = !DILocation(line: 140, column: 26, scope: !378)
!485 = !DILocation(line: 148, column: 11, scope: !378)
!486 = !DILocation(line: 148, column: 19, scope: !378)
!487 = !DILocation(line: 149, column: 24, scope: !378)
!488 = !DILocation(line: 149, column: 11, scope: !378)
!489 = !DILocation(line: 149, column: 22, scope: !378)
!490 = !{!257, !213, i64 1}
!491 = !DILocation(line: 150, column: 24, scope: !378)
!492 = !DILocation(line: 150, column: 11, scope: !378)
!493 = !DILocation(line: 150, column: 22, scope: !378)
!494 = !{!257, !213, i64 5}
!495 = !DILocation(line: 151, column: 27, scope: !378)
!496 = !DILocation(line: 151, column: 11, scope: !378)
!497 = !DILocation(line: 151, column: 25, scope: !378)
!498 = !{!257, !258, i64 9}
!499 = !DILocation(line: 152, column: 30, scope: !378)
!500 = !DILocation(line: 152, column: 14, scope: !378)
!501 = !DILocation(line: 152, column: 28, scope: !378)
!502 = !{!257, !258, i64 17}
!503 = !DILocation(line: 153, column: 22, scope: !378)
!504 = !DILocation(line: 0, scope: !425, inlinedAt: !452)
!505 = !DILocation(line: 83, column: 10, scope: !425, inlinedAt: !452)
!506 = !DILocation(line: 0, scope: !439, inlinedAt: !452)
!507 = !DILocation(line: 85, column: 9, scope: !508, inlinedAt: !452)
!508 = distinct !DILexicalBlock(scope: !509, file: !3, line: 84, column: 42)
!509 = distinct !DILexicalBlock(scope: !439, file: !3, line: 84, column: 5)
!510 = !DILocation(line: 0, scope: !442, inlinedAt: !452)
!511 = !DILocation(line: 92, column: 2, scope: !444, inlinedAt: !452)
!512 = !DILocation(line: 92, column: 24, scope: !444, inlinedAt: !452)
!513 = !DILocation(line: 92, column: 35, scope: !444, inlinedAt: !452)
!514 = !DILocation(line: 0, scope: !444, inlinedAt: !452)
!515 = !DILocation(line: 92, column: 8, scope: !444, inlinedAt: !452)
!516 = !DILocation(line: 93, column: 20, scope: !444, inlinedAt: !452)
!517 = !DILocation(line: 95, column: 14, scope: !451, inlinedAt: !452)
!518 = !DILocation(line: 95, column: 13, scope: !444, inlinedAt: !452)
!519 = distinct !{!519, !520, !521, !522}
!520 = !DILocation(line: 90, column: 5, scope: !442, inlinedAt: !452)
!521 = !DILocation(line: 103, column: 5, scope: !442, inlinedAt: !452)
!522 = !{!"llvm.loop.mustprogress"}
!523 = !DILocation(line: 90, column: 25, scope: !445, inlinedAt: !452)
!524 = !DILocation(line: 97, column: 17, scope: !449, inlinedAt: !452)
!525 = !DILocation(line: 97, column: 17, scope: !450, inlinedAt: !452)
!526 = !DILocation(line: 103, column: 5, scope: !445, inlinedAt: !452)
!527 = !DILocation(line: 102, column: 13, scope: !444, inlinedAt: !452)
!528 = !DILocation(line: 102, column: 22, scope: !444, inlinedAt: !452)
!529 = !DILocation(line: 102, column: 19, scope: !444, inlinedAt: !452)
!530 = !DILocation(line: 90, column: 44, scope: !445, inlinedAt: !452)
!531 = !DILocation(line: 107, column: 1, scope: !425, inlinedAt: !452)
!532 = !DILocation(line: 173, column: 1, scope: !378)
!533 = distinct !DISubprogram(name: "ip_checksum", scope: !3, file: !3, line: 175, type: !534, scopeLine: 175, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !536)
!534 = !DISubroutineType(types: !535)
!535 = !{!19, !15, !7}
!536 = !{!537, !538, !539, !540}
!537 = !DILocalVariable(name: "vdata", arg: 1, scope: !533, file: !3, line: 175, type: !15)
!538 = !DILocalVariable(name: "length", arg: 2, scope: !533, file: !3, line: 175, type: !7)
!539 = !DILocalVariable(name: "data", scope: !533, file: !3, line: 177, type: !21)
!540 = !DILocalVariable(name: "sum", scope: !533, file: !3, line: 180, type: !7)
!541 = !DILocation(line: 0, scope: !533)
!542 = !DILocation(line: 184, column: 16, scope: !543)
!543 = distinct !DILexicalBlock(scope: !533, file: !3, line: 183, column: 24)
!544 = !{!233, !233, i64 0}
!545 = !DILocation(line: 185, column: 14, scope: !543)
!546 = !DILocation(line: 184, column: 13, scope: !543)
!547 = !DILocation(line: 195, column: 5, scope: !533)
!548 = !DILocation(line: 195, column: 16, scope: !533)
!549 = !DILocation(line: 196, column: 20, scope: !550)
!550 = distinct !DILexicalBlock(scope: !533, file: !3, line: 195, column: 23)
!551 = !DILocation(line: 196, column: 30, scope: !550)
!552 = distinct !{!552, !547, !553, !522}
!553 = !DILocation(line: 197, column: 5, scope: !533)
!554 = !DILocation(line: 200, column: 12, scope: !533)
!555 = !DILocation(line: 200, column: 5, scope: !533)
