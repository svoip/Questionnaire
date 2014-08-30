//
//  Question.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "Question.h"
@interface Question()
@end

@implementation Question
-(QuestionType)type
{
   return _type;
}
-(NSString*)title
{
   return _title;
}
-(NSArray*)inputsAsStrings
{
   // return only the key for each dictionary value
   NSMutableArray *a = [NSMutableArray array];
   for (NSDictionary *d in _values)
   {
      NSArray *arr = [d allKeys];
      NSString *theKey = [arr lastObject];
      [a addObject:theKey];
   }
   return a;
}
-(NSArray*)inputsAsDictionaries
{
   return _values;
}
-(id)initWithTitle:(NSString *)title type:(QuestionType)type inputValues:(NSArray *)values
{
   if (self = [super init])
   {
      _title = title;
      _type = type;
      if (type == QuestionTypeNone)
      {
         _type = QuestionTypeSingleChoice;
      }
      
      NSMutableArray *tmpArr = [NSMutableArray array];
      
      if ([values count])
      {
         for (id val in values)
         {
            NSMutableDictionary *md;
            if ([val isKindOfClass:[NSDictionary class]])
            {
               md = val;
            }
            else
            {
               md = [NSMutableDictionary dictionary];
               [md setObject:[NSNull null] forKey:val]; // set <null> for default value
            }
            [tmpArr addObject:md];
         }
      }
      else
      {
         NSMutableDictionary *d = [NSMutableDictionary dictionary];
         [d setObject:[NSNull null] forKey:TEXTFIELD_KEY]; // a textfield will be set here
         [tmpArr addObject:d];
      }
      
      _values = tmpArr;
   }
   return self;
}
-(void)updateValue:(id)value forKey:(NSString *)key
{
   for (NSDictionary *d in _values)
   {
      NSString *k = [[d allKeys] lastObject];
      
      // update the effected value
      if ([k isEqualToString:key])
      {
         NSNumber *numValue = [d objectForKey:key];
         if (![numValue isEqual:value])
         {
            [d setValue:value forKey:key];
            break;
         }
         
      }
   }

  // updating other fields
   if (self.type == QuestionTypeSingleChoice)
   {
      for (NSDictionary *d in _values)
      {
         NSString *k = [[d allKeys] lastObject];
         if (![k isEqualToString:key])
         {
            [d setValue:[NSNull null] forKey:k];
         }
      }
   }
}
@end
