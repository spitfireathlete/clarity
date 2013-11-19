//
//  DetailViewCell.h
//  
//
//  Created by Erin Parker on 11/18/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *detailText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UISwitch *publicSwitch;


@end
