//
//  ViewController.m
//  SpectrumTest
//
//  Created by 宋朝阳 on 2019/2/28.
//  Copyright © 2019年 song. All rights reserved.
//

#import "ViewController.h"
#import "Spectrum.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    Spectrum *spectrum = [Spectrum shareInstance];
    
    // 1.将UIImage编码为存储在给定targetUrl的图片格式
    [spectrum testSpectrumkitToTargetUrlWithImageName:@"" encodedImageFormatType:EncodedImageFormatTypeJPEG encodeRequirementMode:FSPEncodeRequirementModeLossless quality:100 targetUrl:@""];
    
    // 2.图像转码
    // 创建
    [spectrum testSpectrumkitToNSData];
    // 调整图像大小
    [spectrum testSpectrumkitToResizingImagesWithResizeRequirementMode:FSPResizeRequirementModeExact Size:CGSizeMake(100, 100)];
    // 裁剪图像
    [spectrum testSpectrumkitToCroppingImagesWithTopValue:5 leftValue:5 bottomValue:5 rightValue:5 enforcement:FSPCropRequirementEnforcementApproximate];
    // 旋转图像
    [spectrum testSpectrumkitToRotatingImagesWithDegrees:180 shouldFlipHorizontally:NO shouldFlipVertically:NO shouldForceUpOrientation:NO];
    // 编码图像
    [spectrum testSpectrumkitToEncodingImagesWithEncodedImageFormatType:EncodedImageFormatTypePNG encodeRequirementModeType:FSPEncodeRequirementModeLossless quality:-1];
    // 输入图片并获取最终样式图片
    [spectrum resultForImageWithImageName:@""];
    [spectrum resultForDataWithImageName:@""];
}

@end
