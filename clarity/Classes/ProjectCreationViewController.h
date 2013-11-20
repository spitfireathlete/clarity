//
//  ProjectCreationViewController.h
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPAutoCompleteTextFieldDataSource.h"
#import "MLPAutoCompleteTextFieldDelegate.h"

@interface ProjectCreationViewController : UITableViewController <UITextFieldDelegate, MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menu;

@end
