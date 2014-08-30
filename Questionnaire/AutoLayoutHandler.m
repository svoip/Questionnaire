//
//  AutoLayoutHandler.m
//  Questionnaire
//
//  Created by Sardorbek on 8/27/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "AutoLayoutHandler.h"

@implementation AutoLayoutHandler

void createGrid(NSArray *views, CGFloat startY, CGFloat spacing)
{
   if (!views || views.count == 0) return;
   
   UIView *superView = [[views firstObject] superview];
   NSArray *viewConstraints = superView.constraints;
   if (viewConstraints.count)
   {
      [superView removeConstraints:viewConstraints];
   }
   
   UIView *prevView, *nextView;
   NSDictionary *viewBindings;
   NSString *hString, *vString;
   NSArray *rowLeadH, *rowLeadV, *rowTrailH, *rowTrailV;
   
   // place the initial view
   prevView = views[0];
   NSDictionary *d = @{ @"startY": @(startY) };
   hString = [NSString stringWithFormat:@"H:|[prevView]-(>=0)-|"];
   vString = [NSString stringWithFormat:@"V:|-(startY)-[prevView]-(>=0)-|"];
   viewBindings = NSDictionaryOfVariableBindings(prevView);
   
   for (NSString *format in @[hString, vString])
   {
      NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:d views:viewBindings];
      for (NSLayoutConstraint *c in constraints)
      {
         [superView addConstraint:c];
      }
   }
   [superView layoutIfNeeded];
   
   for (NSUInteger i = 0; i < views.count; i++)
   {
      prevView = views[i];
      
      if (i+1 < views.count) {
         nextView = views[i+1];
      }
      else {
         break;
      }
      
      d = @{ @"spacing": @(spacing) };
      hString = [NSString stringWithFormat:@"H:[prevView]-(spacing)-[nextView]"];
      viewBindings = NSDictionaryOfVariableBindings(prevView, nextView);
      
      rowTrailH = [NSLayoutConstraint constraintsWithVisualFormat:hString options:NSLayoutFormatAlignAllTop metrics:d views:viewBindings];
      rowTrailV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[prevView]-(-50)-[nextView]" options:0 metrics:nil views:viewBindings];
      [superView addConstraints:rowTrailH];
      [superView addConstraints:rowTrailV];
      
      [superView layoutIfNeeded];
      
      CGFloat rectGetMaxX = CGRectGetMaxX(nextView.frame);
      CGFloat rectGetMaxViewBounds = CGRectGetMaxX(superView.bounds);
      
      if (rectGetMaxX > rectGetMaxViewBounds)
      {
         [superView removeConstraints:rowTrailH];
         [superView removeConstraints:rowTrailV];
         
         rowLeadH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nextView]" options:NSLayoutFormatAlignAllLeading metrics:nil views:viewBindings];
         
         rowLeadV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[prevView]-[nextView]" options:0 metrics:nil views:viewBindings];
         
         [superView addConstraints:rowLeadV];
         [superView addConstraints:rowLeadH];
      }
      [superView layoutIfNeeded];
   }
   
}
void indentViewOnSuperviewExceptForSide(UIView *view, CGFloat indentation, NSLayoutFormatOptions side)
{
   if (view == nil) return;
   
   NSString *hString, *vString;
   if (side)
   {
      
      /**
       *  this flexible side will have less priority, as when other views push in, these views can give up space on that side
       *
       *  @299 priority
       *
       */
      switch (side) {
         case NSLayoutFormatAlignAllBottom:
            hString = @"H:|-indent-[view]-indent-|";
            vString = @"V:|-indent-[view]-(>=0@299)-|";
            break;
            
         case NSLayoutFormatAlignAllTop:
            hString = @"H:|-indent-[view]-indent-|";
            vString = @"V:|-(>=0@299)-[view]-indent-|";
            break;
            
         case NSLayoutFormatAlignAllLeft:
            hString = @"H:|-(>=0@299)-[view]-indent-|";
            vString = @"V:|-indent-[view]-indent-|";
            break;
            
         case NSLayoutFormatAlignAllRight:
            hString = @"H:|-indent-[view]-(>=0@299)-|";
            vString = @"V:|-indent-[view]-indent-|";
            break;
         default:
            break;
      }
   }
   else
   {
      // indentation occurs on all 4 sides
      hString = @"H:|-indent-[view]-indent-|";
      vString = @"V:|-indent-[view]-indent-|";
   }
   
   NSDictionary *metrics = @{ @"indent": @(indentation) };
   NSDictionary *viewBindings = @{ @"view": view };
   
   for (NSString *format in @[hString, vString])
   {
      NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:viewBindings];
      for (NSLayoutConstraint *c in constraints)
      {
         [view.superview addConstraint:c];
      }
   }
}
bool constraintRefersToView(NSLayoutConstraint *constraint, UIView *view)
{
   if (!view) return NO;
   if (!constraint.firstItem)
      if (constraint.firstItem == view) return YES;
   if (!constraint.secondItem) return NO;
   return (constraint.secondItem == view);
}

void pinBodyToHeader(UIView *body, UIView *header)
{
   if ([body superview] != [header superview]) return;
   
   UIView *superview = [body superview];
   
   // remove vertical constraints affecting the header with the low priority
   NSMutableArray *arr = [NSMutableArray array];
   NSArray *superConstraints = superview.constraints;
   for (NSLayoutConstraint *c in superConstraints)
   {
      BOOL referred = constraintRefersToView(c, header);
      if (referred && c.priority == 299)
      {
         [arr addObject:c];
      }
   }
   if (arr.count)
   {
      [superview removeConstraints:arr];
      [superview layoutIfNeeded];
   }
   
   NSLayoutConstraint *topPin = [NSLayoutConstraint
                                 constraintWithItem:body
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:header
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0 constant:10.0];
   
   NSLayoutConstraint *width = [NSLayoutConstraint
                                constraintWithItem:body
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:header
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0 constant:0.0];
   NSLayoutConstraint *leftOrigin = [NSLayoutConstraint
                                     constraintWithItem:body
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:header
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.0 constant:0.0];
   NSLayoutConstraint *bottomPin = [NSLayoutConstraint
                                    constraintWithItem:body
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:superview
                                    attribute:NSLayoutAttributeBottom
                                    multiplier:1.0 constant:0.0];
   
   [superview addConstraint:topPin];
   [superview addConstraint:width];
   [superview addConstraint:leftOrigin];
   [superview addConstraint:bottomPin];
}

@end
