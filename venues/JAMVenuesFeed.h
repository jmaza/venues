//
//  JAMVenuesFeed.h
//  venues
//
//  Created by jose on 6/28/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//


#import "JSONModel.h"
#import "JAMVenue.h"

@interface JAMVenuesFeed : JSONModel

@property (strong, nonatomic) NSMutableArray<JAMVenue>* venues;

@end
