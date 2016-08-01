//
//  NSObject+Keyboard.h
//  BiketoRabbit
//
//  Created by BIKETO on 16/4/14.
//  Copyright © 2016年 BIKETO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Keyboard)

- (void)registerForKeyboardNotifications;
- (void)removeKeyboardNotifications;
- (void)keyboardWasShown:(NSNotification*)aNotification;
- (void)keyboardWillBeHidden:(NSNotification*)aNotification;
- (void)didShowKeyboardAnimated:(BOOL)animated withHeight:(CGFloat)height;
- (void)didHideKeyboardAnimated:(BOOL)animated withHeight:(CGFloat)height;
- (CGFloat)getKeyboardHeightByNotification:(NSNotification *)notification;

@end
