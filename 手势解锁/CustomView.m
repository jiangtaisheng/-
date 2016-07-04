//
//  CustomView.m
//  手势解锁
//
//  Created by apple2015 on 16/3/2.
//  Copyright © 2016年 apple2015. All rights reserved.
//

#import "CustomView.h"


@interface CustomView ()
@property(nonatomic,strong ) NSMutableArray * selectedButton;
@property(nonatomic,assign) CGPoint  currenPoint;
@end


@implementation CustomView


-(NSMutableArray *)selectedButton
{

    if (_selectedButton==nil) {
        
        _selectedButton=[NSMutableArray array];
    }

    return _selectedButton;
}

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        
        [self configUI];
    }

    return self;
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
 
    if (self=[super initWithCoder:aDecoder]) {
        [self configUI];
    }
 
    return self;
}
-(void)configUI
{


    for (int index = 0; index<9; index++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.userInteractionEnabled = NO;
        btn.tag=index;
//        btn.backgroundColor = [UIColor blueColor];
        
        // 设置默认的背景图片
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        // 设置选中时的背景图片(selected)
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        // 添加按钮
        [self addSubview:btn];


}

}

-(void)layoutSubviews
{

    [super layoutSubviews];
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 取出按钮
        UIButton *btn = self.subviews[index];
        
        // 设置frame
        CGFloat btnW = 74;
        CGFloat btnH = 74;
        
        int totalColumns = 3;
        int col = index % totalColumns;
        int row = index / totalColumns;
        CGFloat marginX = (self.frame.size.width - totalColumns * btnW) / (totalColumns + 1);
        CGFloat marginY = marginX;
        
        CGFloat btnX = marginX + col * (btnW + marginX);
        CGFloat btnY = row * (btnH + marginY)+10;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }



}

//找到点击point
-(CGPoint)pointWithtouchs:(NSSet*)touches
{

    
    UITouch * touch=[touches anyObject];
    
    CGPoint pos=[touch locationInView:touch.view];
    
    return pos;

}
// 找到触摸的btn

-(UIButton *)buttonWithPoint:(CGPoint)point
{

    for (UIButton * btn in self.subviews) {
        
        if (CGRectContainsPoint(btn.frame, point)) {
            
            return btn;
            
        }
        
    }


    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

   
    self.currenPoint=CGPointZero;
    
    CGPoint pos=[self pointWithtouchs:touches];
    
    UIButton * btn=[self buttonWithPoint:pos];
    
    if (btn&&btn.selected==NO) {
        
        btn.selected=YES;
        
        [self.selectedButton addObject:btn];
    }else{
    
        self.currenPoint=pos;
    
    }
    
   
    
     [self setNeedsDisplay];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    CGPoint pos=[self pointWithtouchs:touches];
    
    UIButton * btn=[self buttonWithPoint:pos];
    
    if (btn&&btn.selected==NO) {
        
        btn.selected=YES;
        
        [self.selectedButton addObject:btn];
    }
    else{
    
        self.currenPoint=pos;
    
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if (_delegate&&[_delegate respondsToSelector:@selector(customView:andWithPath:)]) {
        
        NSMutableString * path=[NSMutableString string];
        for (UIButton * btn in self.selectedButton) {
            
            [path appendFormat:@"%li",btn.tag];
            
        }
        [_delegate customView:self andWithPath:path];
    }
    
    
    for (UIButton * btn in self.subviews) {
        
        btn.selected=NO;
        
    }
    
    [self.selectedButton removeAllObjects];
    
    [self setNeedsDisplay];
    
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self touchesEnded:touches withEvent:event];

}

-(void)drawRect:(CGRect)rect
{
    if (self.selectedButton.count==0) {
        return;
    }
    
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    for (int i=0; i<self.selectedButton.count; i++) {
        UIButton * btn=self.selectedButton[i];
        if (i==0) {
            
            [path moveToPoint:btn.center];
            
        }
        else{
        
            [path addLineToPoint:btn.center];
        
        }
        
    }

    if (CGPointEqualToPoint(self.currenPoint, CGPointZero)==NO) {
        [path addLineToPoint:self.currenPoint];
    }
    
    path.lineWidth=3;
    path.lineJoinStyle=kCGLineJoinRound;
    [[UIColor redColor]set];
    [path stroke];


}


@end
