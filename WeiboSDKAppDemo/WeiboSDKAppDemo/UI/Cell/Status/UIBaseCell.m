//
//  UIBaseCell.m
//  WeiboSDKAppDemo
//
//  Created by Peter on 13-12-2.
//  Copyright (c) 2013年 Peter. All rights reserved.
//

#import "UIBaseCell.h"
#import "UIDeviceCommon.h"

@implementation UIBaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([UIDeviceCommon isIOS7]) {
            self.backgroundColor = [UIColor clearColor];
        }
        self.backgroundView = [[UIImageView alloc] init];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


@end
