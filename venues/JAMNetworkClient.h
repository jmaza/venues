//
//  JAMNetworkClient.h
//  venues
//
//  Created by Jose Maza on 6/21/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

@protocol JAMNetworkClientDelegate;

@interface JAMNetworkClient : AFHTTPSessionManager

@property (nonatomic, weak) id<JAMNetworkClientDelegate>delegate;

+ (JAMNetworkClient *)sharedHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)makeVenueRequests;

@end

#pragma mark - Protocol Methods

@protocol JAMNetworkClientDelegate <NSObject>

@optional

- (void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didSucceedWithResponse:(id)responseObject;
- (void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didSucceedWithOperations:(NSArray *)operations;
- (void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didFailWithError:(NSError *)error;

@end