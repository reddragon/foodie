//
//  YelpClient.m
//  foodie
//
//  Created by Gaurav Menghani on 10/24/14.
//  Copyright (c) 2014 Gaurav Menghani. All rights reserved.
//

#import "YelpClient.h"

@interface YelpClient ()
@property (strong, nonatomic) NSDictionary* filterDict;
@end

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)key consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret filterDict:(NSDictionary*)filterDict {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:consumerSecret];
    if (self) {
        BDBOAuthToken *token = [BDBOAuthToken tokenWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    self.filterDict = filterDict;
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:term, @"term", @"37.774866,-122.394556", @"ll", nil];
    
    NSString* radius_filter = self.filterDict[@"radius_filter"];
    if (radius_filter.length > 0) {
        parameters[@"radius_filter"] = radius_filter;
    }
    
    
    NSString* sort = self.filterDict[@"sort"];
    if (sort.length > 0) {
        parameters[@"sort"] = sort;
    }
    
    NSString* category_filter = self.filterDict[@"category_filter"];
    if (category_filter.length > 0) {
        parameters[@"category_filter"] = category_filter;
        // parameters[@"term"] = @"abc";
    }    NSLog(@"Making a query with param: %@", parameters);
    return [self GET:@"search" parameters:parameters success:success failure:failure];
}

@end
