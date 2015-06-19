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
        _image_url = [arr objectForKey:@"image_url"];

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

//TODO: Handle Schedule

@end
