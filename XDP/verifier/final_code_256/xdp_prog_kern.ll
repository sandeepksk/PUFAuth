; ModuleID = 'xdp_prog_kern.c'
source_filename = "xdp_prog_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.bpf_map_def = type { i32, i32, i32, i32, i32 }
%struct.xdp_md = type { i32, i32, i32, i32, i32 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.auth_hdr = type <{ i8, i32, i32, i64, i64, i64, i64, i32, i32, i64 }>

@cr_db_map = dso_local global %struct.bpf_map_def { i32 2, i32 4, i32 80, i32 250000, i32 0 }, section "maps", align 4, !dbg !0
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
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !94, metadata !DIExpression()), !dbg !211
  %9 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 1, !dbg !212
  %10 = load i32, i32* %9, align 4, !dbg !212, !tbaa !213
  %11 = zext i32 %10 to i64, !dbg !218
  %12 = inttoptr i64 %11 to i8*, !dbg !219
  call void @llvm.dbg.value(metadata i8* %12, metadata !147, metadata !DIExpression()), !dbg !211
  %13 = getelementptr inbounds %struct.xdp_md, %struct.xdp_md* %0, i64 0, i32 0, !dbg !220
  %14 = load i32, i32* %13, align 4, !dbg !220, !tbaa !221
  %15 = zext i32 %14 to i64, !dbg !222
  %16 = inttoptr i64 %15 to i8*, !dbg !223
  call void @llvm.dbg.value(metadata i8* %16, metadata !148, metadata !DIExpression()), !dbg !211
  %17 = icmp ult i8* %16, %12, !dbg !224
  br i1 %17, label %18, label %135, !dbg !225

18:                                               ; preds = %1
  %19 = inttoptr i64 %15 to %struct.ethhdr*, !dbg !226
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !95, metadata !DIExpression()), !dbg !211
  %20 = getelementptr i8, i8* %16, i64 14, !dbg !227
  %21 = icmp ugt i8* %20, %12, !dbg !229
  br i1 %21, label %135, label %22, !dbg !230

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 2, !dbg !231
  %24 = load i16, i16* %23, align 1, !dbg !231, !tbaa !233
  %25 = icmp eq i16 %24, 8, !dbg !236
  br i1 %25, label %26, label %135, !dbg !237

26:                                               ; preds = %22
  call void @llvm.dbg.value(metadata i8* %20, metadata !108, metadata !DIExpression()), !dbg !211
  %27 = getelementptr i8, i8* %16, i64 34, !dbg !238
  %28 = icmp ugt i8* %27, %12, !dbg !240
  br i1 %28, label %135, label %29, !dbg !241

29:                                               ; preds = %26
  %30 = getelementptr i8, i8* %16, i64 23, !dbg !242
  %31 = load i8, i8* %30, align 1, !dbg !242, !tbaa !243
  %32 = icmp eq i8 %31, 17, !dbg !245
  br i1 %32, label %33, label %135, !dbg !246

33:                                               ; preds = %29
  call void @llvm.dbg.value(metadata i8* %27, metadata !138, metadata !DIExpression()), !dbg !211
  %34 = getelementptr i8, i8* %16, i64 42, !dbg !247
  %35 = icmp ugt i8* %34, %12, !dbg !249
  br i1 %35, label %135, label %36, !dbg !250

36:                                               ; preds = %33
  %37 = bitcast i8* %34 to %struct.auth_hdr*, !dbg !251
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %37, metadata !149, metadata !DIExpression()), !dbg !252
  %38 = getelementptr i8, i8* %16, i64 99, !dbg !253
  %39 = icmp ugt i8* %38, %12, !dbg !255
  br i1 %39, label %135, label %40, !dbg !256

40:                                               ; preds = %36
  %41 = load i8, i8* %34, align 1, !dbg !257, !tbaa !258
  call void @llvm.dbg.value(metadata i8 %41, metadata !175, metadata !DIExpression()), !dbg !252
  %42 = bitcast i32* %4 to i8*, !dbg !261
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %42) #7, !dbg !261
  %43 = getelementptr i8, i8* %16, i64 87, !dbg !262
  %44 = bitcast i8* %43 to i32*, !dbg !262
  %45 = load i32, i32* %44, align 1, !dbg !262, !tbaa !263
  %46 = tail call i32 @llvm.bswap.i32(i32 %45), !dbg !262
  %47 = add i32 %46, -1, !dbg !264
  call void @llvm.dbg.value(metadata i32 %47, metadata !176, metadata !DIExpression()), !dbg !252
  store i32 %47, i32* %4, align 4, !dbg !265, !tbaa !266
  switch i8 %41, label %130 [
    i8 0, label %48
    i8 2, label %85
  ], !dbg !267

48:                                               ; preds = %40
  %49 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !268
  call void @llvm.dbg.value(metadata i64 %49, metadata !177, metadata !DIExpression()), !dbg !269
  %50 = bitcast i32* %5 to i8*, !dbg !270
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %50) #7, !dbg !270
  %51 = tail call fastcc i32 @make_challenge_header(%struct.auth_hdr* noundef nonnull %37), !dbg !271
  call void @llvm.dbg.value(metadata i32 %51, metadata !180, metadata !DIExpression()), !dbg !269
  store i32 %51, i32* %5, align 4, !dbg !272, !tbaa !266
  %52 = getelementptr inbounds [17 x i8], [17 x i8]* %6, i64 0, i64 0, !dbg !273
  call void @llvm.lifetime.start.p0i8(i64 17, i8* nonnull %52) #7, !dbg !273
  call void @llvm.dbg.declare(metadata [17 x i8]* %6, metadata !181, metadata !DIExpression()), !dbg !273
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(17) %52, i8* noundef nonnull align 1 dereferenceable(17) getelementptr inbounds ([17 x i8], [17 x i8]* @__const.xdp_parsing.____fmt, i64 0, i64 0), i64 17, i1 false), !dbg !273
  %53 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %52, i32 noundef 17, i32 noundef %51) #7, !dbg !273
  call void @llvm.lifetime.end.p0i8(i64 17, i8* nonnull %52) #7, !dbg !274
  call void @llvm.dbg.value(metadata i32 %51, metadata !180, metadata !DIExpression()), !dbg !269
  %54 = icmp eq i32 %51, -1, !dbg !275
  br i1 %54, label %83, label %55, !dbg !277

55:                                               ; preds = %48
  call void @llvm.dbg.value(metadata i32* %4, metadata !176, metadata !DIExpression(DW_OP_deref)), !dbg !252
  call void @llvm.dbg.value(metadata i32* %5, metadata !180, metadata !DIExpression(DW_OP_deref)), !dbg !269
  %56 = call i32 inttoptr (i64 2 to i32 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42, i8* noundef nonnull %50, i64 noundef 0) #7, !dbg !278
  call void @llvm.dbg.value(metadata i8* %20, metadata !280, metadata !DIExpression()), !dbg !287
  %57 = getelementptr i8, i8* %16, i64 26, !dbg !289
  %58 = bitcast i8* %57 to i32*, !dbg !289
  %59 = load i32, i32* %58, align 4, !dbg !289, !tbaa !290
  call void @llvm.dbg.value(metadata i32 %59, metadata !286, metadata !DIExpression()), !dbg !287
  %60 = getelementptr i8, i8* %16, i64 30, !dbg !291
  %61 = bitcast i8* %60 to i32*, !dbg !291
  %62 = load i32, i32* %61, align 4, !dbg !291, !tbaa !290
  store i32 %62, i32* %58, align 4, !dbg !292, !tbaa !290
  store i32 %59, i32* %61, align 4, !dbg !293, !tbaa !290
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !294, metadata !DIExpression()) #7, !dbg !301
  %63 = getelementptr inbounds [6 x i8], [6 x i8]* %3, i64 0, i64 0, !dbg !303
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %63), !dbg !303
  call void @llvm.dbg.declare(metadata [6 x i8]* %3, metadata !299, metadata !DIExpression()) #7, !dbg !304
  %64 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !305
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %63, i8* noundef nonnull align 1 dereferenceable(6) %64, i64 6, i1 false) #7, !dbg !305
  %65 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !306
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %64, i8* noundef nonnull align 1 dereferenceable(6) %65, i64 6, i1 false) #7, !dbg !306
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %65, i8* noundef nonnull align 1 dereferenceable(6) %63, i64 6, i1 false) #7, !dbg !307
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %63), !dbg !308
  %66 = bitcast i8* %27 to i16*, !dbg !309
  %67 = load i16, i16* %66, align 2, !dbg !309, !tbaa !310
  call void @llvm.dbg.value(metadata i16 %67, metadata !186, metadata !DIExpression()), !dbg !269
  %68 = getelementptr i8, i8* %16, i64 36, !dbg !312
  %69 = bitcast i8* %68 to i16*, !dbg !312
  %70 = load i16, i16* %69, align 2, !dbg !312, !tbaa !313
  store i16 %70, i16* %66, align 2, !dbg !314, !tbaa !310
  store i16 %67, i16* %69, align 2, !dbg !315, !tbaa !313
  %71 = getelementptr i8, i8* %16, i64 40, !dbg !316
  %72 = bitcast i8* %71 to i16*, !dbg !316
  store i16 0, i16* %72, align 2, !dbg !317, !tbaa !318
  %73 = getelementptr i8, i8* %16, i64 24, !dbg !319
  %74 = bitcast i8* %73 to i16*, !dbg !319
  store i16 0, i16* %74, align 2, !dbg !320, !tbaa !321
  %75 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !322
  store i16 %75, i16* %74, align 2, !dbg !323, !tbaa !321
  %76 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !324
  call void @llvm.dbg.value(metadata i64 %76, metadata !187, metadata !DIExpression()), !dbg !269
  %77 = sub i64 %76, %49, !dbg !325
  %78 = trunc i64 %77 to i32
  %79 = call i32 @llvm.bswap.i32(i32 %78), !dbg !325
  %80 = zext i32 %79 to i64, !dbg !325
  %81 = getelementptr i8, i8* %16, i64 91, !dbg !326
  %82 = bitcast i8* %81 to i64*, !dbg !326
  store i64 %80, i64* %82, align 1, !dbg !327, !tbaa !328
  br label %83

