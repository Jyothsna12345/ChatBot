//
//  ForgotPasswordView.m
//  SeekRx
//
//  Created by Varghese Simon on 5/22/15.
//  Copyright (c) 2015 Vmoksha. All rights reserved.
//

#import "ForgotPasswordView.h"
#import "AppDelegate.h"
//#import "Postman.h"
//#import "Constant.h"
//#import <MBProgressHUD/MBProgressHUD.h>
//#import "iToast.h"

@interface ForgotPasswordView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end

@implementation ForgotPasswordView
{
    UIControl *aplhaView;
   // Postman *postman;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // No need to re-assign self here... owner:self is all you need to get
        // your outlet wired up...
        UIView *xibView = [[[NSBundle mainBundle] loadNibNamed:@"ForgotPasswordView" owner:self options:nil] objectAtIndex:0];
        // now add the view to ourselves...
        self.frame = CGRectMake(0, 0, 320, 175);
        [xibView setFrame:[self bounds]];
        
        
        [self addSubview:xibView]; // we automatically retain this with -addSubview:
        [self initializeView];
    }
    return self;
}

//popTextFieldBackground
- (void)initializeView
{
//    [self.sendButton setBackgroundImage:[[UIImage imageNamed:@"ForgetPassButtons"] resizableImageWithCapInsets:(UIEdgeInsetsMake(25, 25, 25, 25))] forState:(UIControlStateNormal)];
//    [self.cancelButton setBackgroundImage:[[UIImage imageNamed:@"ForgetPassButtons"] resizableImageWithCapInsets:(UIEdgeInsetsMake(25, 25, 25, 25))] forState:(UIControlStateNormal)];
//
//    self.emailIDTextField.background = [[UIImage imageNamed:@"LogInTextBackground"] resizableImageWithCapInsets:(UIEdgeInsetsMake(20, 20, 20, 20))];

    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds  = YES;
    
//    postman = [[Postman alloc] init];
//    postman.delegate = self;
    [self setLeftViewFor:self.emailIDTextField withImage:@"LoginMail"];
}

- (void)showView
{
    self.warningLabel.hidden = YES;
    self.emailIDTextField.text = @"";
    self.sendButton.enabled = NO;
    
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.center = appDel.window.center;

    BOOL allocationHappened = NO;
    if (aplhaView == nil)
    {
        aplhaView = [[UIControl alloc] initWithFrame:appDel.window.frame];
        aplhaView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
        aplhaView.translatesAutoresizingMaskIntoConstraints = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [aplhaView addSubview:self];
        [aplhaView addTarget:self action:@selector(hideKeyBoard) forControlEvents:(UIControlEventTouchDown)];

        allocationHappened = YES;
    }
    
    [appDel.window.rootViewController.view addSubview:aplhaView];
    
    NSDictionary *viewDict = @{@"aplhaView":aplhaView, @"self": self, @"superView": appDel.window.rootViewController.view};
    
    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[aplhaView]-0-|"
                                                                    options:kNilOptions
                                                                    metrics:nil
                                                                      views:viewDict];
    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[aplhaView]-0-|"
                                                                    options:kNilOptions
                                                                    metrics:nil
                                                                      views:viewDict];
    [appDel.window.rootViewController.view addConstraints:constraintsH];
    [appDel.window.rootViewController.view addConstraints:constraintsV];
    
    if (allocationHappened)
    {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self
                                                                      attribute:(NSLayoutAttributeCenterX)
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:aplhaView
                                                                      attribute:NSLayoutAttributeCenterX
                                                                     multiplier:1.0
                                                                       constant:0];
        [aplhaView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeCenterY)
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:aplhaView
                                                  attribute:NSLayoutAttributeCenterY
                                                 multiplier:1.0
                                                   constant:-20];
        [aplhaView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeWidth)
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:kNilOptions
                                                 multiplier:1.0
                                                   constant:320];
        [aplhaView addConstraint:constraint];
        
        constraint = [NSLayoutConstraint constraintWithItem:self
                                                  attribute:(NSLayoutAttributeHeight)
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:nil
                                                  attribute:kNilOptions
                                                 multiplier:1.0
                                                   constant:175];
        [aplhaView addConstraint:constraint];

    }
    
    [self.emailIDTextField becomeFirstResponder];
}

- (void)hideKeyBoard
{
    [self endEditing:YES];
}

- (void)hideView {
    
    [self endEditing:YES];
    [aplhaView removeFromSuperview];
    
    self.emailIDTextField.text = @"";
}

- (void)setLeftViewFor:(UITextField *)textField withImage:(NSString *)imageName {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0.0, 0.0, imageView.image.size.width+20.0, imageView.image.size.height);
    imageView.contentMode = UIViewContentModeCenter;
    
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (IBAction)sendPassword:(UIButton *)sender
{
    self.warningLabel.hidden = YES;
    [self endEditing:YES];
    
    if (![self validateEmailWithString:self.emailIDTextField.text]){
        self.warningLabel.text = @"Please enter a valid Email ID.";
        self.warningLabel.hidden = NO;
        return;
    }
    
//    NSString *URLString = [NSString stringWithFormat:@"%@%@",kBaseURL, kForgotPasswordPOST_URL];
//    NSString *parameter = [NSString stringWithFormat:@"{\"request\":{\"email\":\"%@\"}}", self.emailIDTextField.text];
//    
//    [MBProgressHUD showHUDAddedTo:self animated:YES];
//    [postman post:URLString withParameters:parameter
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              
//              [MBProgressHUD hideHUDForView:self animated:YES];
//              NSLog(@"%@",responseObject);
//              [self parseResponse:responseObject];
//              
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              
//              NSLog(@"Failure %@", error);
//              [MBProgressHUD hideHUDForView:self animated:YES];
//              
//          }];

}

- (void)parseResponse:(id)response
{
    NSDictionary *aDataDict = response[@"aaData"];
    
    if ([aDataDict[@"Success"] boolValue])
    {
       // TOAST_MESSAGE(@"Password sent successfully");
        [self hideView];
        
    }else
    {
        //TOAST_MESSAGE(@"Can't find the user. Check Email ID.");
    }
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self hideView];
}

- (BOOL)validateEmailWithString:(NSString*)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.warningLabel.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *expectedString = [textField.text mutableCopy];
    [expectedString replaceCharactersInRange:range withString:string];
    
    if (expectedString.length > 0)
    {
        self.sendButton.enabled = YES;
    }else
    {
        self.sendButton.enabled = NO;
    }
    
    return YES;
}

@end
