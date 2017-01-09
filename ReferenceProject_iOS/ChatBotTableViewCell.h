//
//  ChatBotTableViewCell.h
//  ReferenceProject_iOS
//
//  Created by Vmoksha on 09/01/17.
//  Copyright © 2017 vmoksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBotModelClass.h"

@interface ChatBotTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@property(nonatomic,strong)ChatBotModelClass *firstModel;
@property(nonatomic,strong)ChatBotModelClass *secondModel;
@property (weak, nonatomic) IBOutlet UIView *firstLabelContainerView;
@property (weak, nonatomic) IBOutlet UIView *secondLabelContainerView;


@property (weak, nonatomic) IBOutlet UIView *firstCellHoldingView;

@property (weak, nonatomic) IBOutlet UIView *secondCellHoldingView;





@end
