//
//  ImageCompression.m
//  ReferenceProject_iOS
//
//  Created by Vmoksha on 24/08/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "ImageCompression.h"

@interface ImageCompression ()
{
     NSData *imgData;
//    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UILabel *sizebeforeCompression;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewbeforeCompression;
@property (weak, nonatomic) IBOutlet UIImageView *imageaftercompression;
@property (weak, nonatomic) IBOutlet UILabel *sizeaftercompresssion;

@end

@implementation ImageCompression

- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
    
    // showing the image and size without compressing
    
    // taking the image from bundle
    NSString *imageString = [[NSBundle mainBundle] pathForResource:@"image2Mb" ofType:@"jpg"];
   
    imgData  = [NSData dataWithContentsOfFile:imageString];
    UIImage *bImage = [UIImage imageWithData:imgData];
    self.imageViewbeforeCompression.image = bImage;
    self.sizebeforeCompression.text = [NSString stringWithFormat:@"size of image before compression is %lu Kb",([imgData length]/1024)];
    
    
    // showing the image and size after compressing
    UIImage *compressedImage =  [self compressImage:bImage];
    self.imageaftercompression.image = compressedImage;
    NSData *imageData = UIImageJPEGRepresentation(compressedImage, 1);
    self.sizeaftercompresssion.text = [NSString stringWithFormat:@"size of image after compression is %lu Kb",([imageData length]/1024)];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImage *)compressImage:(UIImage *)imageC{
    float actualHeight = imageC.size.height;
    float actualWidth = imageC.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [imageC drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    imgData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    NSLog(@"Size of Image after compress(bytes):%lu",(unsigned long)[imgData length]);
    return [UIImage imageWithData:imgData];
}



@end
