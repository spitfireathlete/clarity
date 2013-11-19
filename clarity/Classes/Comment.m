//
//  Comment.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Comment.h"

@implementation Comment

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super initWithDictionary: data]) {
        
        NSDictionary *author_params = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [self valueOrNilForKeyPath:@"author_email"], @"email",
                                       [self valueOrNilForKeyPath:@"author_first_name"], @"first_name",
                                       [self valueOrNilForKeyPath:@"author_last_name"], @"last_name",
                                       nil];
        
        
        self.author = [[Collaborator alloc] initWithDictionary:author_params];
        
        self.objectId = [self valueOrNilForKeyPath:@"id"];
    }
    
    return self;
}

+ (NSMutableArray *)commentsWithArray:(NSArray *)array {
    NSMutableArray *comments = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *params in array) {
        [comments addObject:[[Comment alloc] initWithDictionary:params]];
    }
    return comments;
}

@end
