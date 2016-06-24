//First go to this link: https://developers.facebook.com/quickstarts/267717016920312/?platform=ios
//Login facebook
//If we create first time new app as a ios developer then it compulsory to register.
//For register we have to give contact number for verification.
//After that go to "My App".
//Go to "Add new app".
//Select as as "IOS" developer.
//Give Project name
//Tap create "App ID"
//Select Category and add Email Id then Tap on "Create App Id"
//Answer the Security Question ->Then Click on Submit.
//Then Download and Drag and Drop the "Facebook SDK" in your project.
//Add to Xcode"FBSDKCoreEKit.framework,FBSDKLoginKit.framework,FBSDKShareKit.framework".
//When you Add the framework it is complusory to check the box"Copy item if needed".
//Next step is "Configure".To configure go to Xcode then Right click on "info .plist" file and choose open with as a "Source code" in that C and Paste "Xml snippet" into body of your file(<dict>...</dict> ).
//Next Find your bundle Identifier in your Xcode Project's iOS Application Target.
//Go to Facebook "Dashboard"->Select "App Review"->Select "YES" to enable  Single Sign On and Tap "Save changes".
//Once your app is ready to be publicly available, you can now select "Status & Reviews" in the left sidebar and click on "Yes" to enable your app and all its live features.
//Import "FBSDKCoreEKit.framework" in our "AppDelegate.h".
//import also "FBSDKCoreEKit.framework,FBSDKLoginKit.framework" in our Class.

//reference :  https://developers.facebook.com/docs/ios/getting-started


#import "FacebookViewController.h"

@interface FacebookViewController (){
    FBSDKLoginButton *facebookLogin;
    }
-(void)toggleHiddenState:(BOOL)shouldHide;
@end

@implementation FacebookViewController
@synthesize Facebookbtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    facebookLogin=(FBSDKLoginButton *)Facebookbtn;
    [self toggleHiddenState:YES];
    self.navigationController.navigationBarHidden=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//Private method implementation
-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;

}
//It's call the method when Tap the Facebook Button.
- (IBAction)FacebookLogin:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email",@"user_birthday"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            NSLog(@"Error: %@",error.description);
        }
        else {
            [self getFacebookDetail];
        }
        
    }];
    [login logOut];
    
}
//this is the "FBSDKLoginButtonDelegate" method.
-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if (error) {
        
    }
}
//this is the "FBSDKLoginButtonDelegate" method.

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}
- (void)getFacebookDetail {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email" forKey:@"fields"];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                  id result, NSError *error) {
        
     NSLog(@"fetch user:%@ and email:%@ ",result,result[@"email,user_birthday"]);
   FBSDKProfilePictureView *profilePictureView=[[FBSDKProfilePictureView alloc]initWithFrame:_profilePicture.frame];
         [profilePictureView setProfileID:result[@"id"]];
         [self.view addSubview:profilePictureView];
         }];
}





@end
