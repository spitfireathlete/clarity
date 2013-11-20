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
#import "SWRevealViewController.h"  
#import "APIClient.h"
#import "FeedTableViewController.h"

@interface ProjectCreationViewController ()

@property (nonatomic, strong) NSArray *priorities;
@property (nonatomic, strong) Priority *selectedPriority;
@property (nonatomic, strong) NSString* topic;
@property (nonatomic, strong) NSString* detail;

@property (nonatomic, strong) Project *createdProject;
@end

@implementation ProjectCreationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Tableview Background Image
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFBackground.png"]];
    [self.tableView setBackgroundView:backgroundView];
    self.detail = @"";
    
    // Custom Tableview Cells
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectCreationHeaderCell" bundle:nil] forCellReuseIdentifier:@"projectCreationHeaderCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountNameCell" bundle:nil] forCellReuseIdentifier:@"accountNameCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectDetailCell" bundle:nil] forCellReuseIdentifier:@"projectDetailCell"];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    // Nav Bar Formatting
    self.title = @"new project";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.318 green:0.769 blue:0.831 alpha:1.0]]; /*#51c4d4*/
    
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                      [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                      [UIFont fontWithName:@"AvenirNext-Bold" size:20.0f], NSFontAttributeName, nil]];
    
    [self.navigationController.navigationBar setTranslucent:YES];
    
    // SWRevealViewController
    [_menu setTarget: self.revealViewController];
    [_menu setAction: @selector(revealToggle:)];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowWithNotification:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideWithNotification:) name:UIKeyboardDidHideNotification object:nil];
    
    self.priorities = @[];
    
    [[APIClient sharedClient] getPrioritiesOnSuccess:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response from Clarity: %@", response);
        self.priorities = [Priority prioritiesWithArray:response]; // these should actually come from salesforce, or be a merged list from Clarity and SF
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
        
    }];
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShowWithNotification:(NSNotification *)aNotification
{
    self.tableView.scrollEnabled = NO;
}


- (void)keyboardDidHideWithNotification:(NSNotification *)aNotification
{
    self.tableView.scrollEnabled = YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *projectDetailRow = [NSIndexPath indexPathForRow:2 inSection:0];
    
    if (textField.tag == projectDetailRow.row) {
        self.detail = textField.text;
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void) dismissKeyboard {
    
    
//    self.doneButton.enabled = NO;
//    
//    [cell.textView resignFirstResponder];
  
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
        self.topic = textView.text;
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
        cell.textView.tag = headerRow.row;
        [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(createAccountQuestion:)]];
        
        return cell;
    }
    
    NSIndexPath *accountNameRow = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([indexPath isEqual:accountNameRow]) {
        AccountNameCell *cell = (AccountNameCell *)[tableView dequeueReusableCellWithIdentifier:@"accountNameCell"];
        cell.accountName.delegate = self;
        cell.accountName.autoCompleteDataSource = self;
        cell.accountName.autoCompleteDelegate = self;
        [cell.accountName setAutoCompleteTableAppearsAsKeyboardAccessory:YES];
        cell.accountName.autoCompleteTableCellBackgroundColor = [[UIColor alloc] initWithRed:(81/255.0) green:(196/255.0) blue:(212/255.0) alpha:1];
        cell.accountName.autoCompleteTableCellTextColor = [UIColor blackColor];
        cell.accountName.applyBoldEffectToAutoCompleteSuggestions = YES;
        return cell;
    }
    
    NSIndexPath *projectDetailRow = [NSIndexPath indexPathForRow:2 inSection:0];
    if ([indexPath isEqual:projectDetailRow]) {
        ProjectDetailCell *cell = (ProjectDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"projectDetailCell"];
        cell.textField.delegate = self;
        cell.textField.tag = projectDetailRow.row;
        return cell;
    }
    
    UITableViewCell *saveCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"saveCell"];
    return saveCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *projectDetailRow = [NSIndexPath indexPathForRow:2 inSection:0];
    
    if ([indexPath isEqual:headerRow]) {
        return 175;
    } else if ([indexPath isEqual:projectDetailRow]) {
        return 200;
    }
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSIndexPath *saveRow = [NSIndexPath indexPathForRow:3 inSection:0];
    
    if ([indexPath isEqual:saveRow]) {
        
        NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
        ProjectCreationHeaderCell *cell = (ProjectCreationHeaderCell *) [self.tableView cellForRowAtIndexPath:headerRow];
        [self textViewDidEndEditing:cell.textView];
        self.createdProject = [[Project alloc] initWithDictionary:@{@"topic": self.topic, @"details": self.detail}];
        [[APIClient sharedClient] createProject:self.selectedPriority project:self.createdProject success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response from clarity: %@", response);
            [self showProjectDetail];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error");
        }];
        
    }
}

- (void)createAccountQuestion: (UILongPressGestureRecognizer*)gesture {
    NSLog(@"Long gesture recognizer!");
    
    NSIndexPath *headerRow = [NSIndexPath indexPathForRow:0 inSection:0];
    ProjectCreationHeaderCell *cell = (ProjectCreationHeaderCell *) [self.tableView cellForRowAtIndexPath:headerRow];
    cell.writeIcon.hidden = YES;
    cell.instructionText1.hidden = YES;
    cell.instructionText2.hidden = YES;
    cell.textView.hidden = NO;
    cell.textView.delegate = self;
    [cell.textView becomeFirstResponder];
    
}

#pragma mark - Navigation

- (void) showProjectDetail {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SWRevealViewController *revealController = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    
    FeedTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"FeedTableViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [revealController setFrontViewController:navigationController animated:YES];
    [self presentViewController:revealController animated:NO completion:nil];
}

#pragma mark - MLPAutoCompleteTextField DataSource


//example of asynchronous fetch:
- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void (^)(NSArray *))handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{

        NSArray *completions;
        completions = [self allPriorities];
        
        
        handler(completions);
    });
}

- (NSArray *)allPriorities
{
    return self.priorities;
}

#pragma mark - MLPAutoCompleteTextField Delegate


- (BOOL)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
          shouldConfigureCell:(UITableViewCell *)cell
       withAutoCompleteString:(NSString *)autocompleteString
         withAttributedString:(NSAttributedString *)boldedString
        forAutoCompleteObject:(id<MLPAutoCompletionObject>)autocompleteObject
            forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //This is your chance to customize an autocomplete tableview cell before it appears in the autocomplete tableview
    NSString *filename = [autocompleteString stringByAppendingString:@".png"];
    filename = [filename stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    filename = [filename stringByReplacingOccurrencesOfString:@"&" withString:@"and"];
    [cell.imageView setImage:[UIImage imageNamed:filename]];
    
    return YES;
}

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
  didSelectAutoCompleteString:(NSString *)selectedString
       withAutoCompleteObject:(id<MLPAutoCompletionObject>)selectedObject
            forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedObject){
        NSLog(@"selected object from autocomplete menu %@ with string %@", selectedObject, [selectedObject autocompleteString]);
        self.selectedPriority = (Priority *) selectedObject;
    } else {
        NSLog(@"selected string '%@' from autocomplete menu", selectedString);
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



@end
