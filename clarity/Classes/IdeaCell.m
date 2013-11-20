//
//  IdeaCell.m
//  clarity
//
//  Created by Erin Parker on 11/18/13.
//  Copyright (c) 2013 Spitfire Athlete - Hackathons. All rights reserved.
//

#import "IdeaCell.h"

@implementation IdeaCell

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

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 5;
    frame.size.height -= 2 * 5;
    [super setFrame:frame];
}

@end
