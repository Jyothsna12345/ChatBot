//reference:https://developers.google.com/identity/sign-in/ios/start
//In terminal cd project path->pod init>then open the pod file and this"pod 'Google/SignIn'"->pod install>.
//Now configure file->give "App name"->project "Bundle identifier" the tap "choose and configure service".
//Tap "Sign In service".
//Download the "configure file" means ".plist file".
//Drag and Drop ".plist file" in your project;
//check the box"copy item if needed".
//Go to "info"->Url Types->tap "+"->in Url schemes add the "Reverse Id".
//Again Tap"+" in Url schemes"Bundle Identifier".
#import "GoogleViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>


@interface GoogleViewController ()<GIDSignInDelegate>

{
    GIDSignInButton *googlesignIn;
}
@end
@implementation GoogleViewController
@synthesize googlebtn;


- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate=self;
     [GIDSignIn sharedInstance].delegate =self;
    googlesignIn=(GIDSignInButton*)googlebtn;
    self.navigationController.navigationBarHidden=NO;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)googleLogin:(id)sender {
    [[GIDSignIn sharedInstance] signIn];
    }
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}
-(void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    
    
    NSString *userId = user.userID;                  // For client-side use only!
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
    {
        NSUInteger dimension = round(_googleimg.frame.size.width);
        NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        _googleimg.image=image;
        }
    _userLabel.text=email;
    _fullLabel.text=fullName;
    
}
@end
