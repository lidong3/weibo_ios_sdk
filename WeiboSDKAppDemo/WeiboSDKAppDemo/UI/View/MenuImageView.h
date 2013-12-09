//
//  MenuImageView.h
//  RCS
//
//  Created by qxxw_a_n on 13-9-22.
//  Copyright (c) 2013年 feinno. All rights reserved.
//

#import "MenuImageViewDelegate.h"

@interface MenuImageView : UIImageView <MenuImageViewDelegate>
{
    NSMutableArray *_menuItems;
    UIMenuController *menuController;
}

@property (nonatomic, assign)id <MenuImageViewDelegate> delegate;

- (void)addMenuItemByID:(NSString *)ID;

@end
