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

@interface ViewController ()

@property (nonatomic, strong) BTDataBaseManager *dataBsaeManager;
@property (nonatomic, strong) BTDataBase *dataBase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataBsaeManager = [BTDataBaseManager shareManager];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
