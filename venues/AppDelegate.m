//
//  AppDelegate.m
//  venues
//
//  Created by Jose Maza on 6/17/15.
//  Copyright (c) 2015 Jose Maza. All rights reserved.
//
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#import "AppDelegate.h"
#import "DetailViewController.h"
#import <AFNetworkReachabilityManager.h>
#import "JAMNetworkClient.h"


@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notesAPIReachabilityChangedNotification:)
                                                 name:AFNetworkingReachabilityDidChangeNotification
                                               object:nil];
    
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    //UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    /*if ([splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    }*/
    splitViewController.delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Notification observers
- (void)notesAPIReachabilityChangedNotification:(NSNotification *)notification
{
    NSLog(@"Rechability status: %ld", [JAMNetworkClient sharedHTTPClient].reachabilityManager.networkReachabilityStatus);
    NSLog(@"Rechability status string: %@", [[JAMNetworkClient sharedHTTPClient].reachabilityManager localizedNetworkReachabilityStatusString]);
    
    if ([JAMNetworkClient sharedHTTPClient].reachabilityManager.isReachableViaWiFi) {
        NSLog(@"La API está disponible vía WiFi");
    } else if ([JAMNetworkClient sharedHTTPClient].reachabilityManager.isReachableViaWWAN) {
        NSLog(@"La API está disponible vía WWAN (3G, LTE, GPRS…)");
    }
}



#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.

        return YES;
    } else {
        return NO;
    }
}

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc{
    barButtonItem.title = @"< Master";
    //self.popover = pc;
   // UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    //if ([splitViewController respondsToSelector:@selector(displayModeButtonItem)]){
        UINavigationController *navigationController = [svc.viewControllers lastObject];
        //DetailViewController
    
    
        //navigationController.topViewController.navigationItem.leftBarButtonItem = barButtonItem;
    [navigationController.topViewController.navigationItem setLeftBarButtonItem:(barButtonItem) animated:YES];
    //}
    
   // UINavigationController *navigationController = [splitViewController.viewControllers];
    
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{
    //UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [svc.viewControllers lastObject];
    //if (barButtonItem == navigationController.topViewController.navigationItem.leftBarButtonItem){
        //navigationController.topViewController.navigationItem.leftBarButtonItem = nil;
    [navigationController.topViewController.navigationItem setLeftBarButtonItem:(nil) animated:YES];
    //}
}




///
/// Used by iOS 7 iPad
///

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
  
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        return NO;
    } else{
        return YES;
    }
    //return _needsHideMasterView;
}

@end
