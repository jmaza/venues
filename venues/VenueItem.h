//
//  VenueItem.h
//  venues
//
//  Created by Jose Maza on 6/18/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSArray *schedule;

-(instancetype)initWithVenueArray:(NSDictionary *)arr;

-(NSString *)fullAddress;
-(NSString *)detailAddressOne;
-(NSString *)detailAddressTwo;
-(NSArray *)showDate;

@end

