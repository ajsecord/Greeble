//
//  SwitchTableViewCell.h
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchTableViewCell : UITableViewCell
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) IBOutlet UISwitch *valueSwitch;
@end
