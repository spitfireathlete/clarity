//
//  Collaborator.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Collaborator.h"

@implementation Collaborator

+ (NSMutableArray *)collaboratorsWithArray:(NSArray *)array {
    NSMutableArray *collaborators = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [collaborators addObject:[[Collaborator alloc] initWithDictionary:params]];
    }
    return collaborators;
}

@end