83:                                               ; preds = %48, %55
  %84 = phi i32 [ 3, %55 ], [ 0, %48 ], !dbg !269
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %50) #7, !dbg !329
  br label %130

85:                                               ; preds = %40
  %86 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !330
  call void @llvm.dbg.value(metadata i64 %86, metadata !188, metadata !DIExpression()), !dbg !331
  %87 = getelementptr i8, i8* %16, i64 83, !dbg !332
  %88 = bitcast i8* %87 to i32*, !dbg !332
  %89 = load i32, i32* %88, align 1, !dbg !332, !tbaa !333
  call void @llvm.dbg.value(metadata i32 undef, metadata !191, metadata !DIExpression()), !dbg !331
  call void @llvm.dbg.value(metadata i32* %4, metadata !176, metadata !DIExpression(DW_OP_deref)), !dbg !252
  %90 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @hashValues to i8*), i8* noundef nonnull %42) #7, !dbg !334
  call void @llvm.dbg.value(metadata i8* %90, metadata !192, metadata !DIExpression()), !dbg !331
  %91 = icmp eq i8* %90, null, !dbg !335
  br i1 %91, label %92, label %95, !dbg !336

92:                                               ; preds = %85
  %93 = getelementptr inbounds [30 x i8], [30 x i8]* %7, i64 0, i64 0, !dbg !337
  call void @llvm.lifetime.start.p0i8(i64 30, i8* nonnull %93) #7, !dbg !337
  call void @llvm.dbg.declare(metadata [30 x i8]* %7, metadata !194, metadata !DIExpression()), !dbg !337
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(30) %93, i8* noundef nonnull align 1 dereferenceable(30) getelementptr inbounds ([30 x i8], [30 x i8]* @__const.xdp_parsing.____fmt.1, i64 0, i64 0), i64 30, i1 false), !dbg !337
  %94 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %93, i32 noundef 30) #7, !dbg !337
  call void @llvm.lifetime.end.p0i8(i64 30, i8* nonnull %93) #7, !dbg !338
  br label %130, !dbg !339

95:                                               ; preds = %85
  %96 = call i32 @llvm.bswap.i32(i32 %89), !dbg !332
  call void @llvm.dbg.value(metadata i32 %96, metadata !191, metadata !DIExpression()), !dbg !331
  %97 = bitcast i8* %90 to i32*, !dbg !334
  call void @llvm.dbg.value(metadata i32* %97, metadata !192, metadata !DIExpression()), !dbg !331
  %98 = load i32, i32* %97, align 4, !dbg !340, !tbaa !266
  %99 = icmp eq i32 %96, %98, !dbg !341
  br i1 %99, label %100, label %132, !dbg !342

100:                                              ; preds = %95
  store i8 3, i8* %34, align 1, !dbg !343, !tbaa !258
  %101 = load i32, i32* %4, align 4, !dbg !344, !tbaa !266
  call void @llvm.dbg.value(metadata i32 %101, metadata !176, metadata !DIExpression()), !dbg !252
  %102 = add i32 %101, 1, !dbg !344
  %103 = call i32 @llvm.bswap.i32(i32 %102), !dbg !344
  store i32 %103, i32* %44, align 1, !dbg !345, !tbaa !263
  call void @llvm.dbg.value(metadata i8* %20, metadata !280, metadata !DIExpression()), !dbg !346
  %104 = getelementptr i8, i8* %16, i64 26, !dbg !348
  %105 = bitcast i8* %104 to i32*, !dbg !348
  %106 = load i32, i32* %105, align 4, !dbg !348, !tbaa !290
  call void @llvm.dbg.value(metadata i32 %106, metadata !286, metadata !DIExpression()), !dbg !346
  %107 = getelementptr i8, i8* %16, i64 30, !dbg !349
  %108 = bitcast i8* %107 to i32*, !dbg !349
  %109 = load i32, i32* %108, align 4, !dbg !349, !tbaa !290
  store i32 %109, i32* %105, align 4, !dbg !350, !tbaa !290
  store i32 %106, i32* %108, align 4, !dbg !351, !tbaa !290
  call void @llvm.dbg.value(metadata %struct.ethhdr* %19, metadata !294, metadata !DIExpression()) #7, !dbg !352
  %110 = getelementptr inbounds [6 x i8], [6 x i8]* %2, i64 0, i64 0, !dbg !354
  call void @llvm.lifetime.start.p0i8(i64 6, i8* nonnull %110), !dbg !354
  call void @llvm.dbg.declare(metadata [6 x i8]* %2, metadata !299, metadata !DIExpression()) #7, !dbg !355
  %111 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 1, i64 0, !dbg !356
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %110, i8* noundef nonnull align 1 dereferenceable(6) %111, i64 6, i1 false) #7, !dbg !356
  %112 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i64 0, i32 0, i64 0, !dbg !357
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %111, i8* noundef nonnull align 1 dereferenceable(6) %112, i64 6, i1 false) #7, !dbg !357
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(6) %112, i8* noundef nonnull align 1 dereferenceable(6) %110, i64 6, i1 false) #7, !dbg !358
  call void @llvm.lifetime.end.p0i8(i64 6, i8* nonnull %110), !dbg !359
  %113 = bitcast i8* %27 to i16*, !dbg !360
  %114 = load i16, i16* %113, align 2, !dbg !360, !tbaa !310
  call void @llvm.dbg.value(metadata i16 %114, metadata !201, metadata !DIExpression()), !dbg !361
  %115 = getelementptr i8, i8* %16, i64 36, !dbg !362
  %116 = bitcast i8* %115 to i16*, !dbg !362
  %117 = load i16, i16* %116, align 2, !dbg !362, !tbaa !313
  store i16 %117, i16* %113, align 2, !dbg !363, !tbaa !310
  store i16 %114, i16* %116, align 2, !dbg !364, !tbaa !313
  %118 = getelementptr i8, i8* %16, i64 40, !dbg !365
  %119 = bitcast i8* %118 to i16*, !dbg !365
  store i16 0, i16* %119, align 2, !dbg !366, !tbaa !318
  %120 = getelementptr i8, i8* %16, i64 24, !dbg !367
  %121 = bitcast i8* %120 to i16*, !dbg !367
  store i16 0, i16* %121, align 2, !dbg !368, !tbaa !321
  %122 = call fastcc zeroext i16 @ip_checksum(i8* noundef %20), !dbg !369
  store i16 %122, i16* %121, align 2, !dbg !370, !tbaa !321
  %123 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !371
  call void @llvm.dbg.value(metadata i64 %123, metadata !204, metadata !DIExpression()), !dbg !361
  %124 = sub i64 %123, %86, !dbg !372
  %125 = trunc i64 %124 to i32, !dbg !372
  %126 = call i32 @llvm.bswap.i32(i32 %125), !dbg !372
  %127 = zext i32 %126 to i64, !dbg !372
  %128 = getelementptr i8, i8* %16, i64 91, !dbg !373
  %129 = bitcast i8* %128 to i64*, !dbg !373
  store i64 %127, i64* %129, align 1, !dbg !374, !tbaa !328
  br label %130

130:                                              ; preds = %83, %100, %92, %40
  %131 = phi i32 [ 2, %40 ], [ 0, %92 ], [ 3, %100 ], [ %84, %83 ]
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !375
  br label %135

132:                                              ; preds = %95
  %133 = getelementptr inbounds [48 x i8], [48 x i8]* %8, i64 0, i64 0, !dbg !376
  call void @llvm.lifetime.start.p0i8(i64 48, i8* nonnull %133) #7, !dbg !376
  call void @llvm.dbg.declare(metadata [48 x i8]* %8, metadata !205, metadata !DIExpression()), !dbg !376
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(48) %133, i8* noundef nonnull align 1 dereferenceable(48) getelementptr inbounds ([48 x i8], [48 x i8]* @__const.xdp_parsing.____fmt.2, i64 0, i64 0), i64 48, i1 false), !dbg !376
  %134 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %133, i32 noundef 48) #7, !dbg !376
  call void @llvm.lifetime.end.p0i8(i64 48, i8* nonnull %133) #7, !dbg !377
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %42) #7, !dbg !375
  br label %135, !dbg !378

135:                                              ; preds = %36, %130, %1, %33, %29, %26, %22, %18, %132
  %136 = phi i32 [ 2, %132 ], [ 1, %18 ], [ 2, %22 ], [ 1, %26 ], [ 2, %29 ], [ 1, %33 ], [ 1, %1 ], [ %131, %130 ], [ 1, %36 ], !dbg !211
  ret i32 %136, !dbg !379
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #1

