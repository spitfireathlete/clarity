//
//  SalesforceImport.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/20/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestAPI.h"

@interface SalesforceImport : NSObject <SFRestDelegate>

+ (SalesforceImport *)sharedClient;

- (void) syncWithSalesforceAndAutogenerateProjects;

@end
