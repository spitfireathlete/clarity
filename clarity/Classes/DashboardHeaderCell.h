//
//  DashboardHeaderCell.h
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardHeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *jobTitle;
@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *numProjects;
@property (strong, nonatomic) IBOutlet UILabel *numIdeas;

@end
