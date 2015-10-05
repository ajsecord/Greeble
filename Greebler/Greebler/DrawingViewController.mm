//
//  DrawingViewController.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "DrawingViewController.h"

#import "DrawingView.h"
#import "GeometryConversions.h"
#import "SettingsTableViewController.h"

#include <iterator>
#include <vector>

static const CGSize kMaxSize = { 50, 50 };

static inline CGFloat randScalar(CGFloat min, CGFloat max) {
    return min + (arc4random() / (CGFloat)UINT32_MAX) * (max - min);
}

static inline Greeble::Rect randRect(CGRect bounds, CGSize maxSize) {
    CGSize size = CGSizeMake(randScalar(0, maxSize.width), randScalar(0, maxSize.height));
    CGFloat widest = hypotf(size.width / 2, size.height / 2);
    CGPoint origin = CGPointMake(randScalar(CGRectGetMinX(bounds) + widest, CGRectGetMaxX(bounds) - widest),
                                 randScalar(CGRectGetMinY(bounds) + widest, CGRectGetMaxY(bounds) - widest));
    CGFloat orientation = randScalar(0, M_PI * 2);
    
    return Greeble::Rect(CGPointToGreebleVec(origin), CGSizeToGreebleVec(size), orientation);
}

@interface RangeRectDataSource : NSObject<RectDataSource>
- (id)initWithRects:(const std::vector<Greeble::Rect>&)rects;
@end

@interface DrawingViewController () {
    std::vector<Greeble::Rect> _rects;
    NSArray *_settings;
}
@property(readonly) DrawingView *drawingView;
@end

@implementation DrawingViewController

- (DrawingView *)drawingView {
    return [self isViewLoaded] ? (DrawingView *)self.view : nil;
}

- (NSInteger)numRects {
    return (NSInteger)_rects.size();
}

- (void)setNumRects:(NSInteger)numRects {
    if (_rects.size() == numRects)
        return;

    if (numRects > _rects.size()) {
        size_t curSize = _rects.size();
        _rects.resize(numRects);
        for (size_t i = curSize; i < numRects; ++i) {
            _rects[i] = randRect(self.view.bounds, kMaxSize);
        }
    } else if (numRects < _rects.size()) {
        _rects.resize(numRects);
    }

    [self.view setNeedsDisplay];
}

- (void)viewDidLoad {
    _rects = std::vector<Greeble::Rect>(1);
    _rects[0] = randRect(self.view.bounds, kMaxSize);
    RangeRectDataSource *dataSource = [[RangeRectDataSource alloc] initWithRects:_rects];
    self.drawingView.dataSource = dataSource;

    NSMutableArray *settings = [NSMutableArray array];

    {
        SliderSetting *setting = [[SliderSetting alloc] initWithTitle:@"Num Rects" minValue:0 maxValue:1000 value:[self numRects]];
        setting.settingValueChanged = ^(id setting) {
            NSAssert([setting isKindOfClass:[SliderSetting class]], @"");
            [self setNumRects:((SliderSetting *)setting).value];
        };
        [settings addObject:setting];
    }

    {
        SwitchSetting *setting = [[SwitchSetting alloc] initWithTitle:@"Grumble" value:YES];
        setting.settingValueChanged = ^(id setting) {
            NSLog(@"Value changed to %i", (int)[((SwitchSetting *)setting) value]);
        };
        [settings addObject:setting];
    }

    _settings = [NSArray arrayWithArray:settings];
}

- (void)viewDidLayoutSubviews {
}

- (IBAction)settingsButtonWasTapped:(id)sender {
    SettingsTableViewController *settings = [[SettingsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    settings.settings = _settings;
    settings.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:settings animated:YES completion:nil];
    settings.popoverPresentationController.barButtonItem = sender;
}

@end

@implementation RangeRectDataSource {
    const std::vector<Greeble::Rect>* _rects;
}

- (id)initWithRects:(const std::vector<Greeble::Rect>&)rects {
    self = [super init];
    if (self) {
        _rects = &rects;
    }
    return self;
}

#pragma mark - RectDataSource

- (int)numRectsForDrawingView:(DrawingView *)drawingView {
    return _rects ? (int)_rects->size() : 0;
}

- (Greeble::Rect)rectForDrawingView:(DrawingView *)drawingView atIndex:(int)index {
    NSAssert(_rects, @"");
    return _rects ? (*_rects)[index] : Greeble::Rect();
}

@end

