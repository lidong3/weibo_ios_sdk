//
//  CommentPopView.h
//  Main
//
//  Created by qxxw_a_n on 13-10-12.
//  Copyright (c) 2013年 liu peng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentPopViewDelegate <NSObject>
@optional
- (void)blessCardLeftEvent;
- (void)blessCardRightEvent:(NSString *)message;
@end

@interface CommentPopView : UIView <UITextViewDelegate>
{
    UIImageView *_bgImageView;
    UILabel *_titleLabel;
    UIView *_lineView;
    UILabel *_limitLabel;
    UIButton *_leftBtn;
    UIButton *_rightBtn;
}

@property (nonatomic, retain)UITextView *blessTextView;
@property (nonatomic, assign)id <CommentPopViewDelegate> delegate;

@end
