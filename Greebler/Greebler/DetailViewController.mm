//
//  DetailViewController.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "DetailViewController.h"

#import "DrawingView.h"
#import "GeometryConversions.h"

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

@interface DetailViewController () {
    std::vector<Greeble::Rect> _rects;
}
@property(readonly) DrawingView *drawingView;
@end

@implementation DetailViewController

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
        int curSize = _rects.size();
        _rects.resize(numRects);
        for (int i = curSize; i < numRects; ++i) {
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
}

- (void)viewDidLayoutSubviews {
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
    return _rects ? _rects->size() : 0;
}

- (Greeble::Rect)rectForDrawingView:(DrawingView *)drawingView atIndex:(int)index {
    NSAssert(_rects, @"");
    return _rects ? (*_rects)[index] : Greeble::Rect();
}

@end

