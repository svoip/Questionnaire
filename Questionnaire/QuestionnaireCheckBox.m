//
//  QuestionnaireCheckBox.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireCheckBox.h"
@interface QuestionnaireCheckBox ()
{
   CAShapeLayer *_toggleLayer;
   BOOL _stateOn;
}
-(void)toggleOnCheckBox;
-(void)toggleOffCheckBox;
@end

@implementation QuestionnaireCheckBox
-(id)initWithStateSelected:(BOOL)selected
{
   if (self = [super init])
   {
      self.backgroundColor = [UIColor clearColor];
      self.layer.borderColor = [UIColor darkGrayColor].CGColor;
      self.layer.borderWidth = 2.0f;
      self.layer.cornerRadius = 5.0f;
      _stateOn = selected;
   }
   return self;
}
-(void)drawRect:(CGRect)rect
{
   [super drawRect:rect];
   if (_stateOn)
   {
      [self toggleOnCheckBox];
   }
}
-(CGSize)intrinsicContentSize
{
   return CGSizeMake(40, 40);
}
-(void)updateWithStateSelected:(BOOL)selected
{
   if (selected)
   {
      [self toggleOnCheckBox];
   }
   else
   {
      [self toggleOffCheckBox];
   }
}
-(void)toggleOffCheckBox
{
   [_toggleLayer removeFromSuperlayer];
   _toggleLayer = nil;
}
-(void)toggleOnCheckBox
{
   _toggleLayer = [CAShapeLayer layer];
   CGRect toggleLayerRect = CGRectInset(self.bounds, 8, 8);
   _toggleLayer.backgroundColor = WHITE_COLOR.CGColor;
   _toggleLayer.frame = toggleLayerRect;
   _toggleLayer.cornerRadius = 5.0f;
   [self.layer addSublayer:_toggleLayer];
}
@end
