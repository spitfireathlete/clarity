//
//  Comment.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"
#import "Collaborator.h"

@interface Comment : RestObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) Collaborator *author;

+ (NSMutableArray *)commentsWithArray:(NSArray *)array;

@end
