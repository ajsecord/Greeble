//
//  MasterViewController.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()
@property(nonatomic) IBOutlet UISlider *numRectsSlider;
@property(nonatomic) IBOutlet UILabel *numRectsLabel;

@property(nonatomic) NSMutableDictionary *sliderLabelMap;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController =
        (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self update];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - Interface events

- (IBAction)sliderDidUpdate:(id)sender {
    if (sender == _numRectsSlider) {
        [self updateLabel:_numRectsLabel forSlider:_numRectsSlider];
    }
}

#pragma mark - Private

- (void)update {
    [self updateLabel:_numRectsLabel forSlider:_numRectsSlider];
}

- (void)updateLabel:(UILabel *)label forSlider:(UISlider *)slider {
    NSAssert(slider && label, @"");
    label.text = [NSString stringWithFormat:@"%i", (int)slider.value];
}

@end
