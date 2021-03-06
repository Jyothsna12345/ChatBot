//
//  AppDelegate.m
//  ReferenceProject_iOS
//
//  Created by Saurabh on 6/22/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //For Theme Change
    NSUserDefaults *defaultvalue=[NSUserDefaults standardUserDefaults];
    NSString *selectedColor=[defaultvalue valueForKey:@"selectedColor"];
    if ([selectedColor isEqualToString:@"redColor"]) {
        [[UINavigationBar appearance]setTintColor:[UIColor redColor]];
    }else  if ([selectedColor isEqualToString:@"blueColor"]) {
        [[UINavigationBar appearance]setTintColor:[UIColor blueColor]];
    }else  [[UINavigationBar appearance]setTintColor:[UIColor greenColor]];
    
//Add this code for Facebook launching purpose.
     [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    [GIDSignIn sharedInstance].clientID = @"414098840373-p9adjarr5klc4s7rem1ugvqlh1im7v12.apps.googleusercontent.com";
    return YES;
    
}
//Add also this code
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    NSString *str=[url absoluteString];
    if ([str containsString:@"fb"]) {
        return [[FBSDKApplicationDelegate sharedInstance]application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    else return [[GIDSignIn sharedInstance]handleURL:url sourceApplication:sourceApplication annotation:annotation];
}
-(void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error{
    
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
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
