//
//  QuestionnaireCheckBox.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuestionnaireCheckBox : UIView

-(id)initWithStateSelected:(BOOL)selected;
-(void)updateWithStateSelected:(BOOL)selected;
@end
