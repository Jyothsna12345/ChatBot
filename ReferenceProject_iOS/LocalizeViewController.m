// Add " pod 'MCLocalization', '~> 1.1' " in pod file.
// in terminal run "pod install" command.
//import MClocalization File " <MCLocalization/MCLocalization.h>" into viewcontroller.
//Create a empty file ->command+N ->choose "other" under IOS -> select "Empty File".
//Name that file(use language name) with Extension ".json".
//Read data from File using MCLocalization.

#import "LocalizeViewController.h"
#import <MCLocalization/MCLocalization.h>
@interface LocalizeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@end

@implementation LocalizeViewController
{
    NSIndexPath *selectedIndex;
    NSMutableArray *languageArray;
    NSArray *languageTypeArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
      self.navigationItem.hidesBackButton=NO;
    languageArray=[[NSMutableArray alloc]init];
    languageTypeArray=@[@"Kannada",@"English",@"Hindi"];
    [self readDataFromFile:@"English"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return languageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    UILabel *label=(UILabel*)[cell viewWithTag:10];
    label.text=languageArray[indexPath.row];
    tableView.tableFooterView=[UIView new];
    if ([selectedIndex isEqual:indexPath]) {
        cell.backgroundColor=[UIColor lightGrayColor];
    }else cell.backgroundColor=[UIColor whiteColor];
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex=indexPath;
 [self readDataFromFile:languageTypeArray[indexPath.row]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//-(void)storeJsonDataInFile:(NSString*)languageCode{
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filepath=paths[0];
//    NSFileManager *filemanager=[NSFileManager defaultManager];
//    NSString *languageDic=[filepath stringByAppendingPathComponent:@"language"];
//    if (![filemanager fileExistsAtPath:languageDic]) {
//         NSError *error;
//        [filemanager createDirectoryAtPath:languageDic withIntermediateDirectories:NO attributes:nil error:&error];
//    }
//     NSString *languageFilePath=[languageDic stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",languageCode]];
//}
-(void)readDataFromFile:(NSString*)languageCode{
    [languageArray removeAllObjects];
    NSMutableDictionary *jsonDictionary=[[NSMutableDictionary alloc]init];
    NSString *filepath=[[NSBundle mainBundle]pathForResource:languageCode ofType:@".json"];
    NSURL *fileUrl=[NSURL fileURLWithPath:filepath];
    [jsonDictionary setObject:fileUrl forKey:languageCode];
    [MCLocalization loadFromLanguageURLPairs:jsonDictionary defaultLanguage:@"English"];
    [MCLocalization sharedInstance].language=languageCode;
    [MCLocalization sharedInstance].noKeyPlaceholder=@"[no '{key}' in '{language}']";
    
    [languageArray addObject:[MCLocalization stringForKey:@"Kannada"]];
    [languageArray addObject:[MCLocalization stringForKey:@"English"]];
    [languageArray addObject:[MCLocalization stringForKey:@"Hindi"]];
    _dataLabel.text=[MCLocalization stringForKey:@"Text"];
    [_tableView reloadData];
    [self.view layoutIfNeeded];
    _tableviewHeight.constant=_tableView.contentSize.height;
}
@end
