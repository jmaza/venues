//
//  JAMNetworkClient.m
//  venues
//
//  Created by Jose Maza on 6/21/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "JAMNetworkClient.h"
#import "AFNetworking.h"
#import "MasterViewController.h"
#import "JAMVenueStore.h"
//#import "Venue

static NSString *const baseURL = @"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json";

@implementation JAMNetworkClient

+ (JAMNetworkClient *)sharedHTTPClient{
    static JAMNetworkClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    
    return _sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    return self;
}

-(void)makeVenueRequests{
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *error;
        
        [[JAMVenueStore sharedStore] createVenue:[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error]];
        if (error != nil) {
            NSLog(@"Error parsing JSON");
        }
        if ([self.delegate respondsToSelector:@selector(JAMNetworkClient:didSucceedWithResponse:)]) {
            [self.delegate JAMNetworkClient:self didSucceedWithResponse:responseObject];
        }else{
            NSLog(@"success");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(JAMNetworkClient:didFailWithError:)]) {
            [self.delegate JAMNetworkClient:self didFailWithError:error];
        }else{
            NSLog(@"Fail");
        }
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    
    [operation start];

}


//#pragma mark - Blocks

//-(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock{
//    return ^(AFHTTPRequestOperation *operation, id responseObject){
        /*if ([self.delegate respondsToSelector:@selector(HTTPClient:didSucceedWithResponse:)]) {
            [self.delegate HTTPClient:self didSucceedWithResponse:responseObject];
        }else{
            NSLog(@"Delegate do not response success service");
        }*/
        //[MBProgressHUD hideAllHUDsForView:progressBackground animated:YES];
//    };
//}
/*
-(void (^)(NSURLSessionDataTask *task, NSError *error))failBlock:(UIView *)progressBackground{
    return ^(NSURLSessionDataTask *task, NSError *error){
        if ([self.delegate respondsToSelector:@selector(HTTPClient:didFailWithError:)]) {
            [self.delegate HTTPClient:self didFailWithError:error];
        }else{
            NSLog(@"Delegate do not response failed service");
        }
        [MBProgressHUD hideAllHUDsForView:progressBackground animated:YES];
    };
}*/




/*-(void)makeVenueRequests:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success{
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request Failed: %@, %@", error, error.userInfo);
    }];
    
    [operation start];
    
}*/


@end
