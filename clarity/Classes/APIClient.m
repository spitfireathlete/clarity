//
//  APIClient.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "APIClient.h"
#import "AFURLResponseSerialization.h"
#import "AFHTTPRequestOperationManager.h"
#import "SFIdentityData.h"
#import "SFAccountManager.h"
#import "CredentialStore.h"

@implementation APIClient

//static NSString * const BASE_URL = @"https://clarityapi.herokuapp.com/";
static NSString * const BASE_URL = @"http://localhost:3000/";

+ (APIClient *)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:BASE_URL];
        
        _sharedClient = [[APIClient alloc] initWithBaseURL:baseURL sessionConfiguration:nil];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        
    });
    
    return _sharedClient;
}

- (void)getProjectsOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:[NSString stringWithFormat:@"%@api/projects.json", BASE_URL] parameters:[self setAuthToken:nil] success:success failure:failure];
}

- (void)getCollaboratorsForProject:(Project *)project success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:[NSString stringWithFormat:@"%@api/projects/%@/collaborations.json", BASE_URL, project.objectId] parameters:[self setAuthToken:nil] success:success failure:failure];
}

-(void) createProject:(Project *)project success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@api/projects/%@/collaborations.json", BASE_URL, project.objectId] parameters:project.data success:success failure:failure];
}

-(void) addComment:(NSString *)comment forIdea:(Idea *)idea inProject:(Project *)project success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@api/projects/%@/ideas/%@/comments", BASE_URL, project.objectId, idea.objectId] parameters:[self setAuthToken:@{@"text": comment}] success:success failure:failure];
}

-(void) addIdea:(NSString *)idea inProject:(Project *)project success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@api/api/projects/%@/ideas", BASE_URL, project.objectId] parameters:[self setAuthToken:@{@"text": idea}] success:success failure:failure];
}

-(void) upvoteComment:(Comment *) comment success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager PUT:[NSString stringWithFormat:@"%@api/api/comments/%@/upvote", BASE_URL, comment.objectId] parameters:[self setAuthToken:nil] success:success failure:failure];
}

-(void) downvoteComment:(Comment *) comment success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager PUT:[NSString stringWithFormat:@"%@api/api/comments/%@/downvote", BASE_URL, comment.objectId] parameters:[self setAuthToken:nil] success:success failure:failure];
}

-(void) upvoteIdea:(Idea *) idea success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager PUT:[NSString stringWithFormat:@"%@api/api/comments/%@/upvote", BASE_URL, idea.objectId] parameters:[self setAuthToken:nil] success:success failure:failure];
}

-(void) downvoteIdea:(Idea *) idea success:(void (^)(AFHTTPRequestOperation *operation, id response)) success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager PUT:[NSString stringWithFormat:@"%@api/api/comments/%@/upvote", BASE_URL, idea.objectId] parameters:[self setAuthToken:nil] success:success failure:failure];
}

-(void) getAuthTokenBySFTokenOnSuccess:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    SFOAuthCredentials *creds = [[SFAccountManager sharedInstance] credentials];
    [manager POST:[NSString stringWithFormat:@"%@/tokens", BASE_URL] parameters:@{@"sf_oauth_token": [creds accessToken] , @"identity_url": [creds identityUrl]} success:success failure:failure];

}

-(void) getAuthTokenByFBToken:(NSString*) facebookToken success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager POST:[NSString stringWithFormat:@"%@api/tokens", BASE_URL] parameters:@{@"mobile_facebook_token": facebookToken } success:success failure:failure];
    
}

- (NSDictionary *) setAuthToken: (NSDictionary *) params {
    NSMutableDictionary *paramsWithAuth = [[NSMutableDictionary alloc] initWithDictionary: params];
    CredentialStore *creds = [[CredentialStore alloc] init];
    [paramsWithAuth setObject:[creds authToken] forKey:@"auth_token"];
    return paramsWithAuth;
}



@end
