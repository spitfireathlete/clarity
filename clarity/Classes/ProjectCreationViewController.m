//
//  ProjectCreationViewController.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "ProjectCreationViewController.h"
#import "ProjectCreationHeaderCell.h"
#import "AccountNameCell.h"
#import "ProjectDetailCell.h"
#import "AddCollaboratorsCell.h"

@interface ProjectCreationViewController ()

@end

@implementation ProjectCreationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectCreationHeaderCell" bundle:nil] forCellReuseIdentifier:@"projectCreationHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountNameCell" bundle:nil] forCellReuseIdentifier:@"accountNameCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectDetailCell" bundle:nil] forCellReuseIdentifier:@"projectDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddCollaboratorsCell" bundle:nil] forCellReuseIdentifier:@"addCollaboratorsCell"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([indexPath isEqual:headerRow]) {
        ProjectCreationHeaderCell *cell = (ProjectCreationHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"projectCreationHeaderCell"];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    NSIndexPath *accountNameRow = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([indexPath isEqual:accountNameRow]) {
        AccountNameCell *cell = (AccountNameCell *)[tableView dequeueReusableCellWithIdentifier:@"accountNameCell"];
        return cell;
    }
    
    NSIndexPath *projectDetailRow = [NSIndexPath indexPathForRow:2 inSection:0];
    if ([indexPath isEqual:projectDetailRow]) {
        ProjectDetailCell *cell = (ProjectDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"projectDetailCell"];
        return cell;
    }
    
    AddCollaboratorsCell *cell = (AddCollaboratorsCell *)[tableView dequeueReusableCellWithIdentifier:@"addCollaboratorsCell"];
    return cell;
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([indexPath isEqual:headerRow]) {
        return 175;
    }
    
    return 70;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}


@end