; Function Attrs: nounwind
define internal fastcc i32 @make_challenge_header(%struct.auth_hdr* nocapture noundef %0) unnamed_addr #0 !dbg !380 {
  %2 = alloca i32, align 4
  %3 = alloca [21 x i8], align 1
  %4 = alloca [96 x i8], align 8, !dbg !442
  %5 = alloca [46 x i8], align 1
  %6 = alloca i32, align 4
  %7 = alloca [21 x i8], align 1
  call void @llvm.dbg.value(metadata %struct.auth_hdr* %0, metadata !384, metadata !DIExpression()), !dbg !471
  %8 = getelementptr inbounds [46 x i8], [46 x i8]* %5, i64 0, i64 0, !dbg !472
  call void @llvm.lifetime.start.p0i8(i64 46, i8* nonnull %8) #7, !dbg !472
  call void @llvm.dbg.declare(metadata [46 x i8]* %5, metadata !385, metadata !DIExpression()), !dbg !472
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(46) %8, i8* noundef nonnull align 1 dereferenceable(46) getelementptr inbounds ([46 x i8], [46 x i8]* @__const.make_challenge_header.____fmt, i64 0, i64 0), i64 46, i1 false), !dbg !472
  %9 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %8, i32 noundef 46) #7, !dbg !472
  call void @llvm.lifetime.end.p0i8(i64 46, i8* nonnull %8) #7, !dbg !473
  %10 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 8, !dbg !474
  %11 = load i32, i32* %10, align 1, !dbg !474, !tbaa !263
  %12 = call i32 @llvm.bswap.i32(i32 %11), !dbg !474
  call void @llvm.dbg.value(metadata i32 %12, metadata !390, metadata !DIExpression(DW_OP_constu, 1, DW_OP_minus, DW_OP_stack_value)), !dbg !471
  %13 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !475
  call void @llvm.dbg.value(metadata i32 %13, metadata !406, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !471
  %14 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !476
  call void @llvm.dbg.value(metadata i32 %14, metadata !407, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !471
  %15 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !477
  call void @llvm.dbg.value(metadata i32 %15, metadata !408, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !471
  %16 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !478
  call void @llvm.dbg.value(metadata i32 %16, metadata !409, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !471
  %17 = urem i32 %13, 500, !dbg !479
  call void @llvm.dbg.value(metadata i32 %17, metadata !410, metadata !DIExpression()), !dbg !471
  %18 = bitcast i32* %6 to i8*, !dbg !480
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %18) #7, !dbg !480
  %19 = mul i32 %12, 500, !dbg !481
  %20 = add i32 %19, -500, !dbg !481
  %21 = add i32 %20, %17, !dbg !482
  call void @llvm.dbg.value(metadata i32 %21, metadata !411, metadata !DIExpression()), !dbg !471
  store i32 %21, i32* %6, align 4, !dbg !483, !tbaa !266
  call void @llvm.dbg.value(metadata i32* %6, metadata !411, metadata !DIExpression(DW_OP_deref)), !dbg !471
  %22 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @cr_db_map to i8*), i8* noundef nonnull %18) #7, !dbg !484
  call void @llvm.dbg.value(metadata i8* %22, metadata !391, metadata !DIExpression()), !dbg !471
  %23 = icmp eq i8* %22, null, !dbg !485
  br i1 %23, label %24, label %27, !dbg !486

24:                                               ; preds = %1
  %25 = getelementptr inbounds [21 x i8], [21 x i8]* %7, i64 0, i64 0, !dbg !487
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %25) #7, !dbg !487
  call void @llvm.dbg.declare(metadata [21 x i8]* %7, metadata !412, metadata !DIExpression()), !dbg !487
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %25, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false), !dbg !487
  %26 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %25, i32 noundef 21) #7, !dbg !487
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %25) #7, !dbg !488
  br label %152, !dbg !489

