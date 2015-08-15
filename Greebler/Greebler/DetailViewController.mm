//
//  DetailViewController.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "DetailViewController.h"

#import "DrawingView.h"

#include <iterator>
#include <vector>

@interface RangeRectDataSource : NSObject<RectDataSource>
- (id)initWithRects:(const std::vector<Greeble::Rect>&)rects;
@end

@interface DetailViewController () {
    std::vector<Greeble::Rect> _rects;
}
@property(readonly) DrawingView *drawingView;
@end

@implementation DetailViewController

- (DrawingView *)drawingView {
    return [self isViewLoaded] ? (DrawingView *)self.view : nil;
}

- (void)viewDidLoad {
    _rects = std::vector<Greeble::Rect>(1);
    _rects[0] = Greeble::Rect(Greeble::Vec(100,100), Greeble::Vec(40,20), 30 * M_PI / 180);
    RangeRectDataSource *dataSource = [[RangeRectDataSource alloc] initWithRects:_rects];
    self.drawingView.dataSource = dataSource;
}

@end

@implementation RangeRectDataSource {
    std::vector<Greeble::Rect> _rects;
}

- (id)initWithRects:(const std::vector<Greeble::Rect>&)rects {
    self = [super init];
    if (self) {
        _rects = rects;
    }
    return self;
}

#pragma mark - RectDataSource

- (int)numRects {
    return _rects.size();
}

- (Greeble::Rect)rectAtIndex:(int)index {
    return _rects[index];
}

@end

