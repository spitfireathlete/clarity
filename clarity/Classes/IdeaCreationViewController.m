//
//  IdeaCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "IdeaCreationViewController.h"
#import "APIClient.h"

@interface IdeaCreationViewController ()

@end

@implementation IdeaCreationViewController

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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
