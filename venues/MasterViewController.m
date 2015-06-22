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
#import "VenueItem.h"
#import "JAMVenueStore.h"
#import "JAMNetworkClient.h"
#import "AFNetworking.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
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
    JAMNetworkClient *client = [JAMNetworkClient sharedHTTPClient];
    [client setDelegate:self];
    [client makeVenueRequests];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSArray *venues = [[JAMVenueStore sharedStore] allVenues];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *controller;
        if ([[segue destinationViewController] isKindOfClass:[UINavigationController class]]) {
            controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        }
        else {
            controller = (DetailViewController *)[segue destinationViewController];
        }
        [controller setDetailItem:venues[indexPath.row]];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark JAMNetworkClient Delegate

-(void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didSucceedWithResponse:(id)responseObject{
    [self.tableView reloadData];
}

-(void)JAMNetworkClient:(JAMNetworkClient *)sharedHTTPClient didFailWithError:(NSError *)error{
    NSLog(@"error");
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[JAMVenueStore sharedStore] allVenues ] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *venues = [[JAMVenueStore sharedStore] allVenues];
    
    cell.textLabel.text = [[venues objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text = [[venues objectAtIndex:indexPath.row] fullAddress];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}
/*
-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation{
    return NO;
}*/


@end
