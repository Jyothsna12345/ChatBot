#import "LocalizeViewController.h"
@interface LocalizeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@end

@implementation LocalizeViewController
{
    NSIndexPath *selectedIndex;
    int numberOfRows;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
      self.navigationItem.hidesBackButton=NO;
    numberOfRows=0;
    [self readDataFromFile:@"English"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *label=(UILabel*)[cell viewWithTag:10];
   
    tableView.tableFooterView=[UIView new];
    if ([selectedIndex isEqual:indexPath]) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }else cell.backgroundColor=[UIColor whiteColor];
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)readDataFromFile:(NSString*)languageCode{
    NSMutableDictionary *jsonDictionary=[[NSMutableDictionary alloc]init];
    NSString *filepath=[[NSBundle mainBundle]pathForResource:languageCode ofType:@".json"];
    NSURL *fileUrl=[NSURL fileURLWithPath:filepath];
    NSString *name=[filepath stringByDeletingPathExtension];
    [jsonDictionary setObject:fileUrl forKey:name];
    numberOfRows=3;
}
@end
