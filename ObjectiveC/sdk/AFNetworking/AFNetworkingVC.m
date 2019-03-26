//
//  AFNetworkingVC.m
//  ObjectiveC
//
//  Created by hello on 2019/1/9.
//  Copyright © 2019 William. All rights reserved.
//

#import "AFNetworkingVC.h"
#import <AFNetworking.h>

@interface AFNetworkingVC ()

@end

@implementation AFNetworkingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)uploadAction:(UIButton *)sender {
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response=[AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues=YES;
    manager.responseSerializer=response;
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //设置请求头类型
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"d"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"c"];
    //设置请求头, 授权码
    [manager.requestSerializer setValue:@"Bearer_eyJhbGciOiJIUzUxMiJ9.eyJyYW5kb21LZXkiOiJzaGU3NWEiLCJzdWIiOiJ7XCJ1c2VySWRcIjoyNzN9IiwiZXhwIjoxNTQ3NjI0MTA1LCJpYXQiOjE1NDcwMTkzMDV9.FcrL5Og8Kebd80QhuhiOY0ShCRyekEYaHWPlE_XtpxpZujfCelI1H5BRvdgwPy_uiE9BOSDVw_rA2rWBBc9PgA" forHTTPHeaderField:@"Authorization"];
    
    //上传服务器接口
    NSString *url = [NSString stringWithFormat:@"http://slavex.3dabuliu.com/bbs/gcuser/uploadHeadImg"];
    
    //开始上传
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [UIImage imageNamed:@"home"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"photoFile" fileName:@"1231.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"上传进度: %f", uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返回: %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败: %@", error);
    }];
}

@end
