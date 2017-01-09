//
//  ChatBotViewController.m
//  ReferenceProject_iOS
//
//  Created by Vmoksha on 06/01/17.
//  Copyright © 2017 vmoksha. All rights reserved.
//

#import "ChatBotViewController.h"
#import "ChatBotModelClass.h"
#import "ChatBotTableViewCell.h"

@interface ChatBotViewController ()

@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (weak, nonatomic) IBOutlet UITextView *aTextView;
- (IBAction)postAction:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewContainerViewbottomConstaint;
@property (weak, nonatomic) IBOutlet UIView *textViewContainerView;

@property (weak, nonatomic) IBOutlet UIButton *postButton;
@end

@implementation ChatBotViewController
{
    NSMutableArray * chatBotArr;
    NSIndexPath * selectedIndexpath;
    CGSize keyboardSize;
    CGFloat nwHeight ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    chatBotArr = [[NSMutableArray alloc]init];
    
    self.title = @"UCB ChatBot";
    
    _chatTable.estimatedRowHeight = 70.0;
    _chatTable.rowHeight = UITableViewAutomaticDimension;
    
    chatBotArr =[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:@"UIKeyboardDidHideNotification"
                                               object:nil];
    self.textViewContainerView.layer.cornerRadius = 10.0;
    _aTextView.layer.cornerRadius = 8.0 ;
    _postButton.layer.cornerRadius =8.0;
    self.textViewContainerViewbottomConstaint.constant = 8;
    self.chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;

}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndexpath.row inSection:0] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
//    });
//}

- (IBAction)postAction:(id)sender
{
    NSString *inputText = self.aTextView.text;
    if ([inputText length]==0) {
        return;
    } else {
        [self setInputQuestionsData:self.aTextView.text];
        self.aTextView.text = @"";
        [_chatTable reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger row = [chatBotArr count]-1;
            NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [[self chatTable] scrollToRowAtIndexPath:scrollIndexPath
                                    atScrollPosition:UITableViewScrollPositionBottom
                                            animated:NO];

        });
        [self autoScrollTableView];
    }
}

-(void)setInputQuestionsData:(NSString *)quesStr
{
    ChatBotModelClass * cModel = [[ChatBotModelClass alloc]init];
    cModel.QuestionStr = quesStr;
    cModel.createdBy = @"JIM" ;
    [chatBotArr addObject:cModel];
    [_chatTable reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self setAnswersdata:quesStr];
    });
        
}
    
-(void)setAnswersdata:(NSString *)questionStr
{
    
    ChatBotModelClass *cModel = [[ChatBotModelClass alloc]init];
    
    if ([questionStr compare:@"Hello" options:NSCaseInsensitiveSearch] == NSOrderedSame ||[questionStr compare:@"Hi" options:NSCaseInsensitiveSearch] == NSOrderedSame ||[questionStr compare:@"Hey" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"Hello Jim! I am UCB Bot and I make it easy for you:\n 1) To book a Meeting Room\n 2) Raise a support ticket\nYou can type the number to provide your selection";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
        
        
    }else if ([questionStr isEqualToString:@"1"]){
       cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"Excellent!\n Can you give me the Location, meeting room and time of the meeting";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
    }else if ([questionStr compare:@"book mr1 in bangalore for 5th jan 2017 from 2:30 PM to 3:30 PM" options:NSCaseInsensitiveSearch] == NSOrderedSame){
        
      cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"Certainly, you want me to book a meeting room1 in Bangalore location on 4 th Jan 2017 from 11:30 AM to 12:30 PM. Please confirm Yes or No";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
        
        
    }else if ([questionStr compare:@"yes" options:NSCaseInsensitiveSearch] == NSOrderedSame){
        
       cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"It’s better to be sure \nPlease hold while I book the room for you";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ChatBotModelClass *   cModel = [[ChatBotModelClass alloc]init];
            cModel.createdBy = @"";
            cModel.answerStr = @"Congratulation! I have reserved MR1 in Bangalore on 4 th Jan 2017 from 11:30 AM to 12:30 PM Type New if you want me to book another slot, the number for assistance on other services or just type Quit to exit";
            [chatBotArr addObject:cModel];
            [self.chatTable reloadData];
            [self autoScrollTableView];
            
        });
    }else if ([questionStr compare:@"quit" options:NSCaseInsensitiveSearch] == NSOrderedSame){
        
       cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"Happy Meeting! Always here to assist you";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
    }
    else {
        
       cModel = [[ChatBotModelClass alloc]init];
        cModel.createdBy = @"";
        cModel.answerStr = @"Sorry can you be more specific and provide required input";
        [chatBotArr addObject:cModel];
        [self.chatTable reloadData];
        
        
    }
    
    [self autoScrollTableView];
}


    
-(void)autoScrollTableView
{
    NSInteger row = [chatBotArr count]-1;
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [[self chatTable] scrollToRowAtIndexPath:scrollIndexPath
                            atScrollPosition:UITableViewScrollPositionBottom
                                    animated:NO];
}
    
    
- (void) keyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    keyboardSize = kbSize;
    NSLog(@"Keyboard Height: %f Width: %f", kbSize.height, kbSize.width);
    self.textViewContainerViewbottomConstaint.constant = kbSize.height +5.0 ;
    NSLog(@"Keyboard Height: %f ",  self.textViewContainerViewbottomConstaint.constant);
    [_chatTable reloadData];
}
    
- (void) keyboardDidHide:(NSNotification *)note
{
    self.textViewContainerViewbottomConstaint.constant = 8;
}
    
-(void)dismissKeyboard
{
    [self.aTextView resignFirstResponder];
    self.textViewContainerViewbottomConstaint.constant = 3;
}
    
-(void)animationOfView
{
    [UIView animateWithDuration:.1
                              delay:0
                            options:(UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             [self.view layoutIfNeeded];
                         } completion:^(BOOL finished) {
            }];
}
    
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"%lu",(unsigned long)chatBotArr.count);
        return chatBotArr.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexpath = indexPath;
    
    ChatBotTableViewCell *firstCell;
    ChatBotTableViewCell *secondCell;
    
    ChatBotModelClass *cModel =chatBotArr[indexPath.row];
    if ([cModel.createdBy isEqualToString:@"JIM"])
    {
        secondCell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
        secondCell.secondModel = cModel;
        return secondCell;
    }
    else {
        firstCell =[tableView dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
        firstCell.firstModel = cModel;
        return firstCell;
    }
}
    

@end
