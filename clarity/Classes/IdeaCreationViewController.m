//
//  IdeaCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "IdeaCreationViewController.h"
#import "APIClient.h"
#import "SWRevealViewController.h"
#import "ProjectViewController.h"

@interface IdeaCreationViewController ()

@end

@implementation IdeaCreationViewController
@synthesize myDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accountName.text = [NSString stringWithFormat:@"%@", [self.currentProject.priority valueOrNilForKeyPath:@"name"]];
    self.projectQuestion.text = [NSString stringWithFormat:@"%@", self.currentProject.topic];
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_background.png"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (IBAction)cancelIdea:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveIdea:(id)sender {
    [self textViewDidEndEditing:self.textView];
    NSString *idea = [NSString stringWithFormat:@"%@", self.textView.text];
    NSLog(@"Idea: %@", idea);
    
    [[APIClient sharedClient] addIdea:idea inProject:self.currentProject success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Response: %@", response);
        
        Idea *newIdea = [[Idea alloc] initWithDictionary:response];
        NSLog(@"Author: %@", [newIdea.author valueOrNilForKeyPath:@"name"]);
        
        if([self.myDelegate respondsToSelector:@selector(ideaCreationViewControllerDismissed:)])
            {
                [self.myDelegate ideaCreationViewControllerDismissed:newIdea];
            }
        [self dismissViewControllerAnimated:YES completion:nil];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
