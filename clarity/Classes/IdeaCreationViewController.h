//
//  IdeaCreationViewController.h
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;

@interface IdeaCreationViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UILabel *projectQuestion;

@property (strong, nonatomic) Project *currentProject;

- (IBAction)cancelIdea:(id)sender;
- (IBAction)saveIdea:(id)sender;

@end
