//
//  FeedCell.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self.layer setCornerRadius:1.5];
        [self.layer setMasksToBounds:YES];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    frame.origin.y += 5;
    frame.size.height -= 2 * 5;
    [super setFrame:frame];
}

@end
