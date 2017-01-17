//
//  SysButton.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "SysButton.h"

@implementation SysButton

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withBackgorundColor:(UIColor *)bgColor withCornerRadius:(CGFloat)corner withClickBlock:(ButtonClickWithSender)click{
    //corner 参数是一个比例值，0 到 1/2 范围内；
    
    self = [super initWithFrame:frame];
    if (self) {
        //改造
        if (click) {
            self.btnClick = click; //把参数代码块传给我们的属性Block;
            [self addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        }
        self.tag = tag;
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundColor:bgColor];
        self.layer.cornerRadius = self.frame.size.height * corner;
    }
    return self;
}

-(void)btnTouchUpInside:(UIButton *)sender{
    
    self.btnClick(sender);
    //    self.btnClick(self);
}


@end
