//
//  QuestionnaireDataSource.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireDataSource.h"
#import "QuestionnaireTableViewCell.h"
#import "QuestionnaireCellDelegate.h"
#import "Question.h"
#import "QuestionnaireFileHandler.h"

static NSString *CellIdentifier = @"QuestionCell";

@interface QuestionnaireDataSource()
{
   NSArray *questionsList;
}
@end

@implementation QuestionnaireDataSource

@synthesize fileHandler;

-(void)setQuestions:(NSArray *)questions
{
   questionsList = questions;
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if ([self isLandscapeOrientation])
      return 200.0f;
   else
      return 220.0f;
   return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   QuestionnaireTableViewCell *cell = [tableView
                                       dequeueReusableCellWithIdentifier:CellIdentifier];
   if (!cell)
   {
      cell = [[QuestionnaireTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier question:[questionsList objectAtIndex:indexPath.row]];
   }
   [cell updateConstraints];
   return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return [questionsList count];
}
-(void)saveQuestions:(id)sender
{
   BOOL fileSaved = [fileHandler writeQuestions:questionsList];
   if (fileSaved)
   {
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"File saved" message:@"File is saved correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [av show];
   }
}
- (BOOL)isLandscapeOrientation
{
   return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
}
@end
