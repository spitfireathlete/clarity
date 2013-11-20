//
//  ProjectCreationHeaderCell.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCreationHeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *writeIcon;
@property (strong, nonatomic) IBOutlet UILabel *instructionText1;
@property (strong, nonatomic) IBOutlet UILabel *instructionText2;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
