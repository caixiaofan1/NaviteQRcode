//
//  CreateQRcodeView.m
//  原生二维码扫描
//
//  Created by 蔡晓凡 on 16/5/3.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "CreateQRcodeView.h"
#import "KMQRCode.h"
#import "UIImage+RoundedRectImage.h"
@interface CreateQRcodeView ()
{
    UIImageView *imageView;
}
@end

@implementation CreateQRcodeView

- (void)viewDidLoad {
    [super viewDidLoad];




}


- (IBAction)createQRcode:(UIButton *)sender {
    
    UIImage *image;
    if (self.textfield.text.length!=0) {
       image = [KMQRCode resizeQRCodeImage:self.textfield.text withSize:200];
    }else{
       image = [KMQRCode resizeQRCodeImage:@"http://www.baidu.com" withSize:200];
    }
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 200, 200)];
        imageView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    //改变二维码颜色
    UIImage *image1 = [KMQRCode specialColorImage:image withRed:237 green:114 blue:33];//(0~255)
    
    //添加中间小图片
    UIImage *image2 = [KMQRCode addIconToQRCodeImage:image1 withIcon:[UIImage imageNamed:@"1.png"] withIconSize:CGSizeMake(40, 40)];
    
    //设置圆角
    image2 = [UIImage createRoundedRectImage:image2 withSize:CGSizeMake(200, 200) withRadius:0];
        [imageView setImage:image2];
        [self.view addSubview:imageView];
        

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
     UITouch *touch = touches.anyObject;
    CGPoint p = [touch locationInView:imageView];
    
    if (CGRectContainsPoint(imageView.bounds, p)) {
        
        [imageView removeFromSuperview];
        imageView = nil;
    }
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
