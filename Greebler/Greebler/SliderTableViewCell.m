//
//  SliderTableViewCell.m
//  Greebler
//
//  Created by Adrian on 10/4/15.
//  Copyright © 2015 Adrian Secord. All rights reserved.
//

#import "SliderTableViewCell.h"

@implementation SliderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (float)minValue {
    NSAssert(self.valueSlider, @"");
    return self.valueSlider.minimumValue;
}

- (void)setMinValue:(float)minValue {
    NSAssert(self.valueSlider, @"");
    self.valueSlider.minimumValue = minValue;
}

- (float)maxValue {
    NSAssert(self.valueSlider, @"");
    return self.valueSlider.maximumValue;
}

- (void)setMaxValue:(float)maxValue {
    NSAssert(self.valueSlider, @"");
    self.valueSlider.maximumValue = maxValue;
}

- (float)value {
    NSAssert(self.valueSlider, @"");
    return self.valueSlider.value;
}

- (void)setValue:(float)value {
    NSAssert(self.valueSlider, @"");
    self.valueSlider.value = value;
    [self updateValueLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private

- (void)updateValueLabel {
    NSAssert(self.valueSlider, @"");
    self.valueLabel.text = [NSString stringWithFormat:@"%3.1f", self.valueSlider.value];
}

@end
