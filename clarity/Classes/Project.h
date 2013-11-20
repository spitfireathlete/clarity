//
//  Project.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"
#import "Priority.h"
#import "Collaborator.h"

@interface Project : RestObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) Priority *priority;
@property (nonatomic, strong) Collaborator *owner;
@property (nonatomic, strong) NSArray *ideas;
@property (nonatomic, strong) NSString *topic;

+ (NSMutableArray *)projectsWithArray:(NSArray *)array;

@end
