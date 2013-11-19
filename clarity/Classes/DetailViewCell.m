//
//  DetailViewCell.m
//  
//
//  Created by Erin Parker on 11/18/13.
//
//

#import "DetailViewCell.h"

@implementation DetailViewCell


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


- (IBAction)switch:(id)sender {
}
@end
