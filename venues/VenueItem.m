//
//  VenueItem.m
//  venues
//
//  Created by Jose Maza on 6/18/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "VenueItem.h"


@implementation VenueItem

- (NSString *)fullAddress{
    return [NSString stringWithFormat:@"%@, %@, %@ %@",_address, _city, _state, _zip ];
}

-(void)setName:(NSString *)str{
    _name = str;
}

-(NSString *)name{
    return _name;
}

-(void)setCity:(NSString *)str{
    _city = str;
}

-(NSString *)city{
    return _city;
}
-(void)setZip:(NSString *)str{
    _zip = str;
}

-(NSString *)zip{
    return _zip;
}
-(void)setAddress:(NSString *)str{
    _address = str;
}

-(NSString *)address{
    return _address;
}
-(void)setState:(NSString *)str{
    _state = str;
}

-(NSString *)state{
    return _state;
}
-(void)setImage_url:(NSString *)str{
    _image_url = str;
}

-(NSString *)image_url{
    return _image_url;
}

-(void)setSchedule:(NSArray *)arr{
    _schedule = arr;
}

-(NSArray *)schedule{
    return _schedule;
}

@end
