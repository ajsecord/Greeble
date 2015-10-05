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

static UIView *FindSuperviewOfClass(UIView *view, Class klass);

@interface SliderForwarder : NSObject
@property(nonatomic, weak) SliderSetting *setting;
- (void)sliderValueDidChange:(id)sender;
@end

@interface SwitchForwarder : NSObject
@property(nonatomic, weak) SwitchSetting *setting;
- (void)switchValueDidChange:(id)sender;
@end

@interface SettingsTableViewController () {
    NSMutableDictionary *_forwarders;
}
@end

@implementation SettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _forwarders = [[NSMutableDictionary alloc] init];
}

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

        SliderForwarder *forwarder = [[SliderForwarder alloc] init];
        forwarder.setting = setting;
        [_forwarders removeObjectForKey:indexPath];
        [_forwarders setObject:forwarder forKey:indexPath];

        [cell.valueSlider removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
        [cell.valueSlider addTarget:forwarder
                             action:@selector(sliderValueDidChange:)
                   forControlEvents:UIControlEventValueChanged];
        return cell;

    } else if ([setting isKindOfClass:[SwitchSetting class]]) {
        SwitchSetting *switchSetting = setting;
        SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SwitchSetting class])
                                                                    forIndexPath:indexPath];
        cell.titleLabel.text = switchSetting.title;
        cell.valueSwitch.on = switchSetting.value;

        SwitchForwarder *forwarder = [[SwitchForwarder alloc] init];
        forwarder.setting = setting;
        [_forwarders removeObjectForKey:indexPath];
        [_forwarders setObject:forwarder forKey:indexPath];

        [cell.valueSwitch removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
        [cell.valueSwitch addTarget:forwarder
                             action:@selector(switchValueDidChange:)
                   forControlEvents:UIControlEventValueChanged];
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

@implementation SliderForwarder
- (void)sliderValueDidChange:(id)sender {
    UISlider *slider = sender;
    SliderTableViewCell *cell = (SliderTableViewCell *)FindSuperviewOfClass(sender, [SliderTableViewCell class]);
    if (cell) {
        cell.valueLabel.text = [NSString stringWithFormat:@"%i", (int)slider.value];
    }

    self.setting.value = slider.value;

    if (self.setting.settingValueChanged)
        self.setting.settingValueChanged(self.setting);
}
@end

@implementation SwitchForwarder
- (void)switchValueDidChange:(id)sender {
    UISwitch *theSwitch = (UISwitch *)sender;

    self.setting.value = theSwitch.isOn;

    if (self.setting.settingValueChanged)
        self.setting.settingValueChanged(self.setting);
}
@end

UIView *FindSuperviewOfClass(UIView *view, Class klass) {
    UIView *superview = [view superview];
    while (superview && ![superview isKindOfClass:klass])
        superview = [superview superview];
    return superview;
}
