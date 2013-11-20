//
//  DashboardViewController.m
//  
//
//  Created by Erin Parker on 11/19/13.
//
//

#import "DashboardViewController.h"
#import "DashboardHeaderCell.h"
#import "DashboardProjectCell.h"
#import "SWRevealViewController.h"
#import "Project.h"
#import "APIClient.h"

@interface DashboardViewController ()
@property (nonatomic, strong) NSArray *projects;
@end

@implementation DashboardViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_sf.png"]];
    [self.tableView setBackgroundView:backgroundView];

    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"DashboardHeaderCell" bundle:nil] forCellReuseIdentifier:@"dashboardHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DashboardProjectCell" bundle:nil] forCellReuseIdentifier:@"dashboardProjectCell"];
    
    // SWRevealViewController
    [_menu setTarget: self.revealViewController];
    [_menu setAction: @selector(revealToggle:)];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // GET Data from API
    [[APIClient sharedClient] getProjectsOnSuccess:^(AFHTTPRequestOperation *operation, id response) {
        
        self.projects = [Project projectsWithArray:response];
        
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
    return [self.projects count] +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([indexPath isEqual:headerRow]) {
        DashboardHeaderCell *headerCell = (DashboardHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardHeaderCell"];
        headerCell.userInteractionEnabled = NO;
        
        headerCell.name.text = @"Nidhi Kulkarni's Dashboard";
        headerCell.jobTitle.text = @"Founder of Spitfire Athlete";
        
        headerCell.numProjects.text = @"13";
        headerCell.numIdeas.text = @"23";
        
        return headerCell;
    }
    
    Project *project = [self.projects objectAtIndex:indexPath.row -1];
    
    DashboardProjectCell *projectCell = (DashboardProjectCell *)[tableView dequeueReusableCellWithIdentifier:@"dashboardProjectCell"];
    projectCell.accountName.text = [NSString stringWithFormat:@"%@", [project.priority valueOrNilForKeyPath:@"name"]];
    projectCell.question.text = [NSString stringWithFormat:@"%@", project.topic];
    projectCell.numIdeas.text = [NSString stringWithFormat:@"%d", [project.ideas count]];
    return projectCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    
    if ([indexPath isEqual:headerRow]) {
        return 150;
    }
    
    return 140;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
