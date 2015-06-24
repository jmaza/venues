//
//  DetailViewController.m
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "DetailViewController.h"
#import "VenueItem.h"
#import "UIImageView+AFNetworking.h"
#import <Social/Social.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressOne;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressTwo;

@end

@implementation DetailViewController
@synthesize dateData;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem name];
        self.placeAddressOne.text = [self.detailItem detailAddressOne];
        self.placeAddressTwo.text = [self.detailItem detailAddressTwo];
        [self.placeImageView sd_setImageWithURL:[NSURL URLWithString: [self.detailItem imageUrl] ]
                                                    placeholderImage:[UIImage imageNamed:@"venuePlaceHolder.jpg"]];
       // [self.detailItem showDate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    dateData = [[NSMutableArray alloc] initWithArray:[self.detailItem showDate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.objects.count;
    return [[self.detailItem schedule] count ];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [dateData objectAtIndex:indexPath.row];
    
    return cell;
}


- (IBAction)shareToSN:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Look at this place I found using Venues App"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
}
@end
