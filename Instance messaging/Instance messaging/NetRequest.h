//
//  NetRequest.h
//  Instance messaging
//
//  Created by ljm on 2017/1/17.
//  Copyright © 2017年 ljm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequest : NSObject

//GET
+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))sucess failture:(void(^)(NSError *error))failture;

//POST
+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))sucess failture:(void(^)(NSError *error))failture;

@end
