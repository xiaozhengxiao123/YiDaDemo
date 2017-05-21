//
//  DanCiDingWeiViewController.m
//  DaoHangSDK
//
//  Created by 123 on 17/5/13.
//  Copyright © 2017年 yidahulian. All rights reserved.
//

#import "DanCiDingWeiViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>//基础包SDK
#import <AMapLocationKit/AMapLocationKit.h>//定位SDK

@interface DanCiDingWeiViewController ()

@property (nonatomic, strong)AMapLocationManager *locationManager;

@end

@implementation DanCiDingWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    /*
     1.com.yidahulian.DaoHangSDK  绑定标识
     2.cc6b4c03bde031e19ae17137d18b8f22  地图key
     3.基础SDK V1.4.0（含IDFA） AMapFoundationKit.framework
     4.定位 SDK V2.4.0         AMapLocationKit.framework
    */
    [AMapServices sharedServices].apiKey = @"cc6b4c03bde031e19ae17137d18b8f22";
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    
    //设定期望的定位精度。单位米，默认为 kCLLocationAccuracyBest。定位服务会尽可能去获取满足desiredAccuracy的定位结果，但不保证一定会得到满足期望的结果。 \n注意：设置为kCLLocationAccuracyBest或kCLLocationAccuracyBestForNavigation时，单次定位会在达到locationTimeout设定的时间后，将时间内获取到的最高精度的定位结果返回。
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];//kCLLocationAccuracyHundredMeters 定位精度为100米。
    
    //指定单次定位超时时间,默认为10s。最小值是2s。注意单次定位请求前设置。注意: 单次定位超时时间从确定了定位权限(非kCLAuthorizationStatusNotDetermined状态)后开始计算。
    [self.locationManager setLocationTimeout:10];
    
    //指定单次定位逆地理超时时间,默认为5s。最小值是2s。注意单次定位请求前设置。
    [self.locationManager setReGeocodeTimeout:5];
    
#if 1
    /**
     *  @brief 单次定位。如果当前正在连续定位，调用此方法将会失败，返回NO。\n该方法将会根据设定的 desiredAccuracy 去获取定位信息。如果获取的定位信息精确度低于 desiredAccuracy ，将会持续的等待定位信息，直到超时后通过completionBlock返回精度最高的定位信息。\n可以通过 stopUpdatingLocation 方法去取消正在进行的单次定位请求。
     *  @param withReGeocode 是否带有逆地理信息(获取逆地理信息需要联网)
     *  @param completionBlock 单次定位完成后的Block
     *  @return 是否成功添加单次定位Request
     */
    //带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            NSLog(@"定位失败：%@", error);
            return;
        }
        //定位信息
        CLLocationCoordinate2D coord = location.coordinate;
        NSLog(@"当前位置＝{纬度：%f；经度：%f}, 水平位置：%.2f米", coord.latitude, coord.longitude, location.horizontalAccuracy);
        
        //逆地理信息
        if (regeocode) {
            NSString *formattedAddress = regeocode.formattedAddress;//格式化地址
            NSString *country = regeocode.country;//国家
            NSString *province = regeocode.province;//省／直辖市
            NSString *city = regeocode.city;//市
            NSString *district = regeocode.district;//区
            NSString *citycode = regeocode.citycode;//城市编码
            NSString *adcode = regeocode.adcode;//区域编码
            NSString *street = regeocode.street;//街道名称
            NSString *number = regeocode.number;//门牌号
            NSString *POIName = regeocode.POIName;//兴趣点名称
            NSString *AOIName = regeocode.AOIName;//所属兴趣点名称
            
            NSString *info = [NSString stringWithFormat:@"格式化地址:%@\n国家:%@\n省／直辖市:%@\n市:%@\n区:%@\n城市编码:%@\n区域编码:%@\n街道名称:%@\n门牌号:%@\n兴趣点名称:%@\n所属兴趣点名称:%@\n", formattedAddress, country, province, city, district, citycode, adcode, street, number, POIName, AOIName];
            NSLog(@"\n%@", info);//打印信息
        }
    }];
    
#else
    //不带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            NSLog(@"定位失败：%@", error);
            return;
        }
        //定位信息
        CLLocationCoordinate2D coord = location.coordinate;
        NSLog(@"当前位置＝{纬度：%f；经度：%f}, 水平位置：%.2f米", coord.latitude, coord.longitude, location.horizontalAccuracy);
    }];
    
#endif
    
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
