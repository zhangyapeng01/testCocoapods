//
//  LoadingView.h
//  Test
//
//  Created by zhangyapeng on 16/7/7.
//  Copyright © 2016年 zhangyapeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
    NSTimer* timer;
    CGFloat startA;
    CGFloat endA;
    
    
}
- (void)startLoading;
- (void)cancelLoading;


@end
