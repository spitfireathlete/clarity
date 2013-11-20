//
//  Collaborator.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestObject.h"

@interface Collaborator : RestObject

+ (Collaborator *)currentUser;
+ (void)setCurrentUser:(Collaborator *) currentUser;

+ (NSMutableArray *)collaboratorsWithArray:(NSArray *)array;

@end
