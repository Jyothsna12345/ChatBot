//
//  ForgotPasswordViewController.m
//  ReferenceProject_iOS
//
//  Created by Saurabh on 6/23/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ForgotPasswordView.h"
#import "Postman.h"

@interface ForgotPasswordViewController ()
{

    Postman *postman;
    ForgotPasswordView *forgotPasswordView;

}
@end

@implementation ForgotPasswordViewController

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
- (IBAction)forgotPasswordButtonAction:(id)sender {

        if (forgotPasswordView == nil)
        {
            forgotPasswordView = [[ForgotPasswordView alloc] init];
        }
    
        [forgotPasswordView showView];
    [self DemoAPI];

}



-(void)DemoAPI
{

 [postman get:@"http://shivaji.vmokshagroup.com:8282/category" withParameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
 
     NSLog(@"%@",responseObject);
     
 } failure:^(NSURLSessionDataTask *operation, NSError *error) {
     NSLog(@"%@",error);
 }];
    
    

}



@end
