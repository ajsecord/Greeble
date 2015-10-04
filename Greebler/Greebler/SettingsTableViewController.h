//
//  SettingsTableViewController.h
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderSetting : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) float minValue;
@property(nonatomic, assign) float maxValue;
@property(nonatomic, assign) float value;

- (id)initWithTitle:(NSString *)title minValue:(float)minValue maxValue:(float)maxValue value:(float)value;
@end

@interface SwitchSetting : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, assign) BOOL value;

- (id)initWithTitle:(NSString *)title value:(BOOL)value;
@end

@interface SettingsTableViewController : UITableViewController
@property(nonatomic, strong) NSArray *settings;  // An array of *Setting objects.
@end
