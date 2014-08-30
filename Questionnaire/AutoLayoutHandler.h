//
//  AutoLayoutHandler.h
//  Questionnaire
//
//  Created by Sardorbek on 8/27/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoLayoutHandler : NSObject

void indentViewOnSuperviewExceptForSide(UIView *view, CGFloat indentation, NSLayoutFormatOptions side);
void createGrid(NSArray *views, CGFloat startY, CGFloat spacing);
void pinBodyToHeader(UIView *body, UIView *header);
bool constraintRefersToView(NSLayoutConstraint *constraint, UIView *view);

@end
