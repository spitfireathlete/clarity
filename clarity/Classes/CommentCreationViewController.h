//
//  CommentCreationViewController.h
//  clarity
//
//  Created by Erin Parker on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Idea;
@class Project;

@interface CommentCreationViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) Idea *currentIdea;
@property (strong, nonatomic) Project *currentProject;

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *ideaLabel;

- (IBAction)dismiss:(id)sender;
- (IBAction)saveComment:(id)sender;

@end
