//
//  NSObject+Keyboard.m
//  BiketoRabbit
//
//  Created by BIKETO on 16/4/14.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import "NSObject+Keyboard.h"

@implementation NSObject (Keyboard)

#pragma mark - Regist KeyBoard Notification
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤将要出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (CGFloat)getKeyboardHeightByNotification:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    return kbSize.height;
    //kbSize即為鍵盤尺寸 (有width, height)
    //    CGFloat keyboardheight = 0;
    //    NSLog(@"hight_hitht:%f",kbSize.height);
    //    if(kbSize.height == 216)
    //    {
    //        keyboardheight = 0;
    //    }
    //    else if (kbSize.height == 225)
    //    {
    //        keyboardheight = 9;
    //    }
    //    else
    //    {
    //        keyboardheight = 36;   //252 - 216 系统键盘的两个不同高度
    //    }
    //    return keyboardheight + Keyboard_Height;
}

- (void)keyboardWillShown:(NSNotification *)aNotification
{
    [self didShowKeyboardAnimated:YES withHeight:[self getKeyboardHeightByNotification:aNotification]];
}

- (void)keyboardWasShown:(NSNotification *)aNotification
{
    //    [self didShowKeyboardAnimated:YES withHeight:[self getKeyboardHeightByNotification:aNotification]];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    [self didHideKeyboardAnimated:YES withHeight:[self getKeyboardHeightByNotification:aNotification]];
}

- (void)didShowKeyboardAnimated:(BOOL)animated withHeight:(CGFloat)height
{
    
}

- (void)didHideKeyboardAnimated:(BOOL)animated withHeight:(CGFloat)height
{
    
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
