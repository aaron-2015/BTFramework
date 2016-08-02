//
//  ViewController.m
//  BTFramework
//
//  Created by aaron on 16/7/27.
//  Copyright © 2016年 aaron. All rights reserved.
//

#import "ViewController.h"
#import "BTDataBaseManager.h"
#import "BTDataBase.h"
#import "BTDataBaseCurrUserInfo.h"

@interface ViewController ()

@property (nonatomic, strong) BTDataBaseManager *dataBsaeManager;
@property (nonatomic, strong) BTDataBase *dataBase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataBsaeManager = [BTDataBaseManager shareManager];
    
    BTDataBaseCurrUserInfo *curUserInfo = [[BTDataBaseCurrUserInfo alloc] init];
    curUserInfo.user_id = @"100002";
    curUserInfo.user_follows = 1;
    curUserInfo.user_fans = 2;
    curUserInfo.userYear = @"2018";
    
    [_dataBsaeManager saveCurrUserInfo:curUserInfo];
    
    
    BTDataBaseCurrUserInfo *curUserInfo2 = [_dataBsaeManager getCurrUserInfoWithUserID:@"100001"];
    
//    [_dataBsaeManager deleteCurrUserInfoWithUserID:@"100001"];
    
    
    NSLog(@"%@",curUserInfo2.userYear);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
