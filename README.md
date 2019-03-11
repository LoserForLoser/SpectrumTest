# SpectrumTest
Spectrum 基础功能封装

```
typedef NS_ENUM(NSInteger, EncodedImageFormatType) {
    EncodedImageFormatTypeJPEG,
    EncodedImageFormatTypePNG,
    EncodedImageFormatTypeGIF,
    EncodedImageFormatTypeWEBP,
    EncodedImageFormatTypeHEIF
};

@interface Spectrum : NSObject

+ (instancetype)shareInstance;

#pragma mark - 1.将UIImage编码为存储在给定targetUrl的图片格式

/*
 * encodedImageFormatType需要转换的图片格式
 *
 * encodeRequirementMode图片清晰度 无损 有损 任意
 *
 * quality小于0视为传空
 *
 * targetUrlString指定的URL
 */
- (FSPResult *)testSpectrumkitToTargetUrlWithImageName:(NSString *)imageName
                                encodedImageFormatType:(EncodedImageFormatType)encodedImageFormatType
                                 encodeRequirementMode:(FSPEncodeRequirementMode)encodeRequirementMode
                                               quality:(NSInteger)quality
                                             targetUrl:(NSString *)targetUrlString;

#pragma mark - 2.图像转码

/*
 * 创建
 */
- (void)testSpectrumkitToNSData;

/*
 * 调整图像大小
 *
 * resizeRequirementMode调整需求模式 精确 精确或更小 精确或更大
 *
 * targetSize图片尺寸
 */
- (void)testSpectrumkitToResizingImagesWithResizeRequirementMode:(FSPResizeRequirementMode)resizeRequirementMode
                                                            Size:(CGSize)targetSize;

/*
 * 裁剪图像
 *
 * 上左下右裁剪范围值
 *
 * enforcement执行精准度 准确 近似
 */
- (void)testSpectrumkitToCroppingImagesWithTopValue:(float)topvalue
                                          leftValue:(float)leftValue
                                        bottomValue:(float)bottomValue
                                         rightValue:(float)rightValue
                                        enforcement:(FSPCropRequirementEnforcement)enforcement;

/*
 * 旋转图像
 *
 * rotationDegrees旋转角度
 *
 * shouldFlipHorizontally水平旋转
 *
 * shouldFlipVertically垂直旋转
 *
 * shouldForceUpOrientation强制向上定向
 */
- (void)testSpectrumkitToRotatingImagesWithDegrees:(NSInteger)rotationDegrees
                            shouldFlipHorizontally:(BOOL)shouldFlipHorizontally
                              shouldFlipVertically:(BOOL)shouldFlipVertically
                          shouldForceUpOrientation:(BOOL)shouldForceUpOrientation;

/* 编码图像
 *
 * encodedImageFormatType需要转换的图片格式
 *
 * EncodeRequirementModeType图片清晰度，为 无损 有损 任意
 *
 * quality小于0视为传空
 */
- (void)testSpectrumkitToEncodingImagesWithEncodedImageFormatType:(EncodedImageFormatType)encodedImageFormatType
                                        encodeRequirementModeType:(FSPEncodeRequirementMode)encodeRequirementModeType
                                                          quality:(NSInteger)quality;

// 输入图片并获取最终样式图片
- (UIImage *)resultForImageWithImageName:(NSString *)imageName;
- (NSData *)resultForDataWithImageName:(NSString *)imageName;

@end
```
