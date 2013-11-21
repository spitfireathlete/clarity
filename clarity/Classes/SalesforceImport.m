//
//  SalesforceImport.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "SalesforceImport.h"
#import "APIClient.h"
#import "Priority.h"
#import "Project.h"

@implementation SalesforceImport

+ (SalesforceImport *)sharedClient {
    static SalesforceImport *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SalesforceImport alloc] init];        
    });
    
    return _sharedClient;
}

- (void) syncWithSalesforceAndAutogenerateProjects {
    [self describeAccount];
}



- (void)describeAccount {
    // SFRestRequest *request = [[SFRestAPI sharedInstance] requestForDescribeWithObjectType:@"Account"];
    //SFRestRequest *request = [[SFRestAPI sharedInstance] requestForDescribeWithObjectType:@"Account"];
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:@"SELECT Id, Name, Type, Industry FROM Account LIMIT 10"];
    [[SFRestAPI sharedInstance] send:request delegate:self];
}

#pragma mark - SFRestAPIDelegate

- (void) request:(SFRestRequest *)request didLoadResponse:(id)jsonResponse {
    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    
    // auto generate a bunch of projects here and post them to clarity
    for (id record in records) {
        Priority *p = [self getPriorityFromRecord:record];
        NSLog(@"%@, %@", [p valueOrNilForKeyPath:@"name"], [p valueOrNilForKeyPath:@"salesforce_id"]);
        Project *proj = [self getProjectWithReccord:record];
        
        if (proj != nil) {
            
            [[APIClient sharedClient] createProject:p project:proj success:^(AFHTTPRequestOperation *operation, id response) {
                NSLog(@"%@ created from import", [proj valueOrNilForKeyPath:@"topic"]);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error on creating project %@", error);
            }];
        }
    }
    
    
}

- (Priority *) getPriorityFromRecord:(id) record {
    Priority *p = [[Priority alloc] initWithDictionary:@{@"name": record[@"Name"], @"salesforce_id": record[@"Id"]}];
    return p;
    
}

- (Project *) getProjectWithReccord:(id) record {
    NSString *type = record [@"Type"];
    
    if ([type isEqualToString:@"Customer - Direct"] || [type isEqualToString:@"Prospect"]) {
        Project *proj = [[Project alloc] initWithDictionary: @{@"topic": [NSString stringWithFormat:@"What new product would you like to see %@ make next?", record[@"Name"]], @"details": @"You are the future. You decide. What should we make next? We’re a company with innovation in our DNA. We care more about our customers than anything. And we want to hear what you have to say. Let us over deliver."}];
        return proj;
    }
    
    return nil;
    
  
}

- (void)request:(SFRestRequest*)request didFailLoadWithError:(NSError*)error {
    NSLog(@"request:didFailLoadWithError: %@", error);
    //add your failed error handling here
}

- (void)requestDidCancelLoad:(SFRestRequest *)request {
    NSLog(@"requestDidCancelLoad: %@", request);
    //add your failed error handling here
}

- (void)requestDidTimeout:(SFRestRequest *)request {
    NSLog(@"requestDidTimeout: %@", request);
    //add your failed error handling here
}





@end
