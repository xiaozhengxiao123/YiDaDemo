//
//  ViewController.m
//  DaoHangSDK
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 yidahulian. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>//基础包SDK
#import <AMapLocationKit/AMapLocationKit.h>//定位SDK

@interface ViewController ()<AMapLocationManagerDelegate>

@property (nonatomic, strong)AMapLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //(互联网连接似乎是离线)The Internet connection appears to be offline当手机不连接网络时打印这句话但仍然能定位。
    self.view.backgroundColor = [UIColor yellowColor];
    /*
     1.com.yidahulian.DaoHangSDK  绑定标识
     2.cc6b4c03bde031e19ae17137d18b8f22  地图key
     3.基础SDK V1.4.0（含IDFA） AMapFoundationKit.framework
     4.定位 SDK V2.4.0         AMapLocationKit.framework
    */
//    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
//    NSLog(@"%@", bundleIdentifier);//com.yidahulian.DaoHangSDK
    
    [AMapServices sharedServices].apiKey = @"cc6b4c03bde031e19ae17137d18b8f22";
    
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    
    //是否会被系统自动暂停定位。默认为NO。
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    
    //设定定位的最小更新距离单位米默认为kCLDistanceFilterNone，表示只要检测到设备位置发生变化就会更新位置信息。
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    
    //设定期望的定位精度。单位米，默认为 kCLLocationAccuracyBest。定位服务会尽可能去获取满足desiredAccuracy的定位结果，但不保证一定会得到满足期望的结果。 \n注意：设置为kCLLocationAccuracyBest或kCLLocationAccuracyBestForNavigation时，单次定位会在达到locationTimeout设定的时间后，将时间内获取到的最高精度的定位结果返回。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //指定单次定位超时时间,默认为10s。最小值是2s。注意单次定位请求前设置。注意: 单次定位超时时间从确定了定位权限(非kCLAuthorizationStatusNotDetermined状态)后开始计算。我们尽量设置大一点，否则容易造成定位失败！
    [self.locationManager setLocationTimeout:10];
    
    /**
    //是否允许后台定位。默认为NO。只在iOS 9.0及之后起作用。设置为YES的时候必须保证 Background Modes 中的 Location updates 处于选中状态，否则会抛出异常。由于iOS系统限制，需要在定位未开始之前或定位停止之后，修改该属性的值才会有效果。
     Background Modes在哪里？ Targets ->Capabilities ->Background Modes ->选中Location updates
    */
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //开始连续定位。调用此方法会cancel掉所有的单次定位请求。
    [self.locationManager startUpdatingLocation];
    
    //停止连续定位。调用此方法会cancel掉所有的单次定位请求，可以用来取消单次定位。
//    [self.locationManager stopUpdatingLocation];
}

#pragma mark ----AMapLocationManagerDelegate 
//定位成功
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSLog(@"纬度：%f \n经度：%f", location.coordinate.latitude, location.coordinate.longitude);
}

//定位失败
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"错误为：%@", error);
    NSLog(@"定位错误为：%@", [error localizedDescription]);
}



@end
