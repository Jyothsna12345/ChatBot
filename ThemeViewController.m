//Drag Drop the "Them Images" into the "Assets.xcassets".
//Create a array which have list of images.
//use tableview to display the image list.
// select any image and show that image as background image.
//store selected image in "NSUserDefault".



#import "ThemeViewController.h"

@interface ThemeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *themeTableView;

@end

@implementation ThemeViewController
{
    NSArray *themeValueArray;
    NSUserDefaults *defaultValue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton=NO;
    themeValueArray=@[@"background",@"nature",@"water",@"red"];
    defaultValue=[NSUserDefaults standardUserDefaults];
    NSString *backGroundImageName=[defaultValue valueForKey:@"backGroundImage"];
    if (backGroundImageName!=nil) {
        _backGroundImageView.image=[UIImage imageNamed:backGroundImageName];
        [defaultValue setValue:backGroundImageName forKey:@"backGroundImage"];
    }
    else{
        backGroundImageName=@"background";
    [defaultValue setValue:backGroundImageName forKey:@"backGroundImage"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return themeValueArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:10];
    imageView.image=[UIImage imageNamed:themeValueArray[indexPath.section]];
    tableView.tableFooterView=[UIView new];
     _tableViewHeight.constant=_themeTableView.contentSize.height;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 _backGroundImageView.image=[UIImage imageNamed:themeValueArray[indexPath.section]];
     [defaultValue setValue:themeValueArray[indexPath.section] forKey:@"backGroundImage"];
}
@end
