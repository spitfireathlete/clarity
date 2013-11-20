//
//  Collaborator.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Collaborator.h"
#import "CredentialStore.h"

NSString * const UserDidLoginToClarityNotification = @"UserDidLoginToClarityNotification";
NSString * const UserDidLogoutFromClarityNotification = @"UserDidLogoutFromClarityNotification";
NSString * const kCurrentUserKey = @"kCurrentUserKey";

@implementation Collaborator

static Collaborator *_currentUser;

+ (Collaborator *)currentUser {
    if (!_currentUser) {
        NSData *userData = [[NSUserDefaults standardUserDefaults] dataForKey:kCurrentUserKey];
        if (userData) {
            NSDictionary *userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:NSJSONReadingMutableContainers error:nil];
            _currentUser = [[Collaborator alloc] initWithDictionary:userDictionary];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser:(Collaborator *)currentUser {
    CredentialStore *creds = [[CredentialStore alloc] init];
    if (currentUser) {
        NSData *userData = [NSJSONSerialization dataWithJSONObject:currentUser.data options:NSJSONWritingPrettyPrinted error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCurrentUserKey];
        // clear out the clarity API token too
        [creds setAuthToken: nil];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (!_currentUser && currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginToClarityNotification object:nil];
    } else if (_currentUser && !currentUser) {
        _currentUser = currentUser; // Needs to be set before firing the notification
        [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutFromClarityNotification object:nil];
    }
}


+ (NSMutableArray *)collaboratorsWithArray:(NSArray *)array {
    NSMutableArray *collaborators = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [collaborators addObject:[[Collaborator alloc] initWithDictionary:params]];
    }
    return collaborators;
}

@end
