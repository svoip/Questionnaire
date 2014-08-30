//
//  QuestionnaireTableViewCell.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireTableViewCell.h"
#import "Question.h"
#import "QuestionnaireTouchDetectionView.h"
#import "QuestionnaireCellDelegate.h"

@interface QuestionnaireTableViewCell ()
{
   QuestionnaireCellDelegate *cellDelegate;
   BOOL didUpdate;
}
@end
@implementation QuestionnaireTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier question:(Question *)question
{
   self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
   if (self)
   {
      cellDelegate = [[QuestionnaireCellDelegate alloc] initWithQuestion:question];
      [self.contentView addSubview:[cellDelegate views]];
   }
   return self;
}
-(void)layoutSubviews
{
   [super layoutSubviews];
   [cellDelegate flexibleConstraints];
}
-(void)updateConstraints
{
   [super updateConstraints];
   if (didUpdate) return;
   [cellDelegate fixedContstraints];
   didUpdate = YES;
}
@end
