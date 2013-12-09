//
//  CustomNavigationBar.h
//  Main
//
//  Created by qxxw_a_n on 13-9-16.
//  Copyright (c) 2013年 liu peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationBar : UIView
{
    UILabel *_titleLabel;
    UIImageView *_bgImageView;
    UIView *_lineView;
}

@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)UIButton *leftBtn;
@property (nonatomic, assign)UIButton *rightBtn;
@property (nonatomic, retain)UIImage *bgImage;
@property (nonatomic, retain)UIView *titleView;

- (void)HasUnderLine:(BOOL)has;

@end
