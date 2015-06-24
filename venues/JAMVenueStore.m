//
//  JAMVenueStore.m
//  venues
//
//  Created by Jose Maza on 6/21/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "JAMVenueStore.h"
#import "VenueItem.h"

@interface JAMVenueStore()

@property (nonatomic) NSMutableArray *privateVenues;

@end

@implementation JAMVenueStore

+(instancetype)sharedStore{
    static JAMVenueStore *sharedStore = nil;
    
    if(!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [JAMVenueSore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if (self){
        _privateVenues = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(NSArray *)allVenues{
    return self.privateVenues;
}

-(void)createVenue:(NSArray *)jsonResponseArray{
    for (int i = 0; i < jsonResponseArray.count; i++) {
        VenueItem *currentVenue = [[VenueItem alloc] initWithVenueArray: [jsonResponseArray objectAtIndex:i]];
        [self.privateVenues addObject:currentVenue];
    }
    
}
@end
