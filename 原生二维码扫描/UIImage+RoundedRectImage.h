//
//  UIImage+RoundedRectImage.h
//  原生二维码扫描
//
//  Created by 蔡晓凡 on 16/5/3.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedRectImage)
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;
@end
