//
//  ProjectViewController.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Project;

@interface ProjectViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;
@property (nonatomic, strong) Project *selectedProject;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addIdea;
- (IBAction)addIdeaPressed:(id)sender;


@end
