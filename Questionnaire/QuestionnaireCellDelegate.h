//
//  QuestionnaireCellDelegate.h
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionnaireTouchDetectionView.h"

@class Question;

@interface QuestionnaireCellDelegate : NSObject <QuestionnaireTouchDetectionProtocol>
-(id)initWithQuestion:(Question*)question;
-(UIView*)views;
-(void)fixedContstraints;
-(void)flexibleConstraints;
@end
