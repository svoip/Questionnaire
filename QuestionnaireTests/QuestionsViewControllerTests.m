//
//  QuestionsViewControllerTests.m
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "QuestionnaireViewController.h"
#import "QuestionnaireDataSource.h"

@interface QuestionsViewControllerTests : XCTestCase
{
   QuestionnaireViewController *viewController;
   QuestionnaireDataSource *dataSource;
}
@end

@implementation QuestionsViewControllerTests

- (void)setUp
{
   [super setUp];
   viewController = [[QuestionnaireViewController alloc] init];
}
- (void)tearDown
{
   viewController = nil;
   [super tearDown];
}
-(void)testViewControllerHasDataSource
{
   objc_objectptr_t property = class_getProperty([viewController class], "dataSource");
   XCTAssertTrue(property != NULL, @"The view controller needs a datasource");
}
-(void)testTableViewDoesNotAllowSelection
{
   [viewController viewDidLoad];
   XCTAssertFalse(viewController.tableView.allowsSelection, @"Table cells can't be selected");
}

@end
