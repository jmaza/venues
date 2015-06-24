//
//  JAMVenueStore.h
//  venues
//
//  Created by Jose Maza on 6/21/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VenueItem;

@interface JAMVenueStore : NSObject

@property (nonatomic, readonly) NSArray *allVenues;

+(instancetype)sharedStore;
-(void)createVenue:(NSArray *)jsonResponseArray;

@end
