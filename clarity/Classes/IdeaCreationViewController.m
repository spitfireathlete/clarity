//
//  IdeaCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "IdeaCreationViewController.h"

@interface IdeaCreationViewController ()

@end

@implementation IdeaCreationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accountName.text = @"Nike";
    self.projectQuestion.text = @"How can we better promote the Nike Powerlift to female weightlifters?";
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_background.png"]];
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (IBAction)cancelIdea:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveIdea:(id)sender {
}
@end
