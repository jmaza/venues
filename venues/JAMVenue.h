//
//  JAMVenue.h
//  venues
//
//  Created by jose on 6/24/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//


#import "JSONModel.h"

@protocol JAMVenue @end

@interface JAMVenue : JSONModel


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zip;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSArray *schedule;

@end
