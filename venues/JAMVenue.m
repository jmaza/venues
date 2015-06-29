//
//  JAMVenue.m
//  venues
//
//  Created by jose on 6/24/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "JAMVenue.h"

@implementation JAMVenue

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}



@end
