//
//  LoginViewController.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "LoginViewController.h"
#import "SFAccountManager.h"
#import "SFAuthenticationManager.h"
#import "SFPushNotificationManager.h"
#import "SFOAuthInfo.h"
#import "SFLogger.h"
#import "APIClient.h"
#import "Collaborator.h"
#import "CredentialStore.h";

static NSString * const RemoteAccessConsumerKey = @"3MVG9Iu66FKeHhINkB1l7xt7kR8czFcCTUhgoA8Ol2Ltf1eYHOU4SqQRSEitYFDUpqRWcoQ2.dBv_a1Dyu5xa";
static NSString * const OAuthRedirectURI        = @"testsfdc:///mobilesdk/detect/oauth/done";

@interface LoginViewController ()

- (IBAction)signInWithSalesforce:(id)sender;

/**
 * Success block to call when authentication completes.
 */
@property (nonatomic, copy) SFOAuthFlowSuccessCallbackBlock initialLoginSuccessBlock;

/**
 * Failure block to calls if authentication fails.
 */
@property (nonatomic, copy) SFOAuthFlowFailureCallbackBlock initialLoginFailureBlock;

/**
 * Handles the notification from SFAuthenticationManager that a logout has been initiated.
 * @param notification The notification containing the details of the logout.
 */
- (void)logoutInitiated:(NSNotification *)notification;

/**
 * Handles the notification from SFAuthenticationManager that the login host has changed in
 * the Settings application for this app.
 * @param The notification whose userInfo dictionary contains:
 *        - kSFLoginHostChangedNotificationOriginalHostKey: The original host, prior to host change.
 *        - kSFLoginHostChangedNotificationUpdatedHostKey: The updated (new) login host.
 */
- (void)loginHostChanged:(NSNotification *)notification;


@end

@implementation LoginViewController

@synthesize initialLoginSuccessBlock = _initialLoginSuccessBlock;
@synthesize initialLoginFailureBlock = _initialLoginFailureBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder: decoder];
    if (self) {
        [SFLogger setLogLevel:SFLogLevelDebug];
        
        // These SFAccountManager settings are the minimum required to identify the Connected App.
        [SFAccountManager setClientId:RemoteAccessConsumerKey];
        [SFAccountManager setRedirectUri:OAuthRedirectURI];
        [SFAccountManager setScopes:[NSSet setWithObjects:@"api", nil]];
        
        // Logout and login host change handlers.
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutInitiated:) name:kSFUserLogoutNotification object:[SFAuthenticationManager sharedManager]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginHostChanged:) name:kSFLoginHostChangedNotification object:[SFAuthenticationManager sharedManager]];
        
        // Blocks to execute once authentication has completed.  You could define these at the different boundaries where
        // authentication is initiated, if you have specific logic for each case.
        
        __weak LoginViewController *weakSelf = self;
        
        self.initialLoginSuccessBlock = ^(SFOAuthInfo *info) {
            NSLog(@"%@", @"Authenticated successfully with Salesforce");
            
            // now do the token dance with the clarity API
            [[APIClient sharedClient] getAuthTokenBySFTokenOnSuccess:^(AFHTTPRequestOperation *operation, id response) {
                NSLog(@"response from Clarity: %@", response);
                [Collaborator setCurrentUser:[[Collaborator alloc] initWithDictionary:@{@"email": response[@"email"]}]];
                CredentialStore *creds = [[CredentialStore alloc] init];
                [creds setAuthToken:response[@"token"]];
                
                NSLog(@"%@", @"Logged in successfully to Clarity");
                // [weakSelf setupRootViewController]; // can show feed view controller here, successful login to salesforce and the clarity API
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [weakSelf onError];
            }];
            
            
        };
        
        self.initialLoginFailureBlock = ^(SFOAuthInfo *info, NSError *error) {
            NSLog(@"%@", @"Failed to log into Salesforce");
            [[SFAuthenticationManager sharedManager] logout];
        };
        
    }
    return self;
}

- (void)onError {
    [[[UIAlertView alloc] initWithTitle:@"Something went wrong" message:@"Couldn't log into Clarity, please try again!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSFUserLogoutNotification object:[SFAuthenticationManager sharedManager]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSFLoginHostChangedNotification object:[SFAuthenticationManager sharedManager]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInWithSalesforce:(id)sender {
    [self loginWithSalesforce];
}

- (void) loginWithSalesforce {
    [[SFAuthenticationManager sharedManager] loginWithCompletion:self.initialLoginSuccessBlock failure:self.initialLoginFailureBlock];
}

# pragma mark - handle notifications

- (void)logoutInitiated:(NSNotification *)notification {
        [self log:SFLogLevelDebug msg:@"Logout notification received.  Resetting app."];
        [[SFAuthenticationManager sharedManager] loginWithCompletion:self.initialLoginSuccessBlock failure:self.initialLoginFailureBlock];
}

- (void)loginHostChanged:(NSNotification *)notification {
        [self log:SFLogLevelDebug msg:@"Login host changed notification received.  Resetting app."];
        [[SFAuthenticationManager sharedManager] loginWithCompletion:self.initialLoginSuccessBlock failure:self.initialLoginFailureBlock];
}

@end
