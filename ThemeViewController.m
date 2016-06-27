//Drag Drop the "Them Images" into the "Assets.xcassets".
//Create a array which have list of images if we use iimage as background or color name.
//use tableview to display the image list.
// select any image or color
// show that image or color as background.
//store selected image or color in "NSUserDefault".

//write fallowing code in appdelegate lauchoption to change the color of navigation bar in all viewcontroller
/*  NSUserDefaults *defaultvalue=[NSUserDefaults standardUserDefaults];
 NSString *selectedColor=[defaultvalue valueForKey:@"selectedColor"];
 if ([selectedColor isEqualToString:@"redColor"]) {
 [[UINavigationBar appearance]setTintColor:[UIColor redColor]];
 }else  if ([selectedColor isEqualToString:@"blueColor"]) {
 [[UINavigationBar appearance]setTintColor:[UIColor blueColor]];
 }else  [[UINavigationBar appearance]setTintColor:[UIColor greenColor]];
 */
#import "ThemeViewController.h"

@interface ThemeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UITableView *themeTableView;
@property (weak, nonatomic) IBOutlet UILabel *selectThemeLabel;

@end

@implementation ThemeViewController
{
    NSArray *themeValueArray;
    NSUserDefaults *defaultValue;
    NSIndexPath *selectedIndex;
    UIColor *selectedColor;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.hidesBackButton=NO;
    
    //themeValueArray=@[@"background",@"nature",@"water",@"red"]; // For Image Background
    themeValueArray=@[@"Red",@"Blue",@"Green"];
    defaultValue=[NSUserDefaults standardUserDefaults];
    NSString *backGroundImageName=[defaultValue valueForKey:@"backGroundImage"];
    if (backGroundImageName!=nil) {
        //_backGroundImageView.image=[UIImage imageNamed:backGroundImageName];  // For Image Background
        _backGroundImageView.hidden=YES;
        int i=(int)[themeValueArray indexOfObject:backGroundImageName];
        [self getTheColor:i];
        selectedIndex=[NSIndexPath indexPathForRow:0 inSection:i];
    }
    else{
        /*[defaultValue setValue:@"background" forKey:@"backGroundImage"];
        _backGroundImageView.image=[UIImage imageNamed:backGroundImageName];*/ // For Image Background
        _backGroundImageView.hidden=NO;
        selectedColor=[UIColor blackColor];
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
    UILabel *label=(UILabel*)[cell viewWithTag:10];
//    imageView.image=[UIImage imageNamed:themeValueArray[indexPath.section]]; // For Image Background
    label.text=themeValueArray[indexPath.section];
    tableView.tableFooterView=[UIView new];
    label.textColor= selectedColor;
    if ([selectedIndex isEqual:indexPath]) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }else cell.backgroundColor=[UIColor whiteColor];
    _tableViewHeight.constant=_themeTableView.contentSize.height;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor=selectedColor;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
// _backGroundImageView.image=[UIImage imageNamed:themeValueArray[indexPath.section]];
    [self getTheColor:(int)indexPath.section];
    selectedIndex=indexPath;
     [defaultValue setValue:themeValueArray[indexPath.section] forKey:@"backGroundImage"];
    [_themeTableView reloadData];
}
-(void)getTheColor:(int)value{
      _backGroundImageView.hidden=YES;
        switch (value) {
        case 0:
            self.view.backgroundColor=[UIColor redColor];
            [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
            _selectThemeLabel.textColor=[UIColor redColor];
            selectedColor =[UIColor redColor];
                [defaultValue setValue:@"redColor" forKey:@"selectedColor"];
                [_themeTableView setBackgroundColor:[UIColor redColor]];
            break;
        case 1:
            self.view.backgroundColor=[UIColor blueColor];
            [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
            _selectThemeLabel.textColor=[UIColor blueColor];
             selectedColor =[UIColor blueColor];
                 [defaultValue setValue:@"blueColor" forKey:@"selectedColor"];
            [_themeTableView setBackgroundColor:[UIColor blueColor]];
            break;
        case 2:
            self.view.backgroundColor=[UIColor greenColor];
            [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
            _selectThemeLabel.textColor=[UIColor greenColor];
             selectedColor =[UIColor greenColor];
            [defaultValue setValue:@"greenColor" forKey:@"selectedColor"];
            _themeTableView.backgroundColor=[UIColor greenColor];
            break;
        default:
            break;
    }
}
@end
