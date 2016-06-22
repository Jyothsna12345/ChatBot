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

    collectionArr = @[@"Facebook",@"Google+",@"Maps",@"Forget Password",@"Remember Me",@"Change Password",@"Image Upload",@"File Upload",@"Image Compression",@"CustomFont",@"Theme",@"LocaliZation",].mutableCopy;
       self.navigationController.navigationBarHidden = YES;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
   
    
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // calcualting the padding from both side in collection view so we put total 64  and -4 is for gap between two cell.
    CGSize returnSize = CGSizeZero;
    returnSize = CGSizeMake((((self.view.frame.size.width-15)/3)), ((self.view.frame.size.width-15)/3));
    return returnSize;
}




@end
