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
        self.details = [self valueOrNilForKeyPath:@"details"];
    }
    
    return self;
}

- (NSString *)getImageName
{
    NSString *name = [self.priority valueOrNilForKeyPath:@"name"];
    
    if ([name isEqualToString:@"Nike"]) {
        return @"Nike.jpg";
    } else if ([name isEqualToString:@"Starbucks"]) {
        return @"Starbucks.jpg";
    } else if ([name isEqualToString:@"Ford"]) {
        return @"Ford.jpg";
    } else if ([name isEqualToString:@"Lululemon"]) {
        return @"Lululemon.jpg";
    } else if ([name isEqualToString:@"Airbnb"]) {
        return @"Airbnb.jpg";
    } else if ([name isEqualToString:@"Yahoo"]) {
        return @"Yahoo.jpg";
    } else if ([name isEqualToString:@"Cako"]) {
        return @"Cako.jpeg";
    } else if ([name isEqualToString:@"Banana Republic"]) {
        return @"BananaRepublic.jpg";
    } else if ([name isEqualToString:@"Amazon"]) {
        return @"Amazon.jpg";
    } else {
        return @"DefaultImage.jpg";
    }
}

+ (NSMutableArray *)projectsWithArray:(NSArray *)array {
    NSMutableArray *projects = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [projects addObject:[[Project alloc] initWithDictionary:params]];
    }
    return projects;
}

@end
