//
//  SettingsTableViewController.m
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()
@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.settings[indexPath.row] title]];
    return cell;
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