27:                                               ; preds = %1
  %28 = zext i32 %16 to i64, !dbg !478
  call void @llvm.dbg.value(metadata i64 %28, metadata !409, metadata !DIExpression()), !dbg !471
  %29 = zext i32 %15 to i64, !dbg !477
  call void @llvm.dbg.value(metadata i64 %29, metadata !408, metadata !DIExpression()), !dbg !471
  %30 = zext i32 %14 to i64, !dbg !476
  call void @llvm.dbg.value(metadata i64 %30, metadata !407, metadata !DIExpression()), !dbg !471
  %31 = zext i32 %13 to i64, !dbg !475
  call void @llvm.dbg.value(metadata i64 %31, metadata !406, metadata !DIExpression()), !dbg !471
  call void @llvm.dbg.value(metadata i8* %22, metadata !391, metadata !DIExpression()), !dbg !471
  %32 = bitcast i8* %22 to i32*, !dbg !490
  %33 = load i32, i32* %32, align 8, !dbg !490, !tbaa !491
  call void @llvm.dbg.value(metadata i32 %33, metadata !419, metadata !DIExpression()), !dbg !471
  %34 = getelementptr inbounds i8, i8* %22, i64 40, !dbg !493
  %35 = bitcast i8* %34 to i32*, !dbg !493
  %36 = load i32, i32* %35, align 8, !dbg !493, !tbaa !494
  call void @llvm.dbg.value(metadata i32 %36, metadata !420, metadata !DIExpression()), !dbg !471
  %37 = getelementptr inbounds i8, i8* %22, i64 8, !dbg !495
  %38 = bitcast i8* %37 to i64*, !dbg !495
  %39 = load i64, i64* %38, align 8, !dbg !495, !tbaa !496
  call void @llvm.dbg.value(metadata i64 %39, metadata !421, metadata !DIExpression()), !dbg !471
  %40 = getelementptr inbounds i8, i8* %22, i64 16, !dbg !497
  %41 = bitcast i8* %40 to i64*, !dbg !497
  %42 = load i64, i64* %41, align 8, !dbg !497, !tbaa !498
  call void @llvm.dbg.value(metadata i64 %42, metadata !422, metadata !DIExpression()), !dbg !471
  %43 = getelementptr inbounds i8, i8* %22, i64 24, !dbg !499
  %44 = bitcast i8* %43 to i64*, !dbg !499
  %45 = load i64, i64* %44, align 8, !dbg !499, !tbaa !500
  call void @llvm.dbg.value(metadata i64 %45, metadata !423, metadata !DIExpression()), !dbg !471
  %46 = getelementptr inbounds i8, i8* %22, i64 32, !dbg !501
  %47 = bitcast i8* %46 to i64*, !dbg !501
  %48 = load i64, i64* %47, align 8, !dbg !501, !tbaa !502
  call void @llvm.dbg.value(metadata i64 %48, metadata !424, metadata !DIExpression()), !dbg !471
  %49 = getelementptr inbounds i8, i8* %22, i64 48, !dbg !503
  %50 = bitcast i8* %49 to i64*, !dbg !503
  %51 = load i64, i64* %50, align 8, !dbg !503, !tbaa !504
  call void @llvm.dbg.value(metadata i64 %51, metadata !425, metadata !DIExpression()), !dbg !471
  %52 = getelementptr inbounds i8, i8* %22, i64 56, !dbg !505
  %53 = bitcast i8* %52 to i64*, !dbg !505
  %54 = load i64, i64* %53, align 8, !dbg !505, !tbaa !506
  call void @llvm.dbg.value(metadata i64 %54, metadata !426, metadata !DIExpression()), !dbg !471
  %55 = getelementptr inbounds i8, i8* %22, i64 64, !dbg !507
  %56 = bitcast i8* %55 to i64*, !dbg !507
  %57 = load i64, i64* %56, align 8, !dbg !507, !tbaa !508
  call void @llvm.dbg.value(metadata i64 %57, metadata !427, metadata !DIExpression()), !dbg !471
  %58 = getelementptr inbounds i8, i8* %22, i64 72, !dbg !509
  %59 = bitcast i8* %58 to i64*, !dbg !509
  %60 = load i64, i64* %59, align 8, !dbg !509, !tbaa !510
  call void @llvm.dbg.value(metadata i64 %60, metadata !428, metadata !DIExpression()), !dbg !471
  %61 = or i64 %51, %39, !dbg !511
  call void @llvm.dbg.value(metadata i64 %61, metadata !429, metadata !DIExpression()), !dbg !471
  %62 = or i64 %54, %42, !dbg !512
  call void @llvm.dbg.value(metadata i64 %62, metadata !430, metadata !DIExpression()), !dbg !471
  %63 = or i64 %57, %45, !dbg !513
  call void @llvm.dbg.value(metadata i64 %63, metadata !431, metadata !DIExpression()), !dbg !471
  %64 = or i64 %60, %48, !dbg !514
  call void @llvm.dbg.value(metadata i64 %64, metadata !432, metadata !DIExpression()), !dbg !471
  call void @llvm.dbg.value(metadata !DIArgList(i64 %61, i32 %13), metadata !433, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !471
  call void @llvm.dbg.value(metadata !DIArgList(i64 %62, i32 %14), metadata !434, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !471
  call void @llvm.dbg.value(metadata !DIArgList(i64 %63, i32 %15), metadata !435, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !471
  call void @llvm.dbg.value(metadata !DIArgList(i64 %64, i32 %16), metadata !436, metadata !DIExpression(DW_OP_LLVM_arg, 0, DW_OP_LLVM_arg, 1, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_xor, DW_OP_stack_value)), !dbg !471
  %65 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 0, !dbg !515
  store i8 1, i8* %65, align 1, !dbg !516, !tbaa !258
  %66 = call i32 @llvm.bswap.i32(i32 %33), !dbg !517
  %67 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 1, !dbg !518
  store i32 %66, i32* %67, align 1, !dbg !519, !tbaa !520
  %68 = call i32 @llvm.bswap.i32(i32 %36), !dbg !521
  %69 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 2, !dbg !522
  store i32 %68, i32* %69, align 1, !dbg !523, !tbaa !524
  %70 = trunc i64 %61 to i32, !dbg !525
  %71 = xor i32 %13, %70, !dbg !525
  %72 = call i32 @llvm.bswap.i32(i32 %71), !dbg !525
  %73 = zext i32 %72 to i64, !dbg !525
  %74 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 3, !dbg !526
  store i64 %73, i64* %74, align 1, !dbg !527, !tbaa !528
  %75 = trunc i64 %62 to i32, !dbg !529
  %76 = xor i32 %14, %75, !dbg !529
  %77 = call i32 @llvm.bswap.i32(i32 %76), !dbg !529
  %78 = zext i32 %77 to i64, !dbg !529
  %79 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 4, !dbg !530
  store i64 %78, i64* %79, align 1, !dbg !531, !tbaa !532
  %80 = trunc i64 %63 to i32, !dbg !533
  %81 = xor i32 %15, %80, !dbg !533
  %82 = call i32 @llvm.bswap.i32(i32 %81), !dbg !533
  %83 = zext i32 %82 to i64, !dbg !533
  %84 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 5, !dbg !534
  store i64 %83, i64* %84, align 1, !dbg !535, !tbaa !536
  %85 = trunc i64 %64 to i32, !dbg !537
  %86 = xor i32 %16, %85, !dbg !537
  %87 = call i32 @llvm.bswap.i32(i32 %86), !dbg !537
  %88 = zext i32 %87 to i64, !dbg !537
  %89 = getelementptr inbounds %struct.auth_hdr, %struct.auth_hdr* %0, i64 0, i32 6, !dbg !538
  store i64 %88, i64* %89, align 1, !dbg !539, !tbaa !540
  store i32 %11, i32* %10, align 1, !dbg !541, !tbaa !263
  call void @llvm.dbg.value(metadata i64 %39, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 0, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %42, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 64, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %45, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 128, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %48, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 192, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %51, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 256, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %54, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 320, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %57, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 384, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i64 %60, metadata !437, metadata !DIExpression(DW_OP_LLVM_fragment, 448, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i32 %13, metadata !437, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 512, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i32 %14, metadata !437, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 576, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i32 %15, metadata !437, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 640, 64)), !dbg !471
  call void @llvm.dbg.value(metadata i32 %16, metadata !437, metadata !DIExpression(DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_LLVM_convert, 64, DW_ATE_unsigned, DW_OP_stack_value, DW_OP_LLVM_fragment, 704, 64)), !dbg !471
  %90 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 96, i8* nonnull %90)
  call void @llvm.dbg.value(metadata i64* undef, metadata !448, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.value(metadata i32 12, metadata !449, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.value(metadata i64 96, metadata !450, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.declare(metadata [96 x i8]* %4, metadata !452, metadata !DIExpression()) #7, !dbg !543
  call void @llvm.dbg.value(metadata i32 0, metadata !456, metadata !DIExpression()) #7, !dbg !544
  %91 = bitcast [96 x i8]* %4 to i64*, !dbg !545
  store i64 %39, i64* %91, align 8, !dbg !545
  %92 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 8, !dbg !545
  %93 = bitcast i8* %92 to i64*, !dbg !545
  store i64 %42, i64* %93, align 8, !dbg !545
  %94 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 16, !dbg !545
  %95 = bitcast i8* %94 to i64*, !dbg !545
  store i64 %45, i64* %95, align 8, !dbg !545
  %96 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 24, !dbg !545
  %97 = bitcast i8* %96 to i64*, !dbg !545
  store i64 %48, i64* %97, align 8, !dbg !545
  %98 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 32, !dbg !545
  %99 = bitcast i8* %98 to i64*, !dbg !545
  store i64 %51, i64* %99, align 8, !dbg !545
  %100 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 40, !dbg !545
  %101 = bitcast i8* %100 to i64*, !dbg !545
  store i64 %54, i64* %101, align 8, !dbg !545
  %102 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 48, !dbg !545
  %103 = bitcast i8* %102 to i64*, !dbg !545
  store i64 %57, i64* %103, align 8, !dbg !545
  %104 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 56, !dbg !545
  %105 = bitcast i8* %104 to i64*, !dbg !545
  store i64 %60, i64* %105, align 8, !dbg !545
  %106 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 64, !dbg !545
  %107 = bitcast i8* %106 to i64*, !dbg !545
  store i64 %31, i64* %107, align 8, !dbg !545
  %108 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 72, !dbg !545
  %109 = bitcast i8* %108 to i64*, !dbg !545
  store i64 %30, i64* %109, align 8, !dbg !545
  %110 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 80, !dbg !545
  %111 = bitcast i8* %110 to i64*, !dbg !545
  store i64 %29, i64* %111, align 8, !dbg !545
  %112 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 88, !dbg !545
  %113 = bitcast i8* %112 to i64*, !dbg !545
  store i64 %28, i64* %113, align 8, !dbg !545
  call void @llvm.dbg.value(metadata i32 undef, metadata !456, metadata !DIExpression()) #7, !dbg !544
  call void @llvm.dbg.value(metadata i32 undef, metadata !456, metadata !DIExpression(DW_OP_plus_uconst, 1, DW_OP_stack_value)) #7, !dbg !544
  %114 = bitcast i32* %2 to i8*
  call void @llvm.dbg.value(metadata i32 0, metadata !459, metadata !DIExpression()) #7, !dbg !548
  call void @llvm.dbg.value(metadata i32 -1, metadata !458, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.value(metadata i64 0, metadata !459, metadata !DIExpression()) #7, !dbg !548
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %114) #7, !dbg !549
  %115 = trunc i64 %39 to i32, !dbg !550
  %116 = and i32 %115, 255, !dbg !551
  %117 = xor i32 %116, 255, !dbg !551
  call void @llvm.dbg.value(metadata i32 %117, metadata !461, metadata !DIExpression()) #7, !dbg !552
  store i32 %117, i32* %2, align 4, !dbg !553, !tbaa !266
  call void @llvm.dbg.value(metadata i32* %2, metadata !461, metadata !DIExpression(DW_OP_deref)) #7, !dbg !552
  %118 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %114) #7, !dbg !554
  call void @llvm.dbg.value(metadata i8* %118, metadata !464, metadata !DIExpression()) #7, !dbg !552
  %119 = icmp eq i8* %118, null, !dbg !555
  br i1 %119, label %130, label %135, !dbg !556

120:                                              ; preds = %135
  call void @llvm.dbg.value(metadata i64 %143, metadata !459, metadata !DIExpression()) #7, !dbg !548
  call void @llvm.dbg.value(metadata i32 %142, metadata !458, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %114) #7, !dbg !549
  %121 = getelementptr inbounds [96 x i8], [96 x i8]* %4, i64 0, i64 %143, !dbg !550
  %122 = load i8, i8* %121, align 1, !dbg !550, !tbaa !290
  %123 = zext i8 %122 to i32, !dbg !550
  %124 = and i32 %142, 255, !dbg !551
  %125 = xor i32 %124, %123, !dbg !551
  call void @llvm.dbg.value(metadata i32 %125, metadata !461, metadata !DIExpression()) #7, !dbg !552
  store i32 %125, i32* %2, align 4, !dbg !553, !tbaa !266
  call void @llvm.dbg.value(metadata i32* %2, metadata !461, metadata !DIExpression(DW_OP_deref)) #7, !dbg !552
  %126 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.bpf_map_def* @crc32_table to i8*), i8* noundef nonnull %114) #7, !dbg !554
  call void @llvm.dbg.value(metadata i8* %126, metadata !464, metadata !DIExpression()) #7, !dbg !552
  %127 = icmp eq i8* %126, null, !dbg !555
  br i1 %127, label %128, label %135, !dbg !556, !llvm.loop !557

128:                                              ; preds = %120
  %129 = icmp ult i64 %138, 95, !dbg !561
  br label %130, !dbg !562

130:                                              ; preds = %128, %27
  %131 = phi i1 [ true, %27 ], [ %129, %128 ]
  %132 = phi i32 [ -1, %27 ], [ %142, %128 ]
  %133 = getelementptr inbounds [21 x i8], [21 x i8]* %3, i64 0, i64 0, !dbg !562
  call void @llvm.lifetime.start.p0i8(i64 21, i8* nonnull %133) #7, !dbg !562
  call void @llvm.dbg.declare(metadata [21 x i8]* %3, metadata !466, metadata !DIExpression()) #7, !dbg !562
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 1 dereferenceable(21) %133, i8* noundef nonnull align 1 dereferenceable(21) getelementptr inbounds ([21 x i8], [21 x i8]* @__const.computeHash.____fmt, i64 0, i64 0), i64 21, i1 false) #7, !dbg !562
  %134 = call i32 (i8*, i32, ...) inttoptr (i64 6 to i32 (i8*, i32, ...)*)(i8* noundef nonnull %133, i32 noundef 21) #7, !dbg !562
  call void @llvm.lifetime.end.p0i8(i64 21, i8* nonnull %133) #7, !dbg !563
  call void @llvm.dbg.value(metadata i32 undef, metadata !458, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %114) #7, !dbg !564
  br label %147

135:                                              ; preds = %27, %120
  %136 = phi i8* [ %126, %120 ], [ %118, %27 ]
  %137 = phi i32 [ %142, %120 ], [ -1, %27 ]
  %138 = phi i64 [ %143, %120 ], [ 0, %27 ]
  call void @llvm.dbg.value(metadata i32 %137, metadata !458, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.value(metadata i64 %138, metadata !459, metadata !DIExpression()) #7, !dbg !548
  %139 = bitcast i8* %136 to i32*, !dbg !554
  call void @llvm.dbg.value(metadata i32* %139, metadata !464, metadata !DIExpression()) #7, !dbg !552
  %140 = lshr i32 %137, 8, !dbg !565
  %141 = load i32, i32* %139, align 4, !dbg !566, !tbaa !266
  %142 = xor i32 %141, %140, !dbg !567
  call void @llvm.dbg.value(metadata i32 %142, metadata !458, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %114) #7, !dbg !564
  %143 = add nuw nsw i64 %138, 1, !dbg !568
  call void @llvm.dbg.value(metadata i64 %143, metadata !459, metadata !DIExpression()) #7, !dbg !548
  %144 = icmp eq i64 %143, 96, !dbg !561
  br i1 %144, label %145, label %120, !dbg !558, !llvm.loop !557

145:                                              ; preds = %135
  %146 = icmp ult i64 %138, 95, !dbg !561
  br label %147

147:                                              ; preds = %145, %130
  %148 = phi i32 [ %132, %130 ], [ %142, %145 ]
  %149 = phi i1 [ %131, %130 ], [ %146, %145 ]
  call void @llvm.dbg.value(metadata i32 %148, metadata !458, metadata !DIExpression()) #7, !dbg !542
  %150 = xor i32 %148, -1
  %151 = select i1 %149, i32 0, i32 %150
  call void @llvm.lifetime.end.p0i8(i64 96, i8* nonnull %90), !dbg !569
  call void @llvm.dbg.value(metadata i32 %151, metadata !441, metadata !DIExpression()), !dbg !471
  br label %152

152:                                              ; preds = %147, %24
  %153 = phi i32 [ %151, %147 ], [ 0, %24 ], !dbg !471
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %18) #7, !dbg !570
  ret i32 %153, !dbg !570
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #2

; Function Attrs: nofree norecurse nosync nounwind readonly
define internal fastcc zeroext i16 @ip_checksum(i8* nocapture noundef readonly %0) unnamed_addr #4 !dbg !571 {
  call void @llvm.dbg.value(metadata i8* %0, metadata !575, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 20, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 0, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 0, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 20, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 18, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 18, metadata !576, metadata !DIExpression()), !dbg !579
  %2 = bitcast i8* %0 to <8 x i16>*, !dbg !580
  %3 = load <8 x i16>, <8 x i16>* %2, align 2, !dbg !580, !tbaa !582
  %4 = zext <8 x i16> %3 to <8 x i32>, !dbg !580
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 16, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 4, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 16, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 14, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 6, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 14, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 12, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 8, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 12, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 10, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 10, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 10, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 8, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 12, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 8, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 6, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %0, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 14, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 6, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  %5 = getelementptr inbounds i8, i8* %0, i64 16, !dbg !583
  call void @llvm.dbg.value(metadata i8* %5, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 4, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %5, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 4, metadata !576, metadata !DIExpression()), !dbg !579
  %6 = bitcast i8* %5 to i16*, !dbg !580
  %7 = load i16, i16* %6, align 2, !dbg !580, !tbaa !582
  %8 = zext i16 %7 to i32, !dbg !580
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  %9 = getelementptr inbounds i8, i8* %0, i64 18, !dbg !583
  call void @llvm.dbg.value(metadata i8* %9, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 2, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 undef, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %9, metadata !577, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 2, metadata !576, metadata !DIExpression()), !dbg !579
  %10 = bitcast i8* %9 to i16*, !dbg !580
  %11 = load i16, i16* %10, align 2, !dbg !580, !tbaa !582
  %12 = zext i16 %11 to i32, !dbg !580
  %13 = call i32 @llvm.vector.reduce.add.v8i32(<8 x i32> %4), !dbg !584
  %14 = add nuw nsw i32 %13, %8, !dbg !580
  %15 = add nuw nsw i32 %14, %12, !dbg !580
  call void @llvm.dbg.value(metadata i32 %15, metadata !578, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i8* %9, metadata !577, metadata !DIExpression(DW_OP_plus_uconst, 2, DW_OP_stack_value)), !dbg !579
  call void @llvm.dbg.value(metadata i32 0, metadata !576, metadata !DIExpression()), !dbg !579
  call void @llvm.dbg.value(metadata i32 %15, metadata !578, metadata !DIExpression()), !dbg !579
  %16 = icmp ult i32 %15, 65536, !dbg !585
  br i1 %16, label %23, label %17, !dbg !585

17:                                               ; preds = %1, %17
  %18 = phi i32 [ %21, %17 ], [ %15, %1 ]
  call void @llvm.dbg.value(metadata i32 %18, metadata !578, metadata !DIExpression()), !dbg !579
  %19 = lshr i32 %18, 16, !dbg !586
  %20 = and i32 %18, 65535, !dbg !587
  %21 = add nuw nsw i32 %20, %19, !dbg !589
  call void @llvm.dbg.value(metadata i32 %21, metadata !578, metadata !DIExpression()), !dbg !579
  %22 = icmp ult i32 %21, 65536, !dbg !585
  br i1 %22, label %23, label %17, !dbg !585, !llvm.loop !590

23:                                               ; preds = %17, %1
  %24 = phi i32 [ %15, %1 ], [ %21, %17 ], !dbg !579
  %25 = trunc i32 %24 to i16, !dbg !592
  %26 = xor i16 %25, -1, !dbg !592
  ret i16 %26, !dbg !593
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
!1 = distinct !DIGlobalVariable(name: "cr_db_map", scope: !2, file: !3, line: 51, type: !29, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !14, globals: !26, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "xdp_prog_kern.c", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "67f8f5a675feaa63bbce193eb389394e")
!4 = !{!5}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 2845, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "../headers/linux/bpf.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "db1ce4e5e29770657167bc8f57af9388")
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
!28 = distinct !DIGlobalVariable(name: "hashValues", scope: !2, file: !3, line: 58, type: !29, isLocal: false, isDefinition: true)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_map_def", file: !30, line: 33, size: 160, elements: !31)
!30 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "9e37b5f46a8fb7f5ed35ab69309bf15d")
!31 = !{!32, !33, !34, !35, !36}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !29, file: !30, line: 34, baseType: !7, size: 32)
!33 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !29, file: !30, line: 35, baseType: !7, size: 32, offset: 32)
!34 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !29, file: !30, line: 36, baseType: !7, size: 32, offset: 64)
!35 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !29, file: !30, line: 37, baseType: !7, size: 32, offset: 96)
!36 = !DIDerivedType(tag: DW_TAG_member, name: "map_flags", scope: !29, file: !30, line: 38, baseType: !7, size: 32, offset: 128)
!37 = !DIGlobalVariableExpression(var: !38, expr: !DIExpression())
!38 = distinct !DIGlobalVariable(name: "crc32_table", scope: !2, file: !3, line: 67, type: !29, isLocal: false, isDefinition: true)
!39 = !DIGlobalVariableExpression(var: !40, expr: !DIExpression())
!40 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 381, type: !41, isLocal: false, isDefinition: true)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 32, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 4)
!44 = !DIGlobalVariableExpression(var: !45, expr: !DIExpression())
!45 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !46, line: 89, type: !47, isLocal: true, isDefinition: true)
!46 = !DIFile(filename: "../libbpf/src//build/usr/include/bpf/bpf_helper_defs.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "2601bcf9d7985cb46bfbd904b60f5aaf")
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
!82 = distinct !DISubprogram(name: "xdp_parsing", scope: !3, file: !3, line: 226, type: !83, scopeLine: 226, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
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
!93 = !{!94, !95, !108, !138, !147, !148, !149, !175, !176, !177, !180, !181, !186, !187, !188, !191, !192, !194, !201, !204, !205}
!94 = !DILocalVariable(name: "ctx", arg: 1, scope: !82, file: !3, line: 226, type: !85)
!95 = !DILocalVariable(name: "eth", scope: !82, file: !3, line: 229, type: !96)
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
!108 = !DILocalVariable(name: "iph", scope: !82, file: !3, line: 230, type: !109)
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
!138 = !DILocalVariable(name: "udph", scope: !82, file: !3, line: 231, type: !139)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !140, size: 64)
!140 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "udphdr", file: !141, line: 23, size: 64, elements: !142)
!141 = !DIFile(filename: "/usr/include/linux/udp.h", directory: "", checksumkind: CSK_MD5, checksum: "53c0d42e1bf6d93b39151764be2d20fb")
!142 = !{!143, !144, !145, !146}
!143 = !DIDerivedType(tag: DW_TAG_member, name: "source", scope: !140, file: !141, line: 24, baseType: !106, size: 16)
!144 = !DIDerivedType(tag: DW_TAG_member, name: "dest", scope: !140, file: !141, line: 25, baseType: !106, size: 16, offset: 16)
!145 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !140, file: !141, line: 26, baseType: !106, size: 16, offset: 32)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !140, file: !141, line: 27, baseType: !123, size: 16, offset: 48)
!147 = !DILocalVariable(name: "data_end", scope: !82, file: !3, line: 233, type: !15)
!148 = !DILocalVariable(name: "data", scope: !82, file: !3, line: 234, type: !15)
!149 = !DILocalVariable(name: "payload", scope: !150, file: !3, line: 263, type: !154)
!150 = distinct !DILexicalBlock(scope: !151, file: !3, line: 256, column: 9)
!151 = distinct !DILexicalBlock(scope: !152, file: !3, line: 251, column: 13)
!152 = distinct !DILexicalBlock(scope: !153, file: !3, line: 237, column: 3)
!153 = distinct !DILexicalBlock(scope: !82, file: !3, line: 236, column: 6)
!154 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !155, size: 64)
!155 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "auth_hdr", file: !3, line: 36, size: 456, elements: !156)
!156 = !{!157, !162, !165, !166, !169, !170, !171, !172, !173, !174}
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
!170 = !DIDerivedType(tag: DW_TAG_member, name: "randomnumber3", scope: !155, file: !3, line: 42, baseType: !167, size: 64, offset: 200)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "randomnumber4", scope: !155, file: !3, line: 43, baseType: !167, size: 64, offset: 264)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !155, file: !3, line: 44, baseType: !163, size: 32, offset: 328)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "identifier", scope: !155, file: !3, line: 45, baseType: !163, size: 32, offset: 360)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "prTime", scope: !155, file: !3, line: 46, baseType: !167, size: 64, offset: 392)
!175 = !DILocalVariable(name: "msg_type", scope: !150, file: !3, line: 275, type: !158)
!176 = !DILocalVariable(name: "id", scope: !150, file: !3, line: 276, type: !163)
!177 = !DILocalVariable(name: "t1", scope: !178, file: !3, line: 282, type: !167)
!178 = distinct !DILexicalBlock(scope: !179, file: !3, line: 281, column: 12)
!179 = distinct !DILexicalBlock(scope: !150, file: !3, line: 280, column: 15)
!180 = !DILocalVariable(name: "h", scope: !178, file: !3, line: 284, type: !163)
!181 = !DILocalVariable(name: "____fmt", scope: !182, file: !3, line: 285, type: !183)
!182 = distinct !DILexicalBlock(scope: !178, file: !3, line: 285, column: 13)
!183 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 136, elements: !184)
!184 = !{!185}
!185 = !DISubrange(count: 17)
!186 = !DILocalVariable(name: "src_port", scope: !178, file: !3, line: 300, type: !106)
!187 = !DILocalVariable(name: "t2", scope: !178, file: !3, line: 313, type: !167)
!188 = !DILocalVariable(name: "t1", scope: !189, file: !3, line: 321, type: !167)
!189 = distinct !DILexicalBlock(scope: !190, file: !3, line: 320, column: 12)
!190 = distinct !DILexicalBlock(scope: !179, file: !3, line: 319, column: 20)
!191 = !DILocalVariable(name: "h1", scope: !189, file: !3, line: 322, type: !163)
!192 = !DILocalVariable(name: "h2", scope: !189, file: !3, line: 323, type: !193)
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!194 = !DILocalVariable(name: "____fmt", scope: !195, file: !3, line: 327, type: !198)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 327, column: 14)
!196 = distinct !DILexicalBlock(scope: !197, file: !3, line: 326, column: 13)
!197 = distinct !DILexicalBlock(scope: !189, file: !3, line: 325, column: 16)
!198 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 240, elements: !199)
!199 = !{!200}
!200 = !DISubrange(count: 30)
!201 = !DILocalVariable(name: "src_port", scope: !202, file: !3, line: 344, type: !106)
!202 = distinct !DILexicalBlock(scope: !203, file: !3, line: 333, column: 13)
!203 = distinct !DILexicalBlock(scope: !189, file: !3, line: 332, column: 16)
!204 = !DILocalVariable(name: "t2", scope: !202, file: !3, line: 356, type: !167)
!205 = !DILocalVariable(name: "____fmt", scope: !206, file: !3, line: 363, type: !208)
!206 = distinct !DILexicalBlock(scope: !207, file: !3, line: 363, column: 4)
!207 = distinct !DILexicalBlock(scope: !203, file: !3, line: 362, column: 3)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 384, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 48)
!211 = !DILocation(line: 0, scope: !82)
!212 = !DILocation(line: 233, column: 44, scope: !82)
!213 = !{!214, !215, i64 4}
!214 = !{!"xdp_md", !215, i64 0, !215, i64 4, !215, i64 8, !215, i64 12, !215, i64 16}
!215 = !{!"int", !216, i64 0}
!216 = !{!"omnipotent char", !217, i64 0}
!217 = !{!"Simple C/C++ TBAA"}
!218 = !DILocation(line: 233, column: 30, scope: !82)
!219 = !DILocation(line: 233, column: 21, scope: !82)
!220 = !DILocation(line: 234, column: 40, scope: !82)
!221 = !{!214, !215, i64 0}
!222 = !DILocation(line: 234, column: 26, scope: !82)
!223 = !DILocation(line: 234, column: 17, scope: !82)
!224 = !DILocation(line: 236, column: 11, scope: !153)
!225 = !DILocation(line: 236, column: 6, scope: !82)
!226 = !DILocation(line: 238, column: 15, scope: !152)
!227 = !DILocation(line: 239, column: 18, scope: !228)
!228 = distinct !DILexicalBlock(scope: !152, file: !3, line: 239, column: 13)
!229 = !DILocation(line: 239, column: 33, scope: !228)
!230 = !DILocation(line: 239, column: 13, scope: !152)
!231 = !DILocation(line: 242, column: 13, scope: !232)
!232 = distinct !DILexicalBlock(scope: !152, file: !3, line: 242, column: 13)
!233 = !{!234, !235, i64 12}
!234 = !{!"ethhdr", !216, i64 0, !216, i64 6, !235, i64 12}
!235 = !{!"short", !216, i64 0}
!236 = !DILocation(line: 242, column: 37, scope: !232)
!237 = !DILocation(line: 242, column: 13, scope: !152)
!238 = !DILocation(line: 248, column: 33, scope: !239)
!239 = distinct !DILexicalBlock(scope: !152, file: !3, line: 248, column: 13)
!240 = !DILocation(line: 248, column: 48, scope: !239)
!241 = !DILocation(line: 248, column: 13, scope: !152)
!242 = !DILocation(line: 251, column: 18, scope: !151)
!243 = !{!244, !216, i64 9}
!244 = !{!"iphdr", !216, i64 0, !216, i64 0, !216, i64 1, !235, i64 2, !235, i64 4, !235, i64 6, !216, i64 8, !216, i64 9, !235, i64 10, !216, i64 12}
!245 = !DILocation(line: 251, column: 27, scope: !151)
!246 = !DILocation(line: 251, column: 13, scope: !152)
!247 = !DILocation(line: 258, column: 51, scope: !248)
!248 = distinct !DILexicalBlock(scope: !150, file: !3, line: 258, column: 16)
!249 = !DILocation(line: 258, column: 67, scope: !248)
!250 = !DILocation(line: 258, column: 16, scope: !150)
!251 = !DILocation(line: 263, column: 39, scope: !150)
!252 = !DILocation(line: 0, scope: !150)
!253 = !DILocation(line: 265, column: 59, scope: !254)
!254 = distinct !DILexicalBlock(scope: !150, file: !3, line: 265, column: 8)
!255 = !DILocation(line: 265, column: 77, scope: !254)
!256 = !DILocation(line: 265, column: 8, scope: !150)
!257 = !DILocation(line: 275, column: 40, scope: !150)
!258 = !{!259, !216, i64 0}
!259 = !{!"auth_hdr", !216, i64 0, !215, i64 1, !215, i64 5, !260, i64 9, !260, i64 17, !260, i64 25, !260, i64 33, !215, i64 41, !215, i64 45, !260, i64 49}
!260 = !{!"long long", !216, i64 0}
!261 = !DILocation(line: 276, column: 12, scope: !150)
!262 = !DILocation(line: 276, column: 26, scope: !150)
!263 = !{!259, !215, i64 45}
!264 = !DILocation(line: 276, column: 56, scope: !150)
!265 = !DILocation(line: 276, column: 21, scope: !150)
!266 = !{!215, !215, i64 0}
!267 = !DILocation(line: 280, column: 15, scope: !150)
!268 = !DILocation(line: 282, column: 17, scope: !178)
!269 = !DILocation(line: 0, scope: !178)
!270 = !DILocation(line: 284, column: 3, scope: !178)
!271 = !DILocation(line: 284, column: 16, scope: !178)
!272 = !DILocation(line: 284, column: 12, scope: !178)
!273 = !DILocation(line: 285, column: 13, scope: !182)
!274 = !DILocation(line: 285, column: 13, scope: !178)
!275 = !DILocation(line: 286, column: 8, scope: !276)
!276 = distinct !DILexicalBlock(scope: !178, file: !3, line: 286, column: 6)
!277 = !DILocation(line: 286, column: 6, scope: !178)
!278 = !DILocation(line: 290, column: 14, scope: !279)
!279 = distinct !DILexicalBlock(scope: !276, file: !3, line: 289, column: 13)
!280 = !DILocalVariable(name: "iphdr", arg: 1, scope: !281, file: !282, line: 136, type: !109)
!281 = distinct !DISubprogram(name: "swap_src_dst_ipv4", scope: !282, file: !282, line: 136, type: !283, scopeLine: 137, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !285)
!282 = !DIFile(filename: "./../common/rewrite_helpers.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "75040841dc53cbf2ffc17c0802a4440a")
!283 = !DISubroutineType(types: !284)
!284 = !{null, !109}
!285 = !{!280, !286}
!286 = !DILocalVariable(name: "tmp", scope: !281, file: !282, line: 138, type: !131)
!287 = !DILocation(line: 0, scope: !281, inlinedAt: !288)
!288 = distinct !DILocation(line: 296, column: 7, scope: !178)
!289 = !DILocation(line: 138, column: 22, scope: !281, inlinedAt: !288)
!290 = !{!216, !216, i64 0}
!291 = !DILocation(line: 140, column: 24, scope: !281, inlinedAt: !288)
!292 = !DILocation(line: 140, column: 15, scope: !281, inlinedAt: !288)
!293 = !DILocation(line: 141, column: 15, scope: !281, inlinedAt: !288)
!294 = !DILocalVariable(name: "eth", arg: 1, scope: !295, file: !282, line: 113, type: !96)
!295 = distinct !DISubprogram(name: "swap_src_dst_mac", scope: !282, file: !282, line: 113, type: !296, scopeLine: 114, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !298)
!296 = !DISubroutineType(types: !297)
!297 = !{null, !96}
!298 = !{!294, !299}
!299 = !DILocalVariable(name: "h_tmp", scope: !295, file: !282, line: 115, type: !300)
!300 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, size: 48, elements: !102)
!301 = !DILocation(line: 0, scope: !295, inlinedAt: !302)
!302 = distinct !DILocation(line: 298, column: 7, scope: !178)
!303 = !DILocation(line: 115, column: 2, scope: !295, inlinedAt: !302)
!304 = !DILocation(line: 115, column: 7, scope: !295, inlinedAt: !302)
!305 = !DILocation(line: 117, column: 2, scope: !295, inlinedAt: !302)
!306 = !DILocation(line: 118, column: 2, scope: !295, inlinedAt: !302)
!307 = !DILocation(line: 119, column: 2, scope: !295, inlinedAt: !302)
!308 = !DILocation(line: 120, column: 1, scope: !295, inlinedAt: !302)
!309 = !DILocation(line: 300, column: 31, scope: !178)
!310 = !{!311, !235, i64 0}
!311 = !{!"udphdr", !235, i64 0, !235, i64 2, !235, i64 4, !235, i64 6}
!312 = !DILocation(line: 301, column: 28, scope: !178)
!313 = !{!311, !235, i64 2}
!314 = !DILocation(line: 301, column: 20, scope: !178)
!315 = !DILocation(line: 302, column: 18, scope: !178)
!316 = !DILocation(line: 307, column: 13, scope: !178)
!317 = !DILocation(line: 307, column: 19, scope: !178)
!318 = !{!311, !235, i64 6}
!319 = !DILocation(line: 310, column: 12, scope: !178)
!320 = !DILocation(line: 310, column: 18, scope: !178)
!321 = !{!244, !235, i64 10}
!322 = !DILocation(line: 311, column: 20, scope: !178)
!323 = !DILocation(line: 311, column: 18, scope: !178)
!324 = !DILocation(line: 313, column: 17, scope: !178)
!325 = !DILocation(line: 314, column: 20, scope: !178)
!326 = !DILocation(line: 314, column: 12, scope: !178)
!327 = !DILocation(line: 314, column: 18, scope: !178)
!328 = !{!259, !260, i64 49}
!329 = !DILocation(line: 317, column: 12, scope: !179)
!330 = !DILocation(line: 321, column: 17, scope: !189)
!331 = !DILocation(line: 0, scope: !189)
!332 = !DILocation(line: 322, column: 27, scope: !189)
!333 = !{!259, !215, i64 41}
!334 = !DILocation(line: 323, column: 28, scope: !189)
!335 = !DILocation(line: 325, column: 17, scope: !197)
!336 = !DILocation(line: 325, column: 16, scope: !189)
!337 = !DILocation(line: 327, column: 14, scope: !195)
!338 = !DILocation(line: 327, column: 14, scope: !196)
!339 = !DILocation(line: 328, column: 14, scope: !196)
!340 = !DILocation(line: 332, column: 22, scope: !203)
!341 = !DILocation(line: 332, column: 19, scope: !203)
!342 = !DILocation(line: 332, column: 16, scope: !189)
!343 = !DILocation(line: 334, column: 31, scope: !202)
!344 = !DILocation(line: 335, column: 36, scope: !202)
!345 = !DILocation(line: 335, column: 34, scope: !202)
!346 = !DILocation(line: 0, scope: !281, inlinedAt: !347)
!347 = distinct !DILocation(line: 340, column: 8, scope: !202)
!348 = !DILocation(line: 138, column: 22, scope: !281, inlinedAt: !347)
!349 = !DILocation(line: 140, column: 24, scope: !281, inlinedAt: !347)
!350 = !DILocation(line: 140, column: 15, scope: !281, inlinedAt: !347)
!351 = !DILocation(line: 141, column: 15, scope: !281, inlinedAt: !347)
!352 = !DILocation(line: 0, scope: !295, inlinedAt: !353)
!353 = distinct !DILocation(line: 342, column: 8, scope: !202)
!354 = !DILocation(line: 115, column: 2, scope: !295, inlinedAt: !353)
!355 = !DILocation(line: 115, column: 7, scope: !295, inlinedAt: !353)
!356 = !DILocation(line: 117, column: 2, scope: !295, inlinedAt: !353)
!357 = !DILocation(line: 118, column: 2, scope: !295, inlinedAt: !353)
!358 = !DILocation(line: 119, column: 2, scope: !295, inlinedAt: !353)
!359 = !DILocation(line: 120, column: 1, scope: !295, inlinedAt: !353)
!360 = !DILocation(line: 344, column: 32, scope: !202)
!361 = !DILocation(line: 0, scope: !202)
!362 = !DILocation(line: 345, column: 29, scope: !202)
!363 = !DILocation(line: 345, column: 21, scope: !202)
!364 = !DILocation(line: 346, column: 19, scope: !202)
!365 = !DILocation(line: 350, column: 14, scope: !202)
!366 = !DILocation(line: 350, column: 20, scope: !202)
!367 = !DILocation(line: 353, column: 13, scope: !202)
!368 = !DILocation(line: 353, column: 19, scope: !202)
!369 = !DILocation(line: 354, column: 21, scope: !202)
!370 = !DILocation(line: 354, column: 19, scope: !202)
!371 = !DILocation(line: 356, column: 18, scope: !202)
!372 = !DILocation(line: 357, column: 21, scope: !202)
!373 = !DILocation(line: 357, column: 13, scope: !202)
!374 = !DILocation(line: 357, column: 19, scope: !202)
!375 = !DILocation(line: 369, column: 9, scope: !151)
!376 = !DILocation(line: 363, column: 4, scope: !206)
!377 = !DILocation(line: 363, column: 4, scope: !207)
!378 = !DILocation(line: 378, column: 3, scope: !82)
!379 = !DILocation(line: 380, column: 1, scope: !82)
!380 = distinct !DISubprogram(name: "make_challenge_header", scope: !3, file: !3, line: 111, type: !381, scopeLine: 112, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !383)
!381 = !DISubroutineType(types: !382)
!382 = !{!163, !154}
!383 = !{!384, !385, !390, !391, !406, !407, !408, !409, !410, !411, !412, !419, !420, !421, !422, !423, !424, !425, !426, !427, !428, !429, !430, !431, !432, !433, !434, !435, !436, !437, !441}
!384 = !DILocalVariable(name: "payload", arg: 1, scope: !380, file: !3, line: 111, type: !154)
!385 = !DILocalVariable(name: "____fmt", scope: !386, file: !3, line: 113, type: !387)
!386 = distinct !DILexicalBlock(scope: !380, file: !3, line: 113, column: 2)
!387 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 368, elements: !388)
!388 = !{!389}
!389 = !DISubrange(count: 46)
!390 = !DILocalVariable(name: "id", scope: !380, file: !3, line: 115, type: !163)
!391 = !DILocalVariable(name: "rec", scope: !380, file: !3, line: 117, type: !392)
!392 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !393, size: 64)
!393 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "crPair", file: !394, line: 13, size: 640, elements: !395)
!394 = !DIFile(filename: "./common_kern_user.h", directory: "/home/netx3/xdp_experiments/xdp-tutorial/final_code_256", checksumkind: CSK_MD5, checksum: "ccc3620a97e58e3ebafe1a8241e2b384")
!395 = !{!396, !397, !398, !399, !400, !401, !402, !403, !404, !405}
!396 = !DIDerivedType(tag: DW_TAG_member, name: "ch1", scope: !393, file: !394, line: 14, baseType: !163, size: 32)
!397 = !DIDerivedType(tag: DW_TAG_member, name: "resp11", scope: !393, file: !394, line: 15, baseType: !167, size: 64, offset: 64)
!398 = !DIDerivedType(tag: DW_TAG_member, name: "resp12", scope: !393, file: !394, line: 16, baseType: !167, size: 64, offset: 128)
!399 = !DIDerivedType(tag: DW_TAG_member, name: "resp13", scope: !393, file: !394, line: 17, baseType: !167, size: 64, offset: 192)
!400 = !DIDerivedType(tag: DW_TAG_member, name: "resp14", scope: !393, file: !394, line: 18, baseType: !167, size: 64, offset: 256)
!401 = !DIDerivedType(tag: DW_TAG_member, name: "ch2", scope: !393, file: !394, line: 19, baseType: !163, size: 32, offset: 320)
!402 = !DIDerivedType(tag: DW_TAG_member, name: "resp21", scope: !393, file: !394, line: 20, baseType: !167, size: 64, offset: 384)
!403 = !DIDerivedType(tag: DW_TAG_member, name: "resp22", scope: !393, file: !394, line: 21, baseType: !167, size: 64, offset: 448)
!404 = !DIDerivedType(tag: DW_TAG_member, name: "resp23", scope: !393, file: !394, line: 22, baseType: !167, size: 64, offset: 512)
!405 = !DIDerivedType(tag: DW_TAG_member, name: "resp24", scope: !393, file: !394, line: 23, baseType: !167, size: 64, offset: 576)
!406 = !DILocalVariable(name: "RN", scope: !380, file: !3, line: 119, type: !167)
!407 = !DILocalVariable(name: "RN1", scope: !380, file: !3, line: 120, type: !167)
!408 = !DILocalVariable(name: "RN2", scope: !380, file: !3, line: 121, type: !167)
!409 = !DILocalVariable(name: "RN3", scope: !380, file: !3, line: 122, type: !167)
!410 = !DILocalVariable(name: "i", scope: !380, file: !3, line: 124, type: !20)
!411 = !DILocalVariable(name: "key", scope: !380, file: !3, line: 126, type: !20)
!412 = !DILocalVariable(name: "____fmt", scope: !413, file: !3, line: 132, type: !416)
!413 = distinct !DILexicalBlock(scope: !414, file: !3, line: 132, column: 10)
!414 = distinct !DILexicalBlock(scope: !415, file: !3, line: 131, column: 9)
!415 = distinct !DILexicalBlock(scope: !380, file: !3, line: 130, column: 13)
!416 = !DICompositeType(tag: DW_TAG_array_type, baseType: !22, size: 168, elements: !417)
!417 = !{!418}
!418 = !DISubrange(count: 21)
!419 = !DILocalVariable(name: "c1", scope: !380, file: !3, line: 136, type: !163)
!420 = !DILocalVariable(name: "c2", scope: !380, file: !3, line: 137, type: !163)
!421 = !DILocalVariable(name: "r11", scope: !380, file: !3, line: 138, type: !167)
!422 = !DILocalVariable(name: "r12", scope: !380, file: !3, line: 139, type: !167)
!423 = !DILocalVariable(name: "r13", scope: !380, file: !3, line: 140, type: !167)
!424 = !DILocalVariable(name: "r14", scope: !380, file: !3, line: 141, type: !167)
!425 = !DILocalVariable(name: "r21", scope: !380, file: !3, line: 142, type: !167)
!426 = !DILocalVariable(name: "r22", scope: !380, file: !3, line: 143, type: !167)
!427 = !DILocalVariable(name: "r23", scope: !380, file: !3, line: 144, type: !167)
!428 = !DILocalVariable(name: "r24", scope: !380, file: !3, line: 145, type: !167)
!429 = !DILocalVariable(name: "temp1", scope: !380, file: !3, line: 147, type: !167)
!430 = !DILocalVariable(name: "temp2", scope: !380, file: !3, line: 148, type: !167)
!431 = !DILocalVariable(name: "temp3", scope: !380, file: !3, line: 149, type: !167)
!432 = !DILocalVariable(name: "temp4", scope: !380, file: !3, line: 150, type: !167)
!433 = !DILocalVariable(name: "result1", scope: !380, file: !3, line: 151, type: !167)
!434 = !DILocalVariable(name: "result2", scope: !380, file: !3, line: 152, type: !167)
!435 = !DILocalVariable(name: "result3", scope: !380, file: !3, line: 153, type: !167)
!436 = !DILocalVariable(name: "result4", scope: !380, file: !3, line: 154, type: !167)
!437 = !DILocalVariable(name: "input_ints", scope: !380, file: !3, line: 169, type: !438)
!438 = !DICompositeType(tag: DW_TAG_array_type, baseType: !50, size: 768, elements: !439)
!439 = !{!440}
!440 = !DISubrange(count: 12)
!441 = !DILocalVariable(name: "hash", scope: !380, file: !3, line: 185, type: !163)
!442 = !DILocation(line: 85, column: 5, scope: !443, inlinedAt: !470)
!443 = distinct !DISubprogram(name: "computeHash", scope: !3, file: !3, line: 75, type: !444, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !447)
!444 = !DISubroutineType(types: !445)
!445 = !{!20, !446, !20}
!446 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!447 = !{!448, !449, !450, !452, !456, !458, !459, !461, !464, !466}
!448 = !DILocalVariable(name: "input_ints", arg: 1, scope: !443, file: !3, line: 75, type: !446)
!449 = !DILocalVariable(name: "num_ints", arg: 2, scope: !443, file: !3, line: 75, type: !20)
!450 = !DILocalVariable(name: "__vla_expr0", scope: !443, type: !451, flags: DIFlagArtificial)
!451 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!452 = !DILocalVariable(name: "buffer", scope: !443, file: !3, line: 85, type: !453)
!453 = !DICompositeType(tag: DW_TAG_array_type, baseType: !114, elements: !454)
!454 = !{!455}
!455 = !DISubrange(count: !450)
!456 = !DILocalVariable(name: "i", scope: !457, file: !3, line: 86, type: !20)
!457 = distinct !DILexicalBlock(scope: !443, file: !3, line: 86, column: 5)
!458 = !DILocalVariable(name: "crc", scope: !443, file: !3, line: 91, type: !20)
!459 = !DILocalVariable(name: "i", scope: !460, file: !3, line: 92, type: !20)
!460 = distinct !DILexicalBlock(scope: !443, file: !3, line: 92, column: 5)
!461 = !DILocalVariable(name: "index", scope: !462, file: !3, line: 94, type: !20)
!462 = distinct !DILexicalBlock(scope: !463, file: !3, line: 92, column: 48)
!463 = distinct !DILexicalBlock(scope: !460, file: !3, line: 92, column: 5)
!464 = !DILocalVariable(name: "rec", scope: !462, file: !3, line: 95, type: !465)
!465 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !62, size: 64)
!466 = !DILocalVariable(name: "____fmt", scope: !467, file: !3, line: 99, type: !416)
!467 = distinct !DILexicalBlock(scope: !468, file: !3, line: 99, column: 17)
!468 = distinct !DILexicalBlock(scope: !469, file: !3, line: 98, column: 9)
!469 = distinct !DILexicalBlock(scope: !462, file: !3, line: 97, column: 13)
!470 = distinct !DILocation(line: 185, column: 18, scope: !380)
!471 = !DILocation(line: 0, scope: !380)
!472 = !DILocation(line: 113, column: 2, scope: !386)
!473 = !DILocation(line: 113, column: 2, scope: !380)
!474 = !DILocation(line: 115, column: 16, scope: !380)
!475 = !DILocation(line: 119, column: 23, scope: !380)
!476 = !DILocation(line: 120, column: 24, scope: !380)
!477 = !DILocation(line: 121, column: 24, scope: !380)
!478 = !DILocation(line: 122, column: 24, scope: !380)
!479 = !DILocation(line: 124, column: 21, scope: !380)
!480 = !DILocation(line: 126, column: 9, scope: !380)
!481 = !DILocation(line: 126, column: 24, scope: !380)
!482 = !DILocation(line: 126, column: 35, scope: !380)
!483 = !DILocation(line: 126, column: 15, scope: !380)
!484 = !DILocation(line: 128, column: 8, scope: !380)
!485 = !DILocation(line: 130, column: 14, scope: !415)
!486 = !DILocation(line: 130, column: 13, scope: !380)
!487 = !DILocation(line: 132, column: 10, scope: !413)
!488 = !DILocation(line: 132, column: 10, scope: !414)
!489 = !DILocation(line: 133, column: 3, scope: !414)
!490 = !DILocation(line: 136, column: 26, scope: !380)
!491 = !{!492, !215, i64 0}
!492 = !{!"crPair", !215, i64 0, !260, i64 8, !260, i64 16, !260, i64 24, !260, i64 32, !215, i64 40, !260, i64 48, !260, i64 56, !260, i64 64, !260, i64 72}
!493 = !DILocation(line: 137, column: 26, scope: !380)
!494 = !{!492, !215, i64 40}
!495 = !DILocation(line: 138, column: 20, scope: !380)
!496 = !{!492, !260, i64 8}
!497 = !DILocation(line: 139, column: 27, scope: !380)
!498 = !{!492, !260, i64 16}
!499 = !DILocation(line: 140, column: 27, scope: !380)
!500 = !{!492, !260, i64 24}
!501 = !DILocation(line: 141, column: 27, scope: !380)
!502 = !{!492, !260, i64 32}
!503 = !DILocation(line: 142, column: 20, scope: !380)
!504 = !{!492, !260, i64 48}
!505 = !DILocation(line: 143, column: 23, scope: !380)
!506 = !{!492, !260, i64 56}
!507 = !DILocation(line: 144, column: 23, scope: !380)
!508 = !{!492, !260, i64 64}
!509 = !DILocation(line: 145, column: 23, scope: !380)
!510 = !{!492, !260, i64 72}
!511 = !DILocation(line: 147, column: 26, scope: !380)
!512 = !DILocation(line: 148, column: 26, scope: !380)
!513 = !DILocation(line: 149, column: 26, scope: !380)
!514 = !DILocation(line: 150, column: 26, scope: !380)
!515 = !DILocation(line: 160, column: 11, scope: !380)
!516 = !DILocation(line: 160, column: 19, scope: !380)
!517 = !DILocation(line: 161, column: 24, scope: !380)
!518 = !DILocation(line: 161, column: 11, scope: !380)
!519 = !DILocation(line: 161, column: 22, scope: !380)
!520 = !{!259, !215, i64 1}
!521 = !DILocation(line: 162, column: 24, scope: !380)
!522 = !DILocation(line: 162, column: 11, scope: !380)
!523 = !DILocation(line: 162, column: 22, scope: !380)
!524 = !{!259, !215, i64 5}
!525 = !DILocation(line: 163, column: 27, scope: !380)
!526 = !DILocation(line: 163, column: 11, scope: !380)
!527 = !DILocation(line: 163, column: 25, scope: !380)
!528 = !{!259, !260, i64 9}
!529 = !DILocation(line: 164, column: 30, scope: !380)
!530 = !DILocation(line: 164, column: 14, scope: !380)
!531 = !DILocation(line: 164, column: 28, scope: !380)
!532 = !{!259, !260, i64 17}
!533 = !DILocation(line: 165, column: 30, scope: !380)
!534 = !DILocation(line: 165, column: 14, scope: !380)
!535 = !DILocation(line: 165, column: 28, scope: !380)
!536 = !{!259, !260, i64 25}
!537 = !DILocation(line: 166, column: 30, scope: !380)
!538 = !DILocation(line: 166, column: 14, scope: !380)
!539 = !DILocation(line: 166, column: 28, scope: !380)
!540 = !{!259, !260, i64 33}
!541 = !DILocation(line: 167, column: 22, scope: !380)
!542 = !DILocation(line: 0, scope: !443, inlinedAt: !470)
!543 = !DILocation(line: 85, column: 10, scope: !443, inlinedAt: !470)
!544 = !DILocation(line: 0, scope: !457, inlinedAt: !470)
!545 = !DILocation(line: 87, column: 9, scope: !546, inlinedAt: !470)
!546 = distinct !DILexicalBlock(scope: !547, file: !3, line: 86, column: 42)
!547 = distinct !DILexicalBlock(scope: !457, file: !3, line: 86, column: 5)
!548 = !DILocation(line: 0, scope: !460, inlinedAt: !470)
!549 = !DILocation(line: 94, column: 2, scope: !462, inlinedAt: !470)
!550 = !DILocation(line: 94, column: 24, scope: !462, inlinedAt: !470)
!551 = !DILocation(line: 94, column: 35, scope: !462, inlinedAt: !470)
!552 = !DILocation(line: 0, scope: !462, inlinedAt: !470)
!553 = !DILocation(line: 94, column: 8, scope: !462, inlinedAt: !470)
!554 = !DILocation(line: 95, column: 20, scope: !462, inlinedAt: !470)
!555 = !DILocation(line: 97, column: 14, scope: !469, inlinedAt: !470)
!556 = !DILocation(line: 97, column: 13, scope: !462, inlinedAt: !470)
!557 = distinct !{!557, !558, !559, !560}
!558 = !DILocation(line: 92, column: 5, scope: !460, inlinedAt: !470)
!559 = !DILocation(line: 105, column: 5, scope: !460, inlinedAt: !470)
!560 = !{!"llvm.loop.mustprogress"}
!561 = !DILocation(line: 92, column: 25, scope: !463, inlinedAt: !470)
!562 = !DILocation(line: 99, column: 17, scope: !467, inlinedAt: !470)
!563 = !DILocation(line: 99, column: 17, scope: !468, inlinedAt: !470)
!564 = !DILocation(line: 105, column: 5, scope: !463, inlinedAt: !470)
!565 = !DILocation(line: 104, column: 13, scope: !462, inlinedAt: !470)
!566 = !DILocation(line: 104, column: 22, scope: !462, inlinedAt: !470)
!567 = !DILocation(line: 104, column: 19, scope: !462, inlinedAt: !470)
!568 = !DILocation(line: 92, column: 44, scope: !463, inlinedAt: !470)
!569 = !DILocation(line: 109, column: 1, scope: !443, inlinedAt: !470)
!570 = !DILocation(line: 193, column: 1, scope: !380)
!571 = distinct !DISubprogram(name: "ip_checksum", scope: !3, file: !3, line: 195, type: !572, scopeLine: 195, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !574)
!572 = !DISubroutineType(types: !573)
!573 = !{!19, !15, !7}
!574 = !{!575, !576, !577, !578}
!575 = !DILocalVariable(name: "vdata", arg: 1, scope: !571, file: !3, line: 195, type: !15)
!576 = !DILocalVariable(name: "length", arg: 2, scope: !571, file: !3, line: 195, type: !7)
!577 = !DILocalVariable(name: "data", scope: !571, file: !3, line: 197, type: !21)
!578 = !DILocalVariable(name: "sum", scope: !571, file: !3, line: 200, type: !7)
!579 = !DILocation(line: 0, scope: !571)
!580 = !DILocation(line: 204, column: 16, scope: !581)
!581 = distinct !DILexicalBlock(scope: !571, file: !3, line: 203, column: 24)
!582 = !{!235, !235, i64 0}
!583 = !DILocation(line: 205, column: 14, scope: !581)
!584 = !DILocation(line: 204, column: 13, scope: !581)
!585 = !DILocation(line: 215, column: 5, scope: !571)
!586 = !DILocation(line: 215, column: 16, scope: !571)
!587 = !DILocation(line: 216, column: 20, scope: !588)
!588 = distinct !DILexicalBlock(scope: !571, file: !3, line: 215, column: 23)
!589 = !DILocation(line: 216, column: 30, scope: !588)
!590 = distinct !{!590, !585, !591, !560}
!591 = !DILocation(line: 217, column: 5, scope: !571)
!592 = !DILocation(line: 220, column: 12, scope: !571)
!593 = !DILocation(line: 220, column: 5, scope: !571)
