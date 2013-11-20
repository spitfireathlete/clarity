//
//  Project.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Project.h"
#import "Idea.h"

@implementation Project

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super initWithDictionary: data]) {
        NSArray *ideas = [self valueOrNilForKeyPath:@"ideas"];
        self.ideas = [Idea ideasWithArray:ideas];
        self.owner = [[Collaborator alloc] initWithDictionary:[self valueOrNilForKeyPath:@"user"]];
        self.priority = [[Priority alloc] initWithDictionary:[self valueOrNilForKeyPath:@"priority"]];
        self.objectId = [self valueOrNilForKeyPath:@"id"];
        self.topic = [self valueOrNilForKeyPath:@"topic"];
    }
    
    return self;
}

+ (NSMutableArray *)projectsWithArray:(NSArray *)array {
    NSMutableArray *projects = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [projects addObject:[[Project alloc] initWithDictionary:params]];
    }
    return projects;
}

@end
