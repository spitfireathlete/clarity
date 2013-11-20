//
//  Idea.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "Idea.h"
#import "Comment.h"

@implementation Idea

- (id)initWithDictionary:(NSMutableDictionary *)data {
    if (self = [super initWithDictionary: data]) {
        NSArray *comments = [self valueOrNilForKeyPath:@"comments"];
        self.comments = [Comment commentsWithArray:comments];
        
        NSDictionary *author_params = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [self valueOrNilForKeyPath:@"author_email"], @"email",
                                    [self valueOrNilForKeyPath:@"author_first_name"], @"first_name",
                                    [self valueOrNilForKeyPath:@"author_last_name"], @"last_name",
                                    nil];
        
        
        self.author = [[Collaborator alloc] initWithDictionary:author_params];

        self.objectId = [self valueOrNilForKeyPath:@"id"];
        self.text = [self valueOrNilForKeyPath:@"text"];
        self.upVotes = [self valueOrNilForKeyPath:@"upvotes"];
        self.downVotes = [self valueOrNilForKeyPath:@"downvotes"];
    }
    
    return self;
}

+ (NSMutableArray *)ideasWithArray:(NSArray *)array {
    NSMutableArray *ideas = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSMutableDictionary *params in array) {
        [ideas addObject:[[Idea alloc] initWithDictionary:params]];
    }
    return ideas;
}

@end
