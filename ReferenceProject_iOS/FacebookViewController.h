//
//  FacebookViewController.h
//  ReferenceProject_iOS
//
//  Created by devamit on 6/23/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FacebookViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *Facebookbtn;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIImageView*profilePicture;

@end
