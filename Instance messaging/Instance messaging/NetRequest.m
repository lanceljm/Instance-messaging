//
//  NetRequest.m
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import "NetRequest.h"
#import <AFNetworking.h>

@implementation NetRequest

+(void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))sucess failture:(void (^)(NSError *))failture{
    
    //实例化网络请求类 单例
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //配置请求超时时间
    manager.requestSerializer.timeoutInterval = 8.0;
    
    //默认的提交请求的格式是二进制格式，返回格式是 JSON
    //配置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //设置MIME类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucess(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failture(error);
        
    }];
    
}


+(void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))sucess failture:(void (^)(NSError *))failture{
    
    //实例化网络请求类 单例
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //配置请求超时时间
    manager.requestSerializer.timeoutInterval = 8.0;
    
    //默认的提交请求的格式是二进制格式，返回格式是 JSON
    //配置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //设置MIME类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucess(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failture(error);
        
    }];
    
}


@end
