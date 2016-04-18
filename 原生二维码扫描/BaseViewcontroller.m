//
//  BaseViewcontroller.m
//  原生二维码扫描
//
//  Created by 蔡晓凡 on 16/4/18.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "BaseViewcontroller.h"

@interface BaseViewcontroller ()

@end

@implementation BaseViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self lnavBackItem];
}


- (void)lnavBackItem{
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
