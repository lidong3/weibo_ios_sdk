//
//  UICommon-Button.m
//  UICommonLib
//
//  Created by Peter on 13-5-30.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UICommonCategory.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Scaling.h"

@implementation UIButton (UICommon)

+ (UIButton *)getButtonNormalImage:(NSString *)bgNormalName
                   hightImageName:(NSString *)bgHeightName
                          selector:(SEL)selector
                            target:(id)target
                           supview:(UIView *)superView
{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (bgNormalName) {
        UIImage *bgNormalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgNormalName]];
        [tempBtn setBackgroundImage:bgNormalImage forState:UIControlStateNormal];
    }
    if (bgHeightName){
        UIImage *bgHeightImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgHeightName]];
        [tempBtn setBackgroundImage:bgHeightImage forState:UIControlStateHighlighted];
    }
    
    [tempBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:tempBtn];
    return tempBtn;
}

+ (UIButton *)getStretchButtonNormalImage:(NSString *)bgNormalName
                           hightImageName:(NSString *)bgHeightName
                                 selector:(SEL)selector
                                   target:(id)target
                                  supview:(UIView *)superView
{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (bgNormalName) {
        UIImage *bgNormalImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgNormalName]] scaledImageStretchableImage];
        [tempBtn setBackgroundImage:bgNormalImage forState:UIControlStateNormal];
    }
    if (bgHeightName){
        UIImage *bgHeightImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgHeightName]] scaledImageStretchableImage];
        [tempBtn setBackgroundImage:bgHeightImage forState:UIControlStateHighlighted];
    }
    
    [tempBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:tempBtn];
    return tempBtn;
}

+ (UIButton *)getButtonNormalImage:(NSString *)bgNormalName
                   hightImageName:(NSString *)bgHeightName
                   selectImageName:(NSString *)selectImageName
                          selector:(SEL)selector
                            target:(id)target
                           supview:(UIView *)superView
{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (bgNormalName) {
        UIImage *bgNormalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgNormalName]];
        [tempBtn setBackgroundImage:bgNormalImage forState:UIControlStateNormal];
    }
    if (bgHeightName){
        UIImage *bgHeightImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",bgHeightName]];
        [tempBtn setBackgroundImage:bgHeightImage forState:UIControlStateHighlighted];
    }
    if (selectImageName){
        UIImage *bgSelectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",selectImageName]];
        [tempBtn setBackgroundImage:bgSelectImage forState:UIControlStateSelected];
    }
    
    [tempBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:tempBtn];
    return tempBtn;
}

@end


@implementation UILabel (UICommon)

+ (UILabel *)getLabelWithFontSize:(CGFloat)fontSize
                  backgroundColor:(UIColor *)color
                        textColor:(UIColor *)textColor
                        superView:(UIView *)superView
{
    UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(50, 56, 70, 17)];
    Label.font = [UIFont systemFontOfSize:fontSize];
    Label.backgroundColor = color;
    Label.textColor = textColor;
    [superView addSubview:Label];
    return Label;
}

@end

@implementation UIImageView (UICommon)

+ (UIImageView *)getImageViewWithImage:(UIImage *)image
                             highImage:(UIImage *)highImage
                             superView:(UIView *)superView
{
    UIImageView *imageView = nil;
    if (highImage) {
        imageView = [[UIImageView alloc] initWithImage:image highlightedImage:highImage];
    }else{
        imageView = [[UIImageView alloc] initWithImage:image];
    }
    [superView addSubview:imageView];
    return imageView;
}

+ (UIImageView *)getCornerImageViewWithImage:(UIImage *)image
                                   highImage:(UIImage *)highImage
                                   superView:(UIView *)superView
                                cornerRadius:(float)rate
{
    UIImageView *imageView = nil;
    if (highImage) {
        imageView = [[UIImageView alloc] initWithImage:image highlightedImage:highImage];
    }else{
        imageView = [[UIImageView alloc] initWithImage:image];
    }
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = rate;
    [superView addSubview:imageView];
    return imageView;
}

+ (UIImageView *)getImageWithFrame:(CGRect)rect
                         superView:(UIView *)superView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [superView addSubview:imageView];
    return imageView;
}

@end




