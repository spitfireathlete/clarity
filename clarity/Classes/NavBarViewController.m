//
//  NavBarViewController.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "NavBarViewController.h"
#import "NavBarHeaderCell.h"
#import "SWRevealViewController.h"

@interface NavBarViewController ()

@end

@implementation NavBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_background.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"NavBarHeaderCell" bundle:Nil] forCellReuseIdentifier:@"headercell"];
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
    navcell.backgroundColor = [UIColor clearColor];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue isKindOfClass: [SWRevealViewControllerSegue class]]) {
        
        SWRevealViewControllerSegue* rvcs = (SWRevealViewControllerSegue*) segue;
        
        SWRevealViewController* rvc = self.revealViewController;
        
        rvcs.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:dvc];
            [rvc setFrontViewController:nc animated:YES];
        };
    }
}

@end
