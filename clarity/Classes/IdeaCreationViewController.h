//
//  IdeaCreationViewController.h
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Project;
@class Idea;

@protocol IdeaCreationDelegate <NSObject>

- (void) ideaCreationViewControllerDismissed: (Idea *)idea;

@end

@interface IdeaCreationViewController : UIViewController <UITextViewDelegate>
{
    __unsafe_unretained id myDelegate;
}

@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UILabel *projectQuestion;

@property (strong, nonatomic) Project *currentProject;

@property (nonatomic, assign) id <IdeaCreationDelegate> myDelegate;

- (IBAction)cancelIdea:(id)sender;
- (IBAction)saveIdea:(id)sender;

@end
