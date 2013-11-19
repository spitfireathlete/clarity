//
//  FeedCell.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePic;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *accountName;
@property (strong, nonatomic) IBOutlet UILabel *projectQuestion;
@property (strong, nonatomic) IBOutlet UILabel *numFaves;
@property (strong, nonatomic) IBOutlet UILabel *numIdeas;

@end
