//
//  AppDelegate.h
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionnaireFileHandler;
@interface QuestionnaireAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QuestionnaireFileHandler *fileHandler;
@end
