//
//  VenueItem.m
//  venues
//
//  Created by Jose Maza on 6/18/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "VenueItem.h"


@implementation VenueItem

- (instancetype)initWithVenueArray:(NSDictionary *)arr{
    self = [super init];
    
    if (self){
        _name = [arr objectForKey:@"name"];
        _zip = [arr objectForKey:@"zip"];
        _city = [arr objectForKey:@"city"];
        _address = [arr objectForKey:@"address"];
        _state = [arr objectForKey:@"state"];
        _imageUrl = [arr objectForKey:@"image_url"];
        _schedule = [arr objectForKey:@"schedule"];
    }
    
    return self;
}

- (NSString *)fullAddress{
    return [NSString stringWithFormat:@"%@, %@, %@ %@",_address, _city, _state, _zip ];
}
- (NSString *)detailAddressOne{
    return [NSString stringWithFormat:@"%@",_address ];
}
- (NSString *)detailAddressTwo{
    return [NSString stringWithFormat:@"%@, %@, %@",_city, _state, _zip ];
}

//TODO: Create DateFormatter Class to clean the code from below:
-(NSArray *)showDate{
    NSMutableArray *formattedDates = [[NSMutableArray alloc] init];
    NSDateFormatter *serverFormatter = [[NSDateFormatter alloc] init];
    [serverFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [serverFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];

    for (NSDictionary *dates in _schedule){
        
        NSDate *theDate = [serverFormatter dateFromString:dates[@"start_date"]];
        NSDate *endDate = [serverFormatter dateFromString:dates[@"end_date"]];
        
        NSDateFormatter *userFormatter = [[NSDateFormatter alloc] init];
        NSDateFormatter *endFormatter = [[NSDateFormatter alloc] init];
        [userFormatter setDateFormat:@"EEEE M/dd h:mm a 'to '"];
        [endFormatter setDateFormat:@"h:mm a"];
        [userFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [endFormatter setTimeZone:[NSTimeZone localTimeZone]];
        
        [formattedDates addObject:[[userFormatter stringFromDate:theDate] stringByAppendingString:[endFormatter stringFromDate:endDate]]  ];
        
    }
    return formattedDates;
}


@end
