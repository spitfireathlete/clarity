//
//  AccountNameCell.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextField.h"

@interface AccountNameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet MLPAutoCompleteTextField *accountName;
@end
