//
//  AppDelegate.h
//  ReferenceProject_iOS
//
//  Created by Saurabh on 6/22/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

