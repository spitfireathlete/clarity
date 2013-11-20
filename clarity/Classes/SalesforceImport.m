//
//  SalesforceImport.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "SalesforceImport.h"

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
    NSLog(@"%@", jsonResponse);
    NSArray *records = [jsonResponse objectForKey:@"records"];
    NSLog(@"request:didLoadResponse: #records: %d", records.count);
    
    // auto generate a bunch of projects here and post them to clarity
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
