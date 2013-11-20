//
//  CommentCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "CommentCreationViewController.h"
#import "Idea.h"
#import "APIClient.h"
#import "Comment.h"

@interface CommentCreationViewController ()
@property (nonatomic, strong) NSString *comment;
@end

@implementation CommentCreationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ideaLabel.text = self.currentIdea.text;
    [self.textView setDelegate:self];
    [self.textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveComment:(id)sender {
    [self textViewDidEndEditing:self.textView];
    NSString *comment = [NSString stringWithFormat:@"%@", self.textView.text];
    
    [[APIClient sharedClient] addComment:comment forIdea:self.currentIdea inProject:self.currentProject success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
