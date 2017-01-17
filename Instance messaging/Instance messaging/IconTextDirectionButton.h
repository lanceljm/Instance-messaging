//
//  IconTextDirectionButton.h
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Top,
    Bottom,
    Left,
    Right,
} IconDirection;

@interface IconTextDirectionButton : UIButton

@property (nonatomic, copy) ButtonClickWithSender btnClick;

-(instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag withText:(NSString *)text withTextColor:(UIColor *)color withTextFontSize:(CGFloat)fontSize withIconName:(NSString *)iconName withIconDirection:(IconDirection)dir withClickBlock:(ButtonClickWithSender)click;

@end
