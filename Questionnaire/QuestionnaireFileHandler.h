//
//  QuestionnaireFileHandler.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionnaireFileHandler : NSObject

-(NSArray*)readQuestions;
-(BOOL)writeQuestions:(NSArray*)array;

@end
