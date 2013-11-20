//
//  ProjectViewController.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectViewHeaderCell.h"
#import "DetailViewCell.h"
#import "IdeaCell.h"
#import "SWRevealViewController.h"

@interface ProjectViewController ()
@property (nonatomic, strong) NSNumber *segmentedControlState;
@end

@implementation ProjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFBackground.png"]];
    [self.tableView setBackgroundView:backgroundView];

    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaCell" bundle:nil] forCellReuseIdentifier:@"ideaCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectViewHeaderCell" bundle:nil] forCellReuseIdentifier:@"projectViewHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailViewCell" bundle:nil] forCellReuseIdentifier:@"detailViewCell"];
    
    
    // SWRevealViewController
    [_menu setTarget: self.revealViewController];
    [_menu setAction: @selector(revealToggle:)];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Show idea cells first
    self.segmentedControlState = [NSNumber numberWithInteger:0];
    
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
        ProjectViewHeaderCell *headerCell = (ProjectViewHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"projectViewHeaderCell"];
        headerCell.projectQuestion.text = @"How can we better promote the Nike Powerlift to female weightlifters?";
        headerCell.userInteractionEnabled = NO;
        return headerCell;
    }
    
    NSIndexPath *detailsRow = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([indexPath isEqual:detailsRow]) {
        DetailViewCell *detailCell = (DetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"detailViewCell"];
        detailCell.detailText.text = @"We're trying to get our Powerlifting shoe to really take off, but so far Adidas has been killing the market. What other marketing stunts can we pull off to dominate?";
        
        // UI Segmented Control
        [detailCell.segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
        // Switch
        [detailCell.publicSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];

        return detailCell;
    }
    
    if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        // Show Collaborator Cells
        
        NSIndexPath *thirdRow = [NSIndexPath indexPathForRow:2 inSection:0];
        if ([indexPath isEqual:thirdRow]) {
            UITableViewCell *collaboratorCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"collaboratorCell"];
            collaboratorCell.textLabel.text = @"Michael Ellison";
            collaboratorCell.detailTextLabel.text = @"EIR at Riviera Partners";
            collaboratorCell.imageView.image = [UIImage imageNamed:@"tiny_heart_icon.png"];
            
            return collaboratorCell;
        }
        
    } else if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        // Show Idea Cells
        NSIndexPath *thirdRow = [NSIndexPath indexPathForRow:2 inSection:0];
        if ([indexPath isEqual:thirdRow]) {
            IdeaCell *ideaCell = (IdeaCell *)[tableView dequeueReusableCellWithIdentifier:@"ideaCell"];
            ideaCell.userInteractionEnabled = YES;
            return ideaCell;
        }
    }

    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *detailsRow = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *ideaRow = [NSIndexPath indexPathForRow:2 inSection:0];
    
    if ([indexPath isEqual:headerRow]) {
        return 175;
    } else if ([indexPath isEqual:detailsRow]) {
        return 225;
    } else if ([indexPath isEqual:ideaRow]) {
        return 175;
    }
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)indexDidChangeForSegmentedControl: (id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        // Only show idea cells
        NSLog(@"Ideas");
        self.segmentedControlState = [NSNumber numberWithInteger:0];
        [self.tableView reloadData];
        
    } else {
        // Only show collaborator cells
        NSLog(@"Collaborators");
        self.segmentedControlState = [NSNumber numberWithInteger:1];
        [self.tableView reloadData];
    }
    
}

- (void)switchDidChange: (UISwitch *)mySwitch {
    if (mySwitch.on) {
        NSLog(@"%hhd", mySwitch.on);
    } else {
        NSLog(@"Off");
    }
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
