//
//  QRViewController.m
//  原生二维码扫描
//
//  Created by tcyf-2 on 16/3/23.
//  Copyright © 2016年 tcyf-2. All rights reserved.
//

#import "QRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WebviewController.h"
#import "LayerView.h"
@interface QRViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIButton *selectBtn;
}
@property ( strong , nonatomic ) AVCaptureDevice * device;
@property ( strong , nonatomic ) AVCaptureDeviceInput * input;
@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;
@property ( strong , nonatomic ) AVCaptureSession * captureSession;
@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * videoPreviewLayer;
@property ( strong , nonatomic ) LayerView *viewPreview;
@property ( strong , nonatomic ) UILabel *lblStatus;
@end

@implementation QRViewController
- (void)startReading {
    NSError *error;
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    _device= [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return ;
    }
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        //4.1.将输入流添加到会话
        [_captureSession addInput:input];
    }
    if (captureMetadataOutput) {
        [_captureSession addOutput:captureMetadataOutput];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        captureMetadataOutput.metadataObjectTypes=a;
    }
    


    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:self.view.layer.bounds];
    //9.将图层添加到预览view的图层上
    [self.view.layer addSublayer:_videoPreviewLayer];
    
    _viewPreview = [[LayerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_viewPreview];
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake((_viewPreview.bounds.size.height * 0.2f)/self.view.bounds.size.height, (_viewPreview.bounds.size.width * 0.2f)/self.view.bounds.size.width, (_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)/self.view.bounds.size.height, (_viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)/self.view.bounds.size.width);

    
    /*
//    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView * lefteffe = [[UIVisualEffectView alloc]initWithEffect:blur];
//    lefteffe.frame = CGRectMake(0, 0, _viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height);
//    // 把要添加的视图加到毛玻璃上
//    [_viewPreview addSubview:lefteffe];
//    

////    10.1.扫描框
//    NSLog(@"-------%@",NSStringFromCGRect(rect));
//    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.2f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f, _viewPreview.bounds.size.width - _viewPreview.bounds.size.width * 0.4f)];
//    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
//    _boxView.layer.borderWidth = 1.0f;
//    [_viewPreview addSubview:_boxView];
//    //10.2.扫描线
//    _scanLayer = [[CALayer alloc] init];
//    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
//    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
//    [_boxView.layer addSublayer:_scanLayer];
*/
    [_captureSession addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    //10.开始扫描
    [_captureSession startRunning];
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        if (isRunning) {
            [_viewPreview addAnimation];
        }else{
            [_viewPreview removeAnimation];
        }
    }
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn setTitle:@"开启闪光" forState:UIControlStateNormal];
    [btn setTitle:@"关闭闪光" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(lightOpen:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;

       _captureSession = nil;
    _isReading = NO;
    
    [self startReading];
}
- (void)lightOpen:(UIButton *)sender
{
    BOOL isOn = sender.isSelected;
    if (isOn) {
        [_device lockForConfiguration:nil];
        _device.torchMode = AVCaptureTorchModeOff;
        [_device unlockForConfiguration];
    } else {
        [_device lockForConfiguration:nil];
        _device.torchMode = AVCaptureTorchModeOn;
        [_device unlockForConfiguration];
    }
    sender.selected = !isOn;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
   }
//    然后实现 AVCaptureMetadataOutputObjectsDelegate
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [_captureSession removeObserver:self forKeyPath:@"running"];
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            _isReading = NO;
            NSLog(@"%@",[metadataObj stringValue]);
            dispatch_async(dispatch_get_main_queue(), ^{
                                
                WebviewController *webView = [[WebviewController alloc]init];
                webView.webURL = [metadataObj stringValue];
                NSLog(@"%@",self.navigationController);
                [self.navigationController pushViewController:webView animated:YES];
                
            });
            
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_captureSession) {
         [self startReading];
    }
   
}
-  (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_captureSession) {
        [_captureSession stopRunning];
        _captureSession = nil;
        [_viewPreview removeFromSuperview];
        _viewPreview = nil;
        [_videoPreviewLayer removeFromSuperlayer];

    }
}
-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_viewPreview removeFromSuperview];
    _viewPreview = nil;
    [_videoPreviewLayer removeFromSuperlayer];
    
    
}
/**
 *  @author Whde
 *
 *  添加扫码动画
 */
//- (void)addAnimation{
//    
//    
//    _scanLayer.hidden = NO;
//    CABasicAnimation *animation = [QRViewController moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:_boxView.bounds.size.height] rep:OPEN_MAX];
//    [_scanLayer addAnimation:animation forKey:@"LineAnimation"];
//}
///**
// *  @author Whde
// *
// *  去除扫码动画
// */
//- (void)removeAnimation{
//    
//    [_scanLayer removeAnimationForKey:@"LineAnimation"];
//    _scanLayer.hidden = YES;
//}

//+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
//{
//    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    [animationMove setFromValue:fromY];
//    [animationMove setToValue:toY];
//    animationMove.duration = time;
//    animationMove.delegate = self;
//    animationMove.repeatCount  = rep;
//    animationMove.fillMode = kCAFillModeForwards;
//    animationMove.removedOnCompletion = NO;
//    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    return animationMove;
//}
- (void)dealloc{
    
    NSLog(@"页面结束");

    
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
