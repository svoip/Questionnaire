//
//  QuestionInputTests.m
//  Questionnaire
//
//  Created by Sardorbek on 8/20/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestingQuestionModel.h"

@interface QuestionInputTests : XCTestCase
{
   TestingQuestionModel *question;
   NSArray *inputs;
}
@end

@implementation QuestionInputTests

- (void)setUp
{
   [super setUp];
   inputs = [NSArray arrayWithObjects:@"Yes", @"No", nil];
   question = [[TestingQuestionModel alloc] initWithTitle:@"A title" type:QuestionTypeMultipleChoice inputValues:inputs];
}
- (void)tearDown
{
   question = nil;
   inputs = nil;
   [super tearDown];
}
-(void)testQuestionHasTheCorrectNumberOfInputs
{
   XCTAssertTrue([[question inputsAsStrings] count], @"Inputs have to be more than 0");
   XCTAssertEqual([[question inputsAsStrings] count], (NSInteger)2, @"The question must have 2 input values");
}
-(void)testInputValuesAreStoredAsDictionary
{
   id inputValue = [[question inputsAsDictionaries] lastObject];
   XCTAssertTrue([inputValue isKindOfClass:[NSDictionary class]],
                 @"These values must be of dictionary type");
}
-(void)testQuestionsMustConstructInputAtConstructorMethod
{
   Question *questionWithoutInputs = [[TestingQuestionModel alloc] initWithTitle:@"Question without given inputs" type:QuestionTypeSingleChoice inputValues:nil];

   XCTAssertNotNil(questionWithoutInputs.inputsAsStrings, @"Inputs can't be nil");
   XCTAssertNotNil(questionWithoutInputs.inputsAsDictionaries, @"Inputs can't be nil");
}
-(void)testQuestionWithTypeSpecifiedDefaultsToSingleChoiceQuestion
{
   Question *questionWithNoType = [[TestingQuestionModel alloc] initWithTitle:@"Question without given type" type:QuestionTypeNone inputValues:nil];
   XCTAssertTrue(questionWithNoType.type == QuestionTypeSingleChoice, @"Single choice is the default question type");
}
-(void)testQuestionInputValuesAreAtLeastOne
{
   Question *questionWithNoType = [[TestingQuestionModel alloc] initWithTitle:@"Question without given type" type:QuestionTypeNone inputValues:nil];
   XCTAssertEqual([[questionWithNoType inputsAsStrings] count], (NSInteger)1, @"Question without given input values must still have 1 input");
}
-(void)testDefaultInputKeyIsNSNull
{
   Question *questionWithNoType = [[TestingQuestionModel alloc] initWithTitle:@"Question without given type" type:QuestionTypeNone inputValues:nil];
   NSDictionary *dictionary = [[questionWithNoType inputsAsDictionaries] lastObject];
   NSString *key = [[dictionary allKeys] lastObject];
   XCTAssertTrue([[dictionary objectForKey:key] isKindOfClass:[NSNull class]], @"The default must be set to 'null'");
}
-(void)testUpdateQuestionValueForTheGivenKey
{
   NSString *key = @"Yes";
   [question updateValue:@"1" forKey:key];
   NSArray *array = [question inputsAsDictionaries];
   for (NSDictionary *dict in array)
   {
      if ([dict objectForKey:key])
      {
         NSString *v = [dict objectForKey:key];
         XCTAssertTrue([v isEqualToString:@"1"], @"The value must now be 1");
         break;
      }
   }
}
-(void)testInputAreConvertedToDictionaries
{
   id d = [[question inputsAsArrayOfDictionaries] lastObject];
   XCTAssertTrue([d isKindOfClass:[NSDictionary class]], @"The input type must be a dictionary");
}

@end
