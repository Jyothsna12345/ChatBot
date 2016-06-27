//
//  ViewController.m
//  ReferenceProject_iOS
//
//  Created by Saurabh on 6/22/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *collectionArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    collectionArr = @[@"Facebook",@"Google+",@"Maps",@"Forget Password",@"Authentication",@"Change Password",@"Sign Up",@"Image Upload",@"File Upload",@"Image Compression",@"CustomFont",@"Theme",@"LocaliZation",].mutableCopy;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView

{
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return collectionArr.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
       UILabel *titleLabel = (UILabel *)[cell viewWithTag:101];
    titleLabel.text = collectionArr[indexPath.row];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self redirectingControllerAccordingtoSelection:indexPath];
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // calcualting the padding from both side in collection view so we put total 64  and -4 is for gap between two cell.
    CGSize returnSize = CGSizeZero;
    returnSize = CGSizeMake((((self.view.frame.size.width-15)/3)), ((self.view.frame.size.width-15)/3));
    return returnSize;
}

-(void)redirectingControllerAccordingtoSelection:(NSIndexPath *)indexPath
{

    NSInteger itemNumer = indexPath.item;
    
    switch (itemNumer) {
        case 0:
           [self performSegueWithIdentifier:@"hometofacebook" sender:indexPath];
            break;
        case 1:
            [self performSegueWithIdentifier:@"homeTogoogle" sender:indexPath];
            break;
        case 2:
            //[self performSegueWithIdentifier:@"" sender:indexPath];

            break;
        case 3:
            [self performSegueWithIdentifier:@"forgetPassSegu" sender:indexPath];

            break;
        case 4:
            [self performSegueWithIdentifier:@"authSegue" sender:indexPath];

            break;
        case 5:
            [self performSegueWithIdentifier:@"changePassSegue" sender:indexPath];

            break;
        case 6:
             [self performSegueWithIdentifier:@"hometoSignUp" sender:indexPath];
            break;
        case 7:
            

            break;
        case 8:
            

            break;
        case 9:
            

            break;
        case 10:
             [self performSegueWithIdentifier:@"CustomeSegue" sender:indexPath];
            break;
        case 11:
             [self performSegueWithIdentifier:@"ThemeSegue" sender:indexPath];
            break;
        case 12:
             [self performSegueWithIdentifier:@"LocalizeSegue" sender:indexPath];
            break;
        default:
            break;
    }
    
   

}



@end
