//
//  DetailViewController.h
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITableView *dateTableView;
- (IBAction)shareToSN:(id)sender;
@property (strong, nonatomic) NSArray *dateData;
@end

