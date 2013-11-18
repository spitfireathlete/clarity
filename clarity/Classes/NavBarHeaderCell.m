//
//  NavBarHeaderCell.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "NavBarHeaderCell.h"

@implementation NavBarHeaderCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

@end
