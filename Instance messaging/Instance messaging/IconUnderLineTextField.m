//
//  IconUnderLineTextField.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "IconUnderLineTextField.h"

@interface IconUnderLineTextField()<UITextFieldDelegate>

@end

@implementation IconUnderLineTextField

-(instancetype)initWithFrame:(CGRect)frame withIconName:(NSString *)iconName withPlaceholder:(NSString *)placeholder{
    self = [super initWithFrame:frame];
    if (self) {
        //子类改造
        UIImageView *iconImg = [[UIImageView alloc] initWithFrame:AAdaptionRect(-(26+62), 0, 62, 62)];
        [iconImg setImage:[UIImage imageNamed:iconName]];
        [self addSubview:iconImg];
        
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:AAdaptionRect(0, self.frame.size.height/AAdaptionWidth() - 2 , self.frame.size.width/AAdaptionWidth(), 2)];
        lineLabel.backgroundColor = MainThemeColor;
        [self addSubview:lineLabel];
        
        self.placeholder = placeholder;
        self.delegate = self;
    }
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}           // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0){
    
} // if implemented, called in place of textFieldDidEndEditing:

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}              // called when 'return' key pressed. return NO to ignore.



@end
