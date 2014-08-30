//
//  QuestionnaireAppDelegateTests.m
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "QuestionnaireAppDelegate.h"
#import "QuestionnaireViewController.h"

@interface QuestionnaireAppDelegateTests : XCTestCase
{
   QuestionnaireAppDelegate *appDelegate;
   UINavigationController *navigationController;
   QuestionnaireViewController *viewController;
}
@end

@implementation QuestionnaireAppDelegateTests

- (void)setUp
{
   [super setUp];
   appDelegate = [[UIApplication sharedApplication] delegate];
   navigationController = (UINavigationController*)appDelegate.window.rootViewController;
   viewController = (QuestionnaireViewController*)navigationController.topViewController;
}

- (void)tearDown
{
   appDelegate = nil;
   navigationController = nil;
   viewController = nil;
   [super tearDown];
}
-(void)testAppDelegate
{
   XCTAssertNotNil(appDelegate, @"There must be a valid app delegate");
   XCTAssertNotNil(appDelegate.window, @"App delegate must have a window");
   XCTAssertNotNil(navigationController, @"Nagivation controller must be present");
   XCTAssertNotNil(viewController, @"Top view controller must be set");
}
-(void)testViewControllerHasADataSource
{
   XCTAssertNotNil(viewController.dataSource, @"Data source must be set");
}
-(void)testViewControllerDataSourceReturnsObjects
{
   XCTAssertTrue([viewController.dataSource tableView:nil numberOfRowsInSection:0] > 0,
                 @"Data souce must return objects");
}

@end
