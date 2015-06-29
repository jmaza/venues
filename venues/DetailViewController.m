//
//  DetailViewController.m
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

#import "DetailViewController.h"
#import "JAMVenue.h"
#import "JSONModelLib.h"
#import "JAMDateFormatter.h"
#import "JSONValueTransformer.h"
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
        JAMVenue *stateutil = [[JAMVenue alloc] init];
        stateutil = self.detailItem ;
        self.detailDescriptionLabel.text = [self.detailItem name];
        self.placeAddressOne.text = [NSString stringWithFormat:@"%@",[self.detailItem address] ]; //, venue.city, venue.state, venue.zip
        self.placeAddressTwo.text = [NSString stringWithFormat:@"%@, %@, %@",[self.detailItem city], [stateutil state] , [self.detailItem zip] ];
        [self.placeImageView sd_setImageWithURL:[NSURL URLWithString: [self.detailItem imageUrl] ]
                                                    placeholderImage:[UIImage imageNamed:@"venuePlaceHolder.jpg"]];
       // [self.detailItem showDate];
        NSLog(@"%@", [self.detailItem schedule]);
        //JSONValueTransformer *trans = [[JSONValueTransformer alloc] init];
        JAMDateFormatter *trans = [[JAMDateFormatter alloc] init];
        NSLog(@"%@",[trans JSONObjectFromSchedule:[self.detailItem schedule]]);
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    JAMDateFormatter *trans = [[JAMDateFormatter alloc] init];
    dateData = [trans JSONObjectFromSchedule:[self.detailItem schedule]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation ]== UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"Landscape");
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    }else{
        if (self.splitViewController.displayMode == UISplitViewControllerDisplayModeAllVisible || self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryOverlay) {
            [UIView animateWithDuration:0.3 animations:^{
                self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
            }];
        }
    }
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
