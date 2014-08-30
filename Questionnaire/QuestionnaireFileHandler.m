//
//  QuestionnaireFileHandler.m
//  Questionnaire
//
//  Created by Sardorbek on 8/19/14.
//  Copyright (c) 2014 Sardorbek. All rights reserved.
//

#import "QuestionnaireFileHandler.h"
#import "Question.h"

@implementation QuestionnaireFileHandler

-(NSArray*)readQuestions
{
   NSMutableArray *models = [NSMutableArray array];
   NSString *filePath = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"json"];
   if ([filePath length])
   {
      NSError *readError;
      NSData *questionsData = [[NSData alloc] initWithContentsOfFile:filePath options:NSMappedRead error:&readError];
      if (!readError)
      {
         NSError *parseError;
         NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:questionsData options:NSJSONReadingMutableContainers error:&parseError];
         if (!parseError && dictionary)
         {
            NSMutableDictionary *questionsDictionary = [dictionary objectForKey:@"questions"];
            for (NSMutableDictionary *singleQuestion in questionsDictionary)
            {
               QuestionType type = QuestionTypeNone;
               NSString *questionType = [singleQuestion objectForKey:@"type"];
               if ([questionType isEqualToString:@"QuestionTypeSingleChoice"])
               {
                  type = QuestionTypeSingleChoice;
               }
               else if ([questionType isEqualToString:@"QuestionTypeOpenEnded"])
               {
                  type = QuestionTypeOpenEnded;
               }
               else if ([questionType isEqualToString:@"QuestionTypeMultipleChoice"])
               {
                  type = QuestionTypeMultipleChoice;
               }
               NSMutableDictionary *inputs = [singleQuestion objectForKey:@"inputs"];
               NSMutableArray *inputsArray = [NSMutableArray array];
               for (NSDictionary *input in inputs)
               {
                  [inputsArray addObject:input];
               }
               Question *question = [[Question alloc] initWithTitle:[singleQuestion objectForKey:@"title"] type:type inputValues:inputsArray];
               [models addObject:question];
            }
         }
      }
      
   }
   if (![models count])
   {
      [[NSException exceptionWithName:@"Model data" reason:@"Model data is not valid" userInfo:nil] raise];
   }
   return models;
}

-(BOOL)writeQuestions:(NSArray *)array
{
   NSString *documentsFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
   NSDate *now = [NSDate date];
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"dd-MM-yyyy HH:MM:SS"];
   NSString *dateInString = [formatter stringFromDate:now];
   NSString *filePath = [NSString stringWithFormat:@"/output_%@.json", dateInString];
   filePath = [documentsFolder stringByAppendingString: filePath];
   NSError *writeError;
   
   NSMutableArray *questions = [NSMutableArray array];
   NSMutableDictionary *d;
   for (Question *question in array) {
      d = [NSMutableDictionary dictionary];
      [d setValue:question.title forKey:@"title"];
      NSString *questionType;
      switch (question.type) {
         case QuestionTypeMultipleChoice:
            questionType = @"QuestionTypeMultipleChoice";
            break;
         case QuestionTypeSingleChoice:
            questionType = @"QuestionTypeSingleChoice";
            break;
         case QuestionTypeOpenEnded:
            questionType = @"QuestionTypeOpenEnded";
            break;
         case QuestionTypeNone:
         default:
            questionType = @"QuestionTypeNone";
            break;
      }
      
      [d setValue:questionType forKeyPath:@"type"];
      [d setValue:question.inputsAsDictionaries forKeyPath:@"inputs"];
      [questions addObject:d];
   }
   
   NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"questions": questions}
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&writeError];
   if (writeError == nil && [jsonData writeToFile:filePath atomically:YES])
      return YES;
   return NO;
}

@end
