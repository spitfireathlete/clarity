//
//  FeedTableViewController.m
//  clarity
//
//  Created by Erin Parker on 11/17/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "FeedTableViewController.h"
#import "FeedCell.h"
#import "SWRevealViewController.h"

@interface FeedTableViewController ()

@end

@implementation FeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_sf.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    // Nav Bar Formatting
    self.title = @"clarity";

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.318 green:0.769 blue:0.831 alpha:1.0]]; /*#51c4d4*/
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"AvenirNext-Bold" size:20.0f], NSFontAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    
    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"FeedCell" bundle:Nil] forCellReuseIdentifier:@"feedcell"];
    
    // SWRevealViewController
    [_menuButton setTarget: self.revealViewController];
    [_menuButton setAction: @selector(revealToggle:)];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    FeedCell *feedcell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:@"feedcell"];
    feedcell.profilePic.image = [UIImage imageNamed:@"Nidhi_Circle.png"];
    feedcell.name.text = @"Nidhi Kulkarni";
    feedcell.accountName.text = @"Lululemon SF";
    feedcell.projectQuestion.text = @"How can we promote our new shoe, Nike Powerlift, to female weightlifters and female powerlifters?";
    feedcell.numFaves.text = @"234";
    feedcell.numFaves.text = @"123";

    feedcell.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    return feedcell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
