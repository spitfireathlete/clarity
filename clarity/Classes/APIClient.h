//
//  APIClient.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPSessionManager.h"
#import "Project.h"
#import "Comment.h"
#import "Idea.h"

@interface APIClient : AFHTTPSessionManager

+ (APIClient *)sharedClient;

- (void) getProjectsOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getProjectsContributedToOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getPrioritiesOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getCollaboratorsForProject:(Project *) project success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) createProject:(Priority *)priority project:(Project *) project success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) addComment:(NSString *) comment forIdea:(Idea *) idea inProject: (Project *) project  success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) addIdea:(NSString *) idea inProject: (Project *) project success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) upvoteComment:(Comment *) comment success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) downvoteComment:(Comment *) comment success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) upvoteIdea:(Idea *) idea success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) downvoteIdea:(Idea *) idea success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getAuthTokenBySFTokenOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void) getAuthTokenByFBToken:(NSString*) facebookToken success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
