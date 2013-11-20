//
//  IdeaCell.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IdeaCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *ideaText;
@property (strong, nonatomic) IBOutlet UILabel *voteNum;
@property (strong, nonatomic) IBOutlet UIButton *upVote;
@property (strong, nonatomic) IBOutlet UIButton *downVote;
@property (strong, nonatomic) IBOutlet UIButton *comment;

@end
