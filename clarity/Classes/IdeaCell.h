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

- (IBAction)comment:(id)sender;
- (IBAction)upVote:(id)sender;
- (IBAction)downVote:(id)sender;

@end
