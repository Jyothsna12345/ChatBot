//
//  ChatBotTableViewCell.m
//  ReferenceProject_iOS
//
//  Created by Vmoksha on 09/01/17.
//  Copyright © 2017 vmoksha. All rights reserved.
//

#import "ChatBotTableViewCell.h"

@implementation ChatBotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.firstLabelContainerView.layer.cornerRadius = 10;
    self.secondLabelContainerView.layer.cornerRadius = 10;

    self.firstCellHoldingView.backgroundColor = [UIColor colorWithRed:0.71 green:0.96 blue:0.70 alpha:1.0];
    self.secondCellHoldingView.backgroundColor = [UIColor colorWithRed:1.0 green:0.61 blue:0.25 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFirstModel:(ChatBotModelClass *)firstModel
{
    _firstModel = firstModel;
    self.firstLabel.text = _firstModel.answerStr;

}

-(void)setSecondModel:(ChatBotModelClass *)secondModel
{
    _secondModel = secondModel;
    self.secondLabel.text = _secondModel.QuestionStr;
}



@end
