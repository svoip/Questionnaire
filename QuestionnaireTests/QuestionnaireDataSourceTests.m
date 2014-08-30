//
//  QuestionnaireDataSourceTests.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionnaireDataSource.h"
#import "TestingQuestionModel.h"
#import "TestingTableViewCell.h"
#import "QuestionnaireTableViewCell.h"

@interface QuestionnaireDataSourceTests : XCTestCase
{
   QuestionnaireDataSource *dataSource;
   TestingQuestionModel *question1, *question2;
}
@end

@implementation QuestionnaireDataSourceTests

- (void)setUp
{
   [super setUp];
   dataSource = [[QuestionnaireDataSource alloc] init];
   question1 = [[TestingQuestionModel alloc] init];
   question2 = [[TestingQuestionModel alloc] init];
}
- (void)tearDown
{
   dataSource = nil;
   question1 = nil;
   question2 = nil;
   [super tearDown];
}
-(void)testDataSourceItemsCount
{
   [dataSource setQuestions:[NSArray arrayWithObject:question1]];
   XCTAssertEqual([dataSource tableView:nil numberOfRowsInSection:0], (NSInteger)1,
                  @"There is one question in the data source");
   [dataSource setQuestions:[NSArray arrayWithObjects:question1, question2, nil]];
   XCTAssertEqual([dataSource tableView:nil numberOfRowsInSection:0], (NSInteger)2,
                  @"There are now two questions in the data source");
}
-(NSArray*)numberOfView:(Class)classOfView inParentView:(UIView*)parent
{
   NSMutableArray *a = [NSMutableArray array];
   for (UIView *v in [parent subviews])
   {
      if ([v isKindOfClass:classOfView])
      {
         [a addObject:v];
      }
      [a addObjectsFromArray:(NSArray*)[self numberOfView:classOfView inParentView:v]];
   }
   return [NSArray arrayWithArray:a];
}
-(void)testOpenEndedQuestionReceivesATextField
{
   Question *openEnded = [[TestingQuestionModel alloc] initWithTitle:@"An open-ended question" type:QuestionTypeOpenEnded inputValues:nil];
   [dataSource setQuestions:[NSArray arrayWithObject:openEnded]];
   NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
   QuestionnaireTableViewCell *cell = (QuestionnaireTableViewCell*)[dataSource tableView:nil cellForRowAtIndexPath:indexpath];

   Class textFieldClass = [UITextField class];
   NSArray *objOccurrences = [self numberOfView:textFieldClass inParentView:cell.contentView];
   XCTAssertEqual(objOccurrences.count, (NSInteger)1, @"There must be one occurrence of textfield in the view");
}
@end
