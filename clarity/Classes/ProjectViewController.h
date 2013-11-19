//
//  ProjectViewController.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *projectQuestion;
@property (strong, nonatomic) IBOutlet UILabel *projectDetails;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
