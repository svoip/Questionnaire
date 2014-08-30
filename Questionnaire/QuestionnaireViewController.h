//
//  QuestionsViewController.h
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnaireViewController : UITableViewController

@property (strong) id<UITableViewDataSource, UITableViewDelegate> dataSource;
@end
