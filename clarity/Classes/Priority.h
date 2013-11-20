//
//  Priority.h
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "RestObject.h"
#import "MLPAutoCompletionObject.h"

@interface Priority : RestObject <MLPAutoCompletionObject>

@property (nonatomic, strong) NSString *objectId;

+ (NSMutableArray *)prioritiesWithArray:(NSArray *)array;

@end
