//
//  MasterViewController.h
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAMNetworkClient.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <JAMNetworkClientDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

