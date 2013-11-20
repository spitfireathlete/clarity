//
//  CommentCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "CommentCreationViewController.h"
#import "Idea.h"

@interface CommentCreationViewController ()

@end

@implementation CommentCreationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ideaLabel.text = self.currentIdea.text;
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveComment:(id)sender {
}

@end
