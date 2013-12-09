//
//  UICommon-Button.h
//  UICommonLib
//
//  Created by peter on 13-5-30.
//  Copyright (c) 2013年 zhang yinglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//（注释：UI类的扩展方法）

@interface UIButton (UICommon)

+ (UIButton *)getButtonNormalImage:(NSString *)bgNormalName
                    hightImageName:(NSString *)bgHeightName
                          selector:(SEL)selector
                            target:(id)target
                           supview:(UIView *)superView;

+ (UIButton *)getStretchButtonNormalImage:(NSString *)bgNormalName
                           hightImageName:(NSString *)bgHeightName
                                 selector:(SEL)selector
                                   target:(id)target
                                  supview:(UIView *)superView;

+ (UIButton *)getButtonNormalImage:(NSString *)bgNormalName
                   hightImageName:(NSString *)bgHeightName
                   selectImageName:(NSString *)selectImageName
                          selector:(SEL)selector
                            target:(id)target
                           supview:(UIView *)superView;

@end


@interface UILabel (UICommon)

+ (UILabel *)getLabelWithFontSize:(CGFloat)fontSize
                  backgroundColor:(UIColor *)color
                        textColor:(UIColor *)textColor
                        superView:(UIView *)superView;

@end

@interface UIImageView (UICommon)

+ (UIImageView *)getImageViewWithImage:(UIImage *)image
                             highImage:(UIImage *)highImage
                             superView:(UIView *)superView;

//圆角
+ (UIImageView *)getCornerImageViewWithImage:(UIImage *)image
                                   highImage:(UIImage *)highImage
                                   superView:(UIView *)superView
                                cornerRadius:(float)rate;

+ (UIImageView *)getImageWithFrame:(CGRect)rect
                         superView:(UIView *)superView;

@end



