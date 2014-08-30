//
//  UserTouchDetectionView.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionnaireCheckBox.h"


#define QUESTIONNAIRE_FONT  [UIFont fontWithName:@"HelveticaNeue" size:20.0f]

@class QuestionnaireTouchDetectionView;

@protocol QuestionnaireTouchDetectionProtocol <NSObject>

// UTD has this combo "Label+Checkbox", or "Textfield only"
// so we need to return:
// checkbox value (if it's checkbox)
// textfield value (if it's textfield)
-(void)setValue:(id)value forKey:(NSString *)key inContext:(QuestionnaireTouchDetectionView*)ctx;

@end

@interface QuestionnaireTouchDetectionView : UIView <UITextFieldDelegate>
{
   BOOL stateSelected;
}
@property (strong) QuestionnaireCheckBox *questionnaireCheckBox;
@property (weak) id <QuestionnaireTouchDetectionProtocol> delegate;
@property BOOL singleChoice;

//-(id)initWithText:(NSString*)text;
-(void)toggleOff;
-(id)initWithText:(NSString*)text andInitialValue:(id)value;

@end
