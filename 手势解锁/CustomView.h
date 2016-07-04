//
//  CustomView.h
//  手势解锁
//
//  Created by apple2015 on 16/3/2.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView;
@protocol CustomViewDelegate <NSObject>

-(void)customView:(CustomView *)customView andWithPath:(NSString *)path;

@end

@interface CustomView : UIView
@property(nonatomic,strong) id<CustomViewDelegate> delegate;
@end
