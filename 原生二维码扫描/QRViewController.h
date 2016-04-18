//
//  QRViewController.h
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/23.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewcontroller.h"
@interface QRViewController : BaseViewcontroller
//@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
//@property (strong, nonatomic) CALayer *scanLayer;
-(void)startReading;
-(void)stopReading;
@end
