//
//  QuestionnaireTableViewCell.h
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Question;

@interface QuestionnaireTableViewCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier question:(Question*)question;

@end
