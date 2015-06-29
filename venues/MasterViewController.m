//
//  MasterViewController.m
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//

//TODO:  hide labels onviewLoad / refactor.

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "JAMVenue.h"
#import "JSONModelLib.h"
#import "JAMNetworkClient.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIScrollView+SVPullToRefresh.h"


@interface MasterViewController ()
@property NSMutableArray *venueObjects;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak MasterViewController *weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    
   [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    JAMNetworkClient *client = [JAMNetworkClient sharedHTTPClient];
    [client setDelegate:self];
    [client makeVenueRequests];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation ]== UIDeviceOrientationLandscapeRight)
    {
        NSLog(@"Landscape");
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    }else{
        self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)insertRowAtTop {
    __weak MasterViewController *weakSelf = self;
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        JAMNetworkClient *client = [JAMNetworkClient sharedHTTPClient];
        [client setDelegate:self];
        [self.navigationController.navigationBar setTranslucent:NO];
        [client makeVenueRequests];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        [self.tableView setContentOffset:CGPointZero animated:YES];
        
    });
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if (self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryOverlay) {
        [UIView animateWithDuration:0.3 animations:^{
            self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
            self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAutomatic;
        }];
    }
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller;
        UIBarButtonItem *barButtonItem;
        barButtonItem.title = @"< Master";
        self.splitViewController.navigationItem.leftItemsSupplementBackButton = YES;
        
        if ([[segue destinationViewController] isKindOfClass:[UINavigationController class]]) {
            NSLog(@"yes");
            controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        }
        else {
            NSLog(@"no");
            controller = (DetailViewController *)[segue destinationViewController];
        }
        [controller setDetailItem:self.venueObjects[indexPath.row]];
        if ([self.splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        }
        
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark JAMNetworkClient Delegate

-(void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didSucceedWithResponse:(id)responseObject{
    
    NSData *responseJson = (NSData *)responseObject;
    NSError *error;

    self.venueObjects = [JAMVenue arrayOfModelsFromData:responseJson error:&error];
    
    [self.tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didFailWithError:(NSError *)error{
    NSLog(@"error");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.venueObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    JAMVenue* venue = self.venueObjects[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@", venue.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@, %@ %@",venue.address, venue.city, venue.state, venue.zip ];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


@end
