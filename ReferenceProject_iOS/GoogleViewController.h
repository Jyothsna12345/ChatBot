//
//  GoogleViewController.h
//  ReferenceProject_iOS
//
//  Created by vmoksha on 27/06/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface GoogleViewController : UIViewController<GIDSignInUIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *googlebtn;
@property (weak, nonatomic) IBOutlet UIImageView *googleimg;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullLabel;
- (IBAction)googleLogin:(id)sender;

@end
