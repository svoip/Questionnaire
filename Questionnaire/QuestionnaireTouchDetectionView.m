//
//  UserTouchDetectionView.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireTouchDetectionView.h"
#import "QuestionnaireCheckBox.h"
#import "Question.h"
#import "AutoLayoutHandler.h"

@interface QuestionnaireTouchDetectionView()
{
   UILabel                *questionnaireLabel;
   QuestionnaireCheckBox  *questionnaireCheckBox;
   UITextField            *questionnaireTextField;
   UITapGestureRecognizer *gesture;
   BOOL questionHasTextField;
   NSString *textFieldText;
}
-(void)toggleTheControl;
@end

@implementation QuestionnaireTouchDetectionView
@synthesize questionnaireCheckBox, delegate, singleChoice;

-(id)initWithText:(NSString *)text andInitialValue:(id)value
{
   if (self = [super init])
   {
      if (![value isKindOfClass:[NSNull class]])
      {
         if ([value isKindOfClass:[NSString class]])
         {
            textFieldText = value;
         }
         else if ([value isKindOfClass:[NSNumber class]])
         {
            NSNumber *number = (NSNumber*)value;
            if ([number intValue] != 0)
               stateSelected = YES;
         }
         
      }
      
      [self setupWithText:text];
   }
   return self;
}
-(void)toggleOnLabel
{
   questionnaireLabel.textColor = WHITE_COLOR;
}
-(void)toggleOffLabel
{
   questionnaireLabel.textColor = DARK_GRAY_COLOR;
}
-(void)updateLabel
{
   if (stateSelected)
   {
      [self toggleOnLabel];
   }
   else
   {
      [self toggleOffLabel];
   }
}
-(void)toggleTheControl
{
   stateSelected = !stateSelected;

   [questionnaireCheckBox updateWithStateSelected:stateSelected];

   [self updateLabel];
   
   NSNumber *checkBoxValue = [NSNumber numberWithBool:stateSelected];
   [delegate setValue:checkBoxValue forKey:questionnaireLabel.text inContext:self];

}
-(void)toggleOff
{
   stateSelected = NO;
   [self updateLabel];
   [questionnaireCheckBox updateWithStateSelected:stateSelected];
}
#pragma mark - initializer
-(void)setupWithText:(NSString*)text
{
   if ([text isEqualToString:TEXTFIELD_KEY])
   {
      questionHasTextField = YES;
   }

   if (questionHasTextField)
   {
      questionnaireTextField = [[UITextField alloc] init];
      questionnaireTextField.layer.borderColor = [UIColor darkGrayColor].CGColor;
      questionnaireTextField.layer.borderWidth = 2.0f;
      questionnaireTextField.layer.cornerRadius = 5.0f;
      questionnaireTextField.font = QUESTIONNAIRE_FONT;
      questionnaireTextField.delegate = self;
      questionnaireTextField.text = textFieldText;
      questionnaireTextField.textColor = WHITE_COLOR;
      questionnaireTextField.borderStyle = UITextBorderStyleBezel;
      [self addSubview:questionnaireTextField];
   }
   else
   {
      questionnaireCheckBox = [[QuestionnaireCheckBox alloc] initWithStateSelected: stateSelected];
      [self addSubview:questionnaireCheckBox];
      
      questionnaireLabel = [[UILabel alloc] init];
      questionnaireLabel.text = text;
      questionnaireLabel.font = QUESTIONNAIRE_FONT;
      if (stateSelected) questionnaireLabel.textColor = WHITE_COLOR;
      else               questionnaireLabel.textColor = DARK_GRAY_COLOR;

      [self addSubview:questionnaireLabel];
   }

   // prepare for autolayout
   questionnaireLabel.translatesAutoresizingMaskIntoConstraints = NO;
   questionnaireCheckBox.translatesAutoresizingMaskIntoConstraints = NO;
   questionnaireTextField.translatesAutoresizingMaskIntoConstraints = NO;
   
   gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
   [self addGestureRecognizer:gesture];
}

-(CGSize)intrinsicContentSize
{
   return CGSizeMake(200, 50);
}
-(void)singleTap:(UITapGestureRecognizer*)gesture
{
   [self toggleTheControl];
}
-(void)updateConstraints
{
   [super updateConstraints];
   [self addConstraints];
}
-(void)addConstraints
{
   NSDictionary *viewsDictionary;
   NSString *verticalFormat;
   NSString *horizontalFormat;
   if (questionHasTextField)
   {
      viewsDictionary = NSDictionaryOfVariableBindings(questionnaireTextField);
      
      verticalFormat = [NSString stringWithFormat: @"V:|-5-[questionnaireTextField]-5-|"];
      horizontalFormat = [NSString stringWithFormat: @"H:|-10-[questionnaireTextField(300)]"];
   
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
        options:0 metrics:nil views:viewsDictionary]];
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
        options:0 metrics:nil views:viewsDictionary]];
   }
   else
   {
      viewsDictionary = NSDictionaryOfVariableBindings(questionnaireLabel, questionnaireCheckBox);

      verticalFormat = [NSString stringWithFormat: @"V:|-5-[questionnaireCheckBox]"];
      horizontalFormat = [NSString stringWithFormat: @"H:|-10-[questionnaireCheckBox]"];
      
      // userTouchDetectionCheckBox
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
        options:0 metrics:nil views:viewsDictionary]];
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
        options:0 metrics:nil views:viewsDictionary]];
      
      verticalFormat = [NSString stringWithFormat: @"V:|-15-[questionnaireLabel]"];
      horizontalFormat = [NSString stringWithFormat: @"H:|-65-[questionnaireLabel]"];
      
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
        options:0 metrics:nil views:viewsDictionary]];
      [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
        options:0 metrics:nil views:viewsDictionary]];
   }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   [delegate setValue:textField.text forKey:TEXTFIELD_KEY inContext:self];
   return YES;
}

@end
