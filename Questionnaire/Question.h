//
//  Question.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TEXTFIELD_KEY @"textFieldKey"

typedef NS_ENUM (NSInteger, QuestionType)
{
 	QuestionTypeSingleChoice,
	QuestionTypeMultipleChoice,
	QuestionTypeOpenEnded,
   QuestionTypeNone
};

@interface Question : NSObject
{
   NSString *_title;
   QuestionType _type;
   NSArray *_values;
}

-(id)initWithTitle:(NSString*)title type:(QuestionType)type inputValues:(NSArray*)values;
-(void)updateValue:(id)value forKey:(NSString*)key;
-(NSString*)title;
-(NSArray*)inputsAsStrings;
-(NSArray*)inputsAsDictionaries;
-(QuestionType)type;
@end
