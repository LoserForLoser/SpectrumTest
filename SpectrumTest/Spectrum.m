//
//  Spectrum.m
//  SpectrumTest
//
//  Created by 宋朝阳 on 2019/3/1.
//  Copyright © 2019年 song. All rights reserved.
//

#import "Spectrum.h"

@interface Spectrum ()

@property (nonatomic, strong) FSPTransformations *transformations;
@property (nonatomic, strong) FSPEncodeRequirement *encodeRequirement;

@end

@implementation Spectrum

static Spectrum *_spectrum = nil;

+ (instancetype)shareInstance {
    if (_spectrum == nil) {
        _spectrum = [[Spectrum alloc] init];
    }
    return _spectrum;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _spectrum = [super allocWithZone:zone];
    });
    return _spectrum;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - Spectrum 将UIImage编码为存储在给定targetUrl的图片格式

// 以下代码将UIImage编码为存储在给定targetUrl的JPEG
- (FSPResult *)testSpectrumkitToTargetUrlWithImageName:(NSString *)imageName
                                encodedImageFormatType:(EncodedImageFormatType)encodedImageFormatType
                                 encodeRequirementMode:(FSPEncodeRequirementMode)encodeRequirementMode
                                               quality:(NSInteger)quality
                                             targetUrl:(NSString *)targetUrlString {
//    UIImage *image = [UIImage imageNamed:@"IMG_1"];
    UIImage *image = [UIImage imageNamed:imageName];
    NSURL *targetUrl = [NSURL URLWithString:targetUrlString];
    NSError *error;
    
    FSPEncodeRequirement *encodeRequirement;
    if (quality < 0) {
        encodeRequirement =
        [FSPEncodeRequirement encodeRequirementWithFormat:[self encodedImageFormatWithEncodedImageFormatType:encodedImageFormatType]
                                                     mode:encodeRequirementMode];
    } else {
        encodeRequirement =
        [FSPEncodeRequirement encodeRequirementWithFormat:[self encodedImageFormatWithEncodedImageFormatType:encodedImageFormatType]
                                                     mode:encodeRequirementMode
                                                  quality:quality];
    }
    
    FSPEncodeOptions *options =
    [FSPEncodeOptions encodeOptionsWithEncodeRequirement:encodeRequirement
                                         transformations:nil
                                                metadata:nil
                                           configuration:nil
                     outputPixelSpecificationRequirement:nil];
    
    FSPResult *result = [FSPSpectrum.sharedInstance encodeImage:image
                                                    toFileAtURL:targetUrl
                                                        options:options
                                                          error:&error];
    
    return result;
}

#pragma mark - Spectrum 图像的转码

// 用于上传的图像的转码
// 下面是将UIImage编码为NSData的示例.
- (void)testSpectrumkitToNSData {
    self.transformations = [FSPTransformations new];
    
}

// 调整图片大小
- (void)testSpectrumkitToResizingImagesWithResizeRequirementMode:(FSPResizeRequirementMode)resizeRequirementMode
                                                            Size:(CGSize)targetSize {
    // 将调整大小要求传递给选项
    
    self.transformations.resizeRequirement =
    [[FSPResizeRequirement alloc] initWithMode:resizeRequirementMode
                                    targetSize:targetSize];
}

// 裁剪图像
- (void)testSpectrumkitToCroppingImagesWithTopValue:(float)topvalue
                                          leftValue:(float)leftValue
                                        bottomValue:(float)bottomValue
                                         rightValue:(float)rightValue
                                        enforcement:(FSPCropRequirementEnforcement)enforcement {
    // 将裁剪要求传递给选项的转换
    FSPRelativeToOriginCropRequirementValues values = {
        .top = topvalue,
        .left = leftValue,
        .bottom = bottomValue,
        .right = rightValue,
    };
    self.transformations.cropRequirement =
    [FSPRelativeToOriginCropRequirement relativeToOriginCropRequirementWithValues:values enforcement:enforcement];
}

// 旋转图像
- (void)testSpectrumkitToRotatingImagesWithDegrees:(NSInteger)rotationDegrees
                            shouldFlipHorizontally:(BOOL)shouldFlipHorizontally
                              shouldFlipVertically:(BOOL)shouldFlipVertically
                          shouldForceUpOrientation:(BOOL)shouldForceUpOrientation {
    // 将裁剪要求传递给选项的转换
    self.transformations.rotateRequirement = [FSPRotateRequirement
                                              rotateRequirementWithDegrees:rotationDegrees
                                              shouldFlipHorizontally:shouldFlipHorizontally
                                              shouldFlipVertically:shouldFlipVertically
                                              shouldForceUpOrientation:shouldForceUpOrientation];
}

// 编码图像
- (void)testSpectrumkitToEncodingImagesWithEncodedImageFormatType:(EncodedImageFormatType)encodedImageFormatType
                                    encodeRequirementModeType:(FSPEncodeRequirementMode)encodeRequirementModeType
                                                      quality:(NSInteger)quality {
    // 将编码要求传递给选项
    if (quality < 0) {
        self.encodeRequirement =
        [FSPEncodeRequirement encodeRequirementWithFormat:[self encodedImageFormatWithEncodedImageFormatType:encodedImageFormatType]
                                                     mode:encodeRequirementModeType];
    } else {
        self.encodeRequirement =
        [FSPEncodeRequirement encodeRequirementWithFormat:[self encodedImageFormatWithEncodedImageFormatType:encodedImageFormatType]
                                                     mode:encodeRequirementModeType
                                                  quality:quality];
    }
}

// 获取最终样式图片(Image)
- (UIImage *)resultForImageWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    FSPEncodeOptions *options =
    [FSPEncodeOptions encodeOptionsWithEncodeRequirement:self.encodeRequirement
                                         transformations:self.transformations
                                                metadata:nil
                                           configuration:nil
                     outputPixelSpecificationRequirement:nil];
    
    NSError *error;
    FSPResultData *resultData = [FSPSpectrum.sharedInstance encodeImage:image options:options error:&error];
    return [UIImage imageWithData:resultData.data];
}

// 获取最终样式图片(Data)
- (NSData *)resultForDataWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    FSPEncodeOptions *options =
    [FSPEncodeOptions encodeOptionsWithEncodeRequirement:self.encodeRequirement
                                         transformations:self.transformations
                                                metadata:nil
                                           configuration:nil
                     outputPixelSpecificationRequirement:nil];
    
    NSError *error;
    FSPResultData *resultData = [FSPSpectrum.sharedInstance encodeImage:image options:options error:&error];
    return resultData.data;
}

#pragma mark - public

- (FSPEncodedImageFormat *)encodedImageFormatWithEncodedImageFormatType:(EncodedImageFormatType)encodedImageFormatType {
    FSPEncodedImageFormat *imageFormate;
    switch (encodedImageFormatType) {
        case EncodedImageFormatTypeJPEG:
            imageFormate = FSPEncodedImageFormat.jpeg;
            break;
        case EncodedImageFormatTypePNG:
            imageFormate = FSPEncodedImageFormat.png;
            break;
        case EncodedImageFormatTypeGIF:
            imageFormate = FSPEncodedImageFormat.gif;
            break;
        case EncodedImageFormatTypeWEBP:
            imageFormate = FSPEncodedImageFormat.webp;
            break;
        case EncodedImageFormatTypeHEIF:
            imageFormate = FSPEncodedImageFormat.heif;
            break;
            
        default:
            break;
    }
    return imageFormate;
}

@end
