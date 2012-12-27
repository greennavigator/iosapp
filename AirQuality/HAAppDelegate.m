//
//  HAAppDelegate.m
//  AirQuality
//
//  Created by Kostas Stamatis on 12/15/12.
//  Copyright (c) 2012 Kostas Stamatis. All rights reserved.
//

#import "HAAppDelegate.h"

#import "HAInfoViewController.h"
#import "HAMapViewController.h"
#import "DataStore.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@implementation HAAppDelegate

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Green Navigator"
                                                    message:@"You are entering a high-polluted area... Please, change your route!"
                                                   delegate:self cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Incoming notification in running app");
    
    /*NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound1.mp4" ofType:nil];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: &error];
    if (error){
        NSLog(@"ERROR: %@", [error localizedDescription]);
    }
    [player prepareToPlay];
    [player play];
*/
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSThread sleepForTimeInterval:3];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[DataStore sharedInstance] loadSampleDataSets];
    
    UIViewController *viewController1 = [[HAMapViewController alloc] init];
    self.window.rootViewController = viewController1;
                                         
/*
    UIViewController *viewController1 = [[HAMapViewController alloc] initWithNibName:@"HAMapViewController" bundle:nil];
    UIViewController *viewController2 = [[HAInfoViewController alloc] initWithNibName:@"HAInfoViewController" bundle:nil];
    //self.tabBarController = [[UITabBarController alloc] init];
    //self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.window.rootViewController = viewController1;
*/ 
    [self.window makeKeyAndVisible];
    
    
    UIApplication* app = [UIApplication sharedApplication];
    [app cancelAllLocalNotifications];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
