//
//  UserTouchDetectionViewTests.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionnaireTouchDetectionView.h"
#import "TestingTouchDetectionView.h"
#import "QuestionnaireCheckBox.h"

@interface QuestionnaireTouchDetectionViewTests : XCTestCase
{
   QuestionnaireTouchDetectionView *view;
}
@end

@implementation QuestionnaireTouchDetectionViewTests

- (void)setUp
{
   [super setUp];
   view = [[QuestionnaireTouchDetectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
}
- (void)tearDown
{
   view = nil;
   [super tearDown];
}
-(void)testViewHasFrame
{
   XCTAssertNotEqual((CGFloat)0, view.frame.size.width, @"View must have some visible frame");
   XCTAssertNotEqual((CGFloat)0, view.frame.size.height, @"View must have some visible frame");
}
-(void)testTouchDetectionViewStateIsOff
{
   TestingTouchDetectionView *touchView = [[TestingTouchDetectionView alloc] initWithText:@"Foo" andInitialValue:[NSNumber numberWithInt:1]];
   [touchView toggleOff];
   XCTAssertFalse([touchView isStateSelected], @"The state of the view must be 'toggled off'");
}

@end
