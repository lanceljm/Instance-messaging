//
//  IconTextDirectionButton.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "IconTextDirectionButton.h"

@implementation IconTextDirectionButton

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withText:(NSString *)text withTextColor:(UIColor *)color withTextFontSize:(CGFloat)fontSize withIconName:(NSString *)iconName withIconDirection:(IconDirection)dir withClickBlock:(ButtonClickWithSender)click{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        if (click) {
            self.btnClick = click;
            [self addTarget:self action:@selector(btnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
        }
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        self.titleLabel.font = AAFont(fontSize);
        
        //可能是因为在设置背景颜色的时候，他自己会调节改变自己的各个控件的尺寸
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        
        CGFloat titleW = self.titleLabel.frame.size.width;
        CGFloat titleH = self.titleLabel.frame.size.height;
        
        CGFloat spaceW = self.frame.size.width - titleW - self.imageView.frame.size.width;
        
        CGFloat spaceH = (self.frame.size.height - titleH - self.imageView.frame.size.height)/4;
        
        //根据方向枚举值，处理具体的偏移
        
        //如果要左右居中，不需要考虑左右之间的间隙，因为默认左右之间的间隙是平均分配的，所以：1.图片左右居中，只需要考虑文本宽度，左右各一半；2.文本居中，只需要考虑图片宽度左右各一半。
        
        switch (dir) {
            case Top:
            {
                self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.frame.size.height*0.5-spaceH, self.titleLabel.frame.size.width*0.5, self.titleLabel.frame.size.height*0.5+spaceH, -self.titleLabel.frame.size.width*0.5);
                self.titleEdgeInsets = UIEdgeInsetsMake(self.imageView.frame.size.height*0.5+spaceH, -self.imageView.frame.size.width*0.5, -self.imageView.frame.size.height*0.5-spaceH, self.imageView.frame.size.width*0.5);
            }
                break;
            case Bottom:
            {
                self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.frame.size.height, self.titleLabel.frame.size.width*0.5, -self.titleLabel.frame.size.height, -self.titleLabel.frame.size.width*0.5);
                self.titleEdgeInsets = UIEdgeInsetsMake(-self.imageView.frame.size.height, -self.imageView.frame.size.width*0.5, self.imageView.frame.size.height, self.imageView.frame.size.width*0.5);
            }
                break;
            case Left:
            {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -spaceW, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spaceW, 0, 0);
            }
                break;
            case Right:
            {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, self.frame.size.width - self.imageView.frame.size.width, 0, 0);
                //因为一开始，文本的偏移量比图片多了刚好一个图片的宽度
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(self.frame.size.width - self.titleLabel.frame.size.width + self.imageView.frame.size.width), 0, 0);
            }
                break;
            default:
                break;
        }
    }
    return self;
}

-(void)btnTouchUpInside{
    self.btnClick(self);
}


@end
