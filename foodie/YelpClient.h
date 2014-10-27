//
//  YelpClient.h
//  foodie
//
//  Created by Gaurav Menghani on 10/24/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id) initWithConsumerKey:(NSString*) key consumerSecret:(NSString*)consumerSecret accessToken:(NSString*)accessToken accessSecret:(NSString*)accessSecret filterDict:(NSDictionary*)filterDict;
- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
