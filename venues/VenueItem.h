//
//  VenueItem.h
//  venues
//
//  Created by Jose Maza on 6/18/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VenueItem : NSObject
{
    NSString *_name;
    NSString *_city;
    NSString *_zip;
    NSString *_address;
    NSString *_state;
    NSString *_image_url;
    NSArray *_schedule;
}

//-(instancetype)initWithVenueObj:

-(NSString *)fullAddress;

-(void)setName:(NSString *)str;
-(NSString *)name;

-(void)setCity:(NSString *)str;
-(NSString *)city;

-(void)setZip:(NSString *)str;
-(NSString *)zip;

-(void)setAddress:(NSString *)str;
-(NSString *)address;

-(void)setState:(NSString *)str;
-(NSString *)state;

-(void)setImage_url:(NSString *)str;
-(NSString *)image_url;

-(void)setSchedule:(NSArray *)arr;
-(NSArray *)schedule;

@end

