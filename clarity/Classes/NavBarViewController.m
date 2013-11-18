//
//  NavBarViewController.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "NavBarViewController.h"
#import "NavBarHeaderCell.h"

@interface NavBarViewController ()

@end

@implementation NavBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"NavBarHeaderCell" bundle:Nil] forCellReuseIdentifier:@"headercell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Header Cell
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([indexPath isEqual:headerRow]) {
        NavBarHeaderCell *headerCell = (NavBarHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"headercell"];
        headerCell.name.text = @"Nidhi Kulkarni";
        headerCell.jobTitle.text = @"Founder of Spitfire Athlete";
        headerCell.userInteractionEnabled = NO;
        return headerCell;
    }
    
    NSArray *rowTitles = [[NSArray alloc] initWithObjects:@"Feed", @"Dashboard", @"Sync", @"Logout", nil];
    NSArray *iconNames = [[NSArray alloc] initWithObjects:@"globe_icon.png", @"home_icon.png", @"sync_icon.png", @"logout_icon.png", nil];
    

    UITableViewCell *navcell = [tableView dequeueReusableCellWithIdentifier:@"navcell" forIndexPath:indexPath];
    NSString *rowTitle = [rowTitles objectAtIndex:indexPath.row - 1];
    NSString *iconName = [iconNames objectAtIndex:indexPath.row - 1];
    navcell.textLabel.text = [NSString stringWithFormat:@"%@", rowTitle];
    navcell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", iconName]];
    return navcell;

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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
