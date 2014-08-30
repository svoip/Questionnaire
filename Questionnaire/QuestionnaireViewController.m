//
//  QuestionsViewController.m
//  Questionnaire
//
//  Created by Sardorbek on 8/18/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireViewController.h"

@interface QuestionnaireViewController ()

@end

@implementation QuestionnaireViewController
@synthesize dataSource;
- (void)viewDidLoad
{
   [super viewDidLoad];
   self.title = @"Questionnaire";
   self.tableView.dataSource = self.dataSource;
   self.tableView.delegate = self.dataSource;
   self.tableView.allowsSelection = NO;
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.tableView.backgroundColor = [UIColor darkGrayColor];
   
   if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
   {
      [self.tableView setSeparatorInset:UIEdgeInsetsZero];
   }
   UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.dataSource action:@selector(saveQuestions:)];
   self.navigationItem.rightBarButtonItem = addButton;
}
-(void)saveQuestions:(id)sender
{
   // to silence the "undeclared selector" warning
}
@end
