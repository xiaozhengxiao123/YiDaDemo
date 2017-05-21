//
//  DiTuJiePin.m
//  DaoHangSDK
//
//  Created by 123 on 17/5/19.
//  Copyright © 2017年 yidahulian. All rights reserved.
//

#import "DiTuJiePin.h"
#import <AMapFoundationKit/AMapFoundationKit.h>//基础包SDK
#import <MAMapKit/MAMapKit.h>//3D地图SDK

@interface DiTuJiePin ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) MAMapView *mapView;//地图对象
@property (nonatomic, strong) CAShapeLayer *shapeLayer;//形状层对象

@end

@implementation DiTuJiePin

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [AMapServices sharedServices].apiKey = @"cc6b4c03bde031e19ae17137d18b8f22";
    
    //地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    [self.view addSubview:self.mapView];
    
    //如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;//追踪用户的location更新
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame =CGRectMake(self.view.bounds.size.width-120, 20, 100, 30);
    [button setTitle:@"开始截屏" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(captureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self initGestureRecognizer];//初始化Pan手势，用于画矩形
    [self initShapeLayer];//初始化形状层，用于获取截图矩形
}

#pragma mark----------------初始化Pan手势，用于画矩形
- (void)initGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    pan.delegate = self;
    pan.maximumNumberOfTouches = 1;//手指个数为1
    [self.view addGestureRecognizer:pan];
}

#pragma mark----------------初始化形状层，用于获取截图矩形
- (void)initShapeLayer{
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.lineWidth = 2;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor = [[UIColor grayColor] colorWithAlphaComponent:0.3f].CGColor;
    self.shapeLayer.lineDashPattern = [NSArray arrayWithObjects:@5, @5, nil];//设置虚线（数组元素1表示虚线长度，数组元素2表示虚线间的间隙）
    self.shapeLayer.path = NULL;//默认形状层路径为NULL
    [self.view.layer addSublayer:self.shapeLayer];
}

#pragma mark----------------点击按钮时，开始截图并显示
- (void)captureAction{
    
}

#pragma mark----------------UIGestureRecognizerDelegate
- (void)panGesture: (UIGestureRecognizer *)panGesture{
    
}




@end
