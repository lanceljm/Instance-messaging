//
//  SysButton.h
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SysButton : UIButton

@property (nonatomic, copy) ButtonClickWithSender btnClick;

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withBackgorundColor:(UIColor *)bgColor withCornerRadius:(CGFloat)corner withClickBlock:(ButtonClickWithSender)click;

@end
