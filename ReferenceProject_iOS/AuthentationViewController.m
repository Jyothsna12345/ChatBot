//
//  AuthentationViewController.m
//  ReferenceProject_iOS
//
//  Created by Saurabh on 6/22/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "AuthentationViewController.h"
#import "Postman.h"
#import "Constant.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface AuthentationViewController ()

{
    UIControl *activeField;
    Postman *postman;
}

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation AuthentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationController.navigationBarHidden = NO;
   postman =[[Postman alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    self.emailTextField.text = @"";
    self.passwordTextField.text = @"";
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets=UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}



- (IBAction)dismisskeypadMethod:(id)sender {
    
    [self.view endEditing:YES];
}


- (IBAction)LoginButtonAction:(id)sender {
    [self.view endEditing:YES];
    if (![self validateLoginFields])
    {
        //  TOAST_MESSAGE(@"Username and Password is required.");
        return;
    }
    
    [self callApiForLogin];
}

-(void)callApiForLogin
{
    NSString *urlString =[NSString stringWithFormat:@"%@%@",pBaseUrl,pLoginUrl];
    NSString *parameter =[NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}",self.emailTextField.text,self.passwordTextField.text];
   // NSString *parameter = @"{\"email\":\"%@\",\"password\":\"%@\"}";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [postman post:urlString withParameter:parameter success:^(NSURLSessionDataTask *task, id responseObject) {
        [self parsingLoginResponseMethod:responseObject];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"success");
    }
          failour:^(NSURLSessionDataTask *task, NSError *error) {
              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
              NSLog(@"failour %@", [task response]);
              NSString* errResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
              NSLog(@"%@",errResponse);

          }];






}
-(void)parsingLoginResponseMethod :(NSDictionary *)responseDict
{
    NSLog(@"%@",responseDict);
    NSDictionary *responseDictionary = responseDict;
    if ([responseDictionary[@"success"] boolValue]) {
        NSDictionary *viewModelDict =responseDictionary[@"ViewModel"];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:viewModelDict[@"authToken"] forKey:pAutToken];
        [self performSegueWithIdentifier:@"logintothanku" sender:self];
    }
}
- (BOOL)validateLoginFields
{
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    BOOL goodToGo = YES;
    NSMutableString *mutableString = [[NSMutableString alloc] init];
    if (userName.length == 0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Email Id is required"];
    }
    if (password.length == 0)
    {
        goodToGo = NO;
        if (mutableString.length>0) {
            [mutableString appendString:@"\nPassword is required"];
        }
        else
        {
            [mutableString appendString:@"Password is required"];
        }
    }
    
    else if (![self stringIsValidEmail:self.emailTextField.text]&&userName.length!=0)
    {
        goodToGo = NO;
        [mutableString appendString:@"Please enter a valid Email Id"];
    }
    
    
    if (!goodToGo)
    {
        [self mbProgress:mutableString];
    }
    return goodToGo;
    
}

-(BOOL)stringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)mbProgress:(NSString*)message
{
    MBProgressHUD *hubHUD=[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hubHUD.mode=MBProgressHUDModeText;
    hubHUD.detailsLabelText=message;
    hubHUD.detailsLabelFont=[UIFont systemFontOfSize:15];
    hubHUD.margin=20.f;
    hubHUD.yOffset=150.f;
    hubHUD.removeFromSuperViewOnHide = YES;
    [hubHUD hide:YES afterDelay:2];
}

@end
