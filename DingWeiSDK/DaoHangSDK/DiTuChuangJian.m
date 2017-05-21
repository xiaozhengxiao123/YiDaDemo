//
//  DiTuChuangJian.m
//  DaoHangSDK
//
//  Created by 123 on 17/5/18.
//  Copyright © 2017年 yidahulian. All rights reserved.
//

#import "DiTuChuangJian.h"
#import <AMapFoundationKit/AMapFoundationKit.h>//基础包SDK
#import <MAMapKit/MAMapKit.h>//3D地图SDK

@interface DiTuChuangJian ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;//地图对象

@end

@implementation DiTuChuangJian

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [AMapServices sharedServices].apiKey = @"cc6b4c03bde031e19ae17137d18b8f22";
    
    //地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    
    //把地图添加至view
    [self.view addSubview:self.mapView];
    
//    [self setMapProperties];//设置地图属性
    
    //如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    //< 追踪用户的location与heading更新
    self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    /*
     支持后台定位，即便你的app退到后台，且位置不变动时，也不会被系统挂起，可持久纪录位置信息。
     该功能适用于纪录轨迹或者出行类app司机端。
     注意：
     <1>.后台定位必须将info.plist的字段改成NSLocationAlwaysUsageDescription字段。
     <2>.设置允许后台定位，TARGETS -> Capabilities -> Background Modes -> Location updates 勾选。
    */
    self.mapView.pausesLocationUpdatesAutomatically = NO;//禁止自动暂停更新
    self.mapView.allowsBackgroundLocationUpdates = YES;//ios9以上系统必须配置
    
}

#pragma mark----------------设置地图属性
- (void)setMapProperties{
    [self.mapView setMapType:MAMapTypeStandard];//设置地图种类为普通地图，它还有其它种类
    self.mapView.showTraffic = YES;//是否显示交通, 默认为NO
    self.mapView.showsBuildings = YES;//是否显示楼块，默认为YES
    self.mapView.showsLabels = YES;//是否显示底图标注, 默认为YES
    
    //logo位置, 必须在mapView.bounds之内，否则会被忽略
    self.mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-35, CGRectGetHeight(self.view.bounds)-15);
    
    self.mapView.showsCompass = YES;//是否显示指南针, 默认YES
    self.mapView.compassOrigin = CGPointMake(self.mapView.compassOrigin.x, 22);//指南针位置
    
    self.mapView.showsScale = YES;//是否显示比例尺, 默认YES
    self.mapView.scaleOrigin = CGPointMake(self.mapView.scaleOrigin.x, 22);//比例尺位置
    
    self.mapView.zoomEnabled = YES;//是否支持缩放, 默认YES
    /**
     * @brief 设置缩放级别（默认3-19，有室内地图时为3-20）
     * @param zoomLevel 要设置的缩放级别
     * @param animated 是否动画设置
     */
    [self.mapView setZoomLevel:15 animated:YES];
    
    
    self.mapView.scrollEnabled = YES;//是否支持平移, 默认YES
    
    self.mapView.rotateEnabled = YES;//是否支持旋转, 默认YES
    /**
     * @brief 设置地图旋转角度(逆时针为正向)
     * @param rotationDegree 旋转角度
     * @param animated 动画
     * @param duration 动画时间
     */
    [self.mapView setRotationDegree:60.0f animated:YES duration:0.5];
    
    
    self.mapView.rotateCameraEnabled = YES;//是否支持camera旋转, 默认YES
    /**
     * @brief 设置地图相机角度(范围为[0.f, 60.f]，但高于40度的角度需要在16级以上才能生效)
     * @param cameraDegree 要设置的相机角度
     * @param animated 是否动画
     * @param duration 动画时间
     */
    [self.mapView setCameraDegree:35.f animated:YES duration:0.5];
    
}

#pragma mark----------------MAMapViewDelegate
/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if (updatingLocation) {
        //取出当前位置坐标
        NSLog(@"纬度：%f, 经度：%f。", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    }
}



@end
