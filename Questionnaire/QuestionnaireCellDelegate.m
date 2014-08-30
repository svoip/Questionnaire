//
//  QuestionnaireCellDelegate.m
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireCellDelegate.h"
#import "Question.h"
#import "QuestionnaireCheckBox.h"
#import "AutoLayoutHandler.h"

@interface QuestionnaireCellDelegate()
{
   Question *_question;
   UIView *_viewHeader;
   UIView *_viewBody;
   UIView *_container;
   UILabel *_titleLabel;
   NSMutableArray *_touchDetectionViews;
}

@end
@implementation QuestionnaireCellDelegate

-(void)setValue:(id)value forKey:(NSString *)key inContext:(QuestionnaireTouchDetectionView*)ctx
{
   if (_question.type == QuestionTypeSingleChoice)
   {
      for (QuestionnaireTouchDetectionView *touch in _touchDetectionViews)
      {
         if (ctx != touch)
         {
            [(QuestionnaireTouchDetectionView*)touch toggleOff];
         }
      }
   }
   
   [_question updateValue:value forKey:key];
}
-(id)initWithQuestion:(Question *)question
{
   if (self = [self init])
   {
      _question = question;
      _touchDetectionViews = [NSMutableArray array];
   }
   return self;
}

-(UIView*)views
{
   // root view
   _container = [[UIView alloc] init];
   // header view
   _viewHeader = [[UIView alloc] init];
   // body view
   _viewBody = [[UIView alloc] init];
   _titleLabel = [[UILabel alloc] init];
   
   // prepare for autolayout
   _container.translatesAutoresizingMaskIntoConstraints = NO;
   _viewHeader.translatesAutoresizingMaskIntoConstraints = NO;
   _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
   _viewBody.translatesAutoresizingMaskIntoConstraints = NO;
   
   
   _titleLabel.numberOfLines = 0;
   _titleLabel.text = _question.title;
   _titleLabel.textColor = WHITE_COLOR;
   _titleLabel.font = QUESTIONNAIRE_FONT;
   [_viewHeader addSubview:_titleLabel];
   [_container addSubview:_viewHeader];
   _viewHeader.backgroundColor = DARK_COLOR;
   _container.backgroundColor = DARK_COLOR;
   _viewBody.backgroundColor = DARK_COLOR;
   NSInteger count = [[_question inputsAsStrings] count];
   for (NSInteger i=0; i<count; i++)
   {
      NSString *key = [[_question inputsAsStrings] objectAtIndex:i];
      id value = [[[_question inputsAsDictionaries] objectAtIndex:i] objectForKey:key];
      
      QuestionnaireTouchDetectionView *touchDetectView = [[QuestionnaireTouchDetectionView alloc] initWithText:key andInitialValue:value];
      touchDetectView.translatesAutoresizingMaskIntoConstraints = NO;
      touchDetectView.singleChoice = (_question.type == QuestionTypeSingleChoice) ? : YES; NO;
      touchDetectView.delegate = self;
      [_viewBody addSubview:touchDetectView];
      [_touchDetectionViews addObject:touchDetectView];
   }
   [_container addSubview:_viewBody];
   
   // config container
   _container.layer.borderWidth = 2.0f;
   _container.layer.cornerRadius = 5.0f;
   
   return _container;
}
-(void)fixedContstraints
{
   indentViewOnSuperviewExceptForSide(_container, 5.0f, 0);
   indentViewOnSuperviewExceptForSide(_viewHeader, 5.0f, NSLayoutFormatAlignAllBottom);
   indentViewOnSuperviewExceptForSide(_titleLabel, 5.0f, NSLayoutFormatAlignAllBottom);
   pinBodyToHeader(_viewBody, _viewHeader);
}
-(void)flexibleConstraints
{
   createGrid(_touchDetectionViews, 20.0f, 20.0f);
}
@end
