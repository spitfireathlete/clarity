//
//  Priority.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Priority.h"

@implementation Priority

+ (NSMutableArray *)prioritiesWithArray:(NSArray *)array {
    NSMutableArray *priorities = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [priorities addObject:[[Priority alloc] initWithDictionary:params]];
    }
    return priorities;
}

#pragma mark - MLPAutoCompletionObject Protocol

- (NSString *)autocompleteString
{
    return [self valueForKey:@"name"];
}

@end
