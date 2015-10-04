//
//  SettingsTableViewController.m
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "SliderTableViewCell.h"
#import "SwitchTableViewCell.h"

@interface SettingsTableViewController ()
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *nib = [UINib nibWithNibName:@"SliderTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([SliderSetting class])];

    nib = [UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([SwitchSetting class])];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.settings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(indexPath.row < [self.settings count], @"");

    id setting = self.settings[indexPath.row];
    if ([setting isKindOfClass:[SliderSetting class]]) {
        SliderSetting *sliderSetting = setting;
        SliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SliderSetting class])
                                                                    forIndexPath:indexPath];
        cell.titleLabel.text = sliderSetting.title;
        cell.minValue = sliderSetting.minValue;
        cell.maxValue = sliderSetting.maxValue;
        cell.value = sliderSetting.value;
        return cell;

    } else if ([setting isKindOfClass:[SwitchSetting class]]) {
        SwitchSetting *switchSetting = setting;
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SwitchSetting class])
                                                                    forIndexPath:indexPath];
        cell.titleLabel.text = switchSetting.title;
        cell.valueSwitch.on = switchSetting.value;
        return cell;
    }

    NSAssert(NO, @"Unknown setting: %@", setting);
    return nil;
}

@end

@implementation SliderSetting
- (id)initWithTitle:(NSString *)title minValue:(float)minValue maxValue:(float)maxValue value:(float)value {
    self = [super init];
    if (self) {
        _title = [title copy];
        _minValue = minValue;
        _maxValue = maxValue;
        _value = value;
    }
    return self;
}
@end

@implementation SwitchSetting
- (id)initWithTitle:(NSString *)title value:(BOOL)value {
    self = [super init];
    if (self) {
        _title = [title copy];
        _value = value;
    }
    return self;
}
@end
