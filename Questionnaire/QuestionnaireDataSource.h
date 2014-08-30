//
//  QuestionnaireDataSource.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionnaireFileHandler;
@interface QuestionnaireDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) QuestionnaireFileHandler *fileHandler;
-(void)setQuestions:(NSArray*)questions;

@end
