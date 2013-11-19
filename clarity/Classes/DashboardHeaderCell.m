//
//  DashboardHeaderCell.m
//  clarity
//
//  Created by Erin Parker on 11/19/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "DashboardHeaderCell.h"

@implementation DashboardHeaderCell


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"light_blurry_background.png"]];
        [self setBackgroundView:backgroundView];        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

@end
