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
#import "APIClient.h"
#import "Project.h"
#import "Comment.h"
#import "Idea.h"
#import "Collaborator.h"
#import "CommentCreationViewController.h"
#import "CommentCell.h"
#import "IdeaCreationViewController.h"

@interface ProjectViewController ()
@property (nonatomic, strong) NSNumber *segmentedControlState;
@property (nonatomic, strong) NSArray *collaborators;
@property (nonatomic, strong) NSMutableArray *ideas;
@end

@implementation ProjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFBackground.png"]];
    [self.tableView setBackgroundView:backgroundView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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

    // Retrieve ideas
    self.ideas = [[NSMutableArray alloc] initWithArray:[self.selectedProject ideas]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    IdeaCreationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"IdeaCreationViewController"];
    vc.myDelegate = self;
    
    // Retrieve collaborators
    [[APIClient sharedClient] getCollaboratorsForProject:self.selectedProject success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.collaborators = [Collaborator collaboratorsWithArray:response];
        NSLog(@"Selected Project: %@", self.selectedProject);
        NSLog(@"%@", response);
        
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
    if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        // Collaborator Cells
        return [self.collaborators count] + 2;

    } else if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        // Idea Cells
        return [self.ideas count] + 2;
    }
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    if ([indexPath isEqual:headerRow]) {
        ProjectViewHeaderCell *headerCell = (ProjectViewHeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"projectViewHeaderCell"];
        headerCell.projectQuestion.text = [self.selectedProject topic];
        headerCell.userInteractionEnabled = NO;
        return headerCell;
    }
    
    NSIndexPath *detailsRow = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([indexPath isEqual:detailsRow]) {
        DetailViewCell *detailCell = (DetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"detailViewCell"];
        detailCell.detailText.text = [self.selectedProject details];
        
        // UI Segmented Control
        [detailCell.segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
        // Switch
        [detailCell.publicSwitch addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];

        return detailCell;
    }

    
    if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        // Show Collaborator Cells
            UITableViewCell *collaboratorCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"collaboratorCell"];

            Collaborator *collaborator = [self.collaborators objectAtIndex:indexPath.row - 2];
        
            collaboratorCell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[collaborator valueOrNilForKeyPath:@"first_name"], [collaborator valueOrNilForKeyPath:@"last_name"]];
            return collaboratorCell;

        
    } else if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        // Show Idea Cells
        
            IdeaCell *ideaCell = (IdeaCell *)[tableView dequeueReusableCellWithIdentifier:@"ideaCell"];
            Idea *idea = [self.ideas objectAtIndex:indexPath.row - 2];
            ideaCell.ideaText.text = [NSString stringWithFormat:@"%@", idea.text];
            ideaCell.voteNum.text = [NSString stringWithFormat:@"%d", (idea.upVotes.intValue - idea.downVotes.intValue)];
            ideaCell.name.text = [NSString stringWithFormat:@"%@ %@", [idea.author valueOrNilForKeyPath:@"first_name"], [idea.author valueOrNilForKeyPath:@"last_name"]];
        
            [ideaCell.upVote addTarget:self action:@selector(performUpVote:) forControlEvents:UIControlEventTouchUpInside];
            ideaCell.upVote.tag = indexPath.row - 2;
        
            [ideaCell.downVote addTarget:self action:@selector(performDownVote:) forControlEvents:UIControlEventTouchUpInside];
            ideaCell.downVote.tag = indexPath.row - 2;
        
            ideaCell.profilePicture.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",  [idea.author imageString] ]];
            ideaCell.userInteractionEnabled = YES;
            return ideaCell;
        
    }
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;

}

- (void) performUpVote: (UIButton*)sender {
    
    Idea *idea = [self.ideas objectAtIndex:sender.tag];
    
    [[APIClient sharedClient] upvoteIdea:idea success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Response object: %@", response);
        idea.upVotes = [response valueForKey:@"upvotes"];
        idea.downVotes = [response valueForKey:@"downvotes"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) performDownVote: (UIButton *)sender {
    
    Idea *idea = [self.ideas objectAtIndex:sender.tag];

    [[APIClient sharedClient] downvoteIdea:idea success:^(AFHTTPRequestOperation *operation, id response) {
        idea.upVotes = [response valueForKey:@"upvotes"];
        idea.downVotes = [response valueForKey:@"downvotes"];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [sender setSelected:YES];
}

- (void) performComment: (UIButton *)sender {
    Idea *idea = [self.ideas objectAtIndex:sender.tag];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentCreationViewController *cvc = [storyboard instantiateViewControllerWithIdentifier:@"CommentCreationViewController"];
    [cvc setCurrentIdea:idea];
    [cvc setCurrentProject:self.selectedProject];
    [self presentViewController:cvc animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *detailsRow = [NSIndexPath indexPathForRow:1 inSection:0];
    
    if ([indexPath isEqual:headerRow]) {
        return 175;
    } else if ([indexPath isEqual:detailsRow]) {
        return 225;
    }
    

    if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        // Collaborator Cells
        
        return 70;
        
    } else if ([self.segmentedControlState isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        // Idea Cells
        
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"presentIdeaCreation"]) {
        IdeaCreationViewController *vc = [segue destinationViewController];
        vc.myDelegate = self;
        vc.currentProject = self.selectedProject;
    }
}

- (void)ideaCreationViewControllerDismissed:(Idea *)idea
{
    [self.ideas addObject:idea];
    
    // Retrieve collaborators
    [[APIClient sharedClient] getCollaboratorsForProject:self.selectedProject success:^(AFHTTPRequestOperation *operation, id response) {
        
        self.collaborators = [Collaborator collaboratorsWithArray:response];
        NSLog(@"Selected Project: %@", self.selectedProject);
        NSLog(@"%@", response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self.tableView reloadData];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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




@end
