//
//  UIImage+Scaling.h
//  testLib
//
//  Created by Peter on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scaling)

- (UIImage *)getThumbImage;
// 缩放
- (UIImage *)scaledImageWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;
- (UIImage *)scaledHeadImageWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;
- (UIImage *)scaledImage:(CGFloat)scale;
- (UIImage *)scaledImageBasedIPhoneSizeWithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;

// 拉伸

- (UIImage *)scaledImageStretchableImage;

- (UIImage *)scaledImageStretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

//发送图片压缩算法
- (NSData *)compressImage:(CGFloat)aQuality;

- (UIImage *)scaledImageV2WithWidth:(CGFloat)aWidth andHeight:(CGFloat)aHeight;

//截取图片的某一部分
- (UIImage *)clipImageInRect:(CGRect)rect;



@end
