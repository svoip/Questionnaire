//
//  MockQuestion.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "TestingQuestionModel.h"
@interface TestingQuestionModel()
{
   NSArray *mockInputArray;
}
@end
@implementation TestingQuestionModel

-(NSArray*)inputsAsArrayOfDictionaries
{
   return _values;
}
@end
