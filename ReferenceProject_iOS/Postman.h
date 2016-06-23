//
//  Postman.h
//  PrayerPartner
//
//  Created by Saurabh on 2/25/16.
//  Copyright © 2016 saurabh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface Postman : NSObject


- (void)get:(NSString *)URLString withParameters:(NSString *)parameter success:(void(^)(NSURLSessionDataTask *operation,id responseObject))success failure:(void(^)(NSURLSessionDataTask *operation, NSError *error))failure;

-(void)post:(NSString *)URLString withParameter:(NSString *)parameter success:(void(^)(NSURLSessionDataTask *operation,id responseObject))sucess
   failour :(void(^)(NSURLSessionDataTask *operation, NSError *error))failour;




@end
