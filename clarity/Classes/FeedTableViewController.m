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
#import "APIClient.h"
#import "Project.h"
#import "Collaborator.h"
#import "RestObject.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"  
#import "UIImageView+AFNetworking.h"
#import "ProjectViewController.h"

@interface FeedTableViewController ()
@property (nonatomic, strong) NSMutableArray *projects;

@property (nonatomic, strong) Project *selectedProject;
@end

@implementation FeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.projects = [[NSMutableArray alloc] init];

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
    
    // GET Data from API
    [[APIClient sharedClient] getProjectsOnSuccess:^(AFHTTPRequestOperation *operation, id response) {
        
        SFIdentityData *idData =[[SFAccountManager sharedInstance] idData];
        NSLog(@"%@", idData.pictureUrl);
        
        NSLog(@"Project Response: %@", response);
        
        self.projects = [Project projectsWithArray:response];

        NSLog(@"Projects Array: %@", self.projects);
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Project *project = [self.projects objectAtIndex:indexPath.row];
    SFIdentityData *idData =[[SFAccountManager sharedInstance] idData];
    
    FeedCell *feedcell = (FeedCell *)[tableView dequeueReusableCellWithIdentifier:@"feedcell"];
    [feedcell.profilePic setImageWithURL:idData.pictureUrl placeholderImage:[UIImage imageNamed:@"Nidhi_Circle.png"]];
    
    feedcell.name.text = [NSString stringWithFormat:@"%@ %@", [project.owner valueOrNilForKeyPath:@"first_name"], [project.owner valueOrNilForKeyPath:@"last_name"]];
    feedcell.accountName.text = [NSString stringWithFormat:@"%@", [project.priority valueOrNilForKeyPath:@"name"]];
    feedcell.projectQuestion.text = [NSString stringWithFormat:@"%@", project.topic];
    feedcell.numIdeas.text = [NSString stringWithFormat:@"%d", [project.ideas count]];

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
    [self showProjectDetail: indexPath];
    
}

- (void) showProjectDetail:(NSIndexPath *)indexPath {
    self.selectedProject = [self.projects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"presentProjectView" sender:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"presentProjectView"]) {
        ProjectViewController *vc = [segue destinationViewController];
        vc.selectedProject = self.selectedProject;
    }

}

@end
