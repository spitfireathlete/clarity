//
//  RestObject.m
//  clarity
//
//  Created by Nidhi Kulkarni on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "RestObject.h"

@implementation RestObject

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
    }
    
    return self;
}

- (id)objectForKey:(id)key {
    return [_data objectForKey:key];
}

- (id)valueOrNilForKeyPath:(NSString *)keyPath {
    return [_data valueForKeyPath:keyPath];
}

@end
