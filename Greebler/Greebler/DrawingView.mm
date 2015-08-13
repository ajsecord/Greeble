//
//  DrawingView.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "DrawingView.h"

#include <Greeble/Rect.h>
#include <iostream>

// Ignores orientation.
static inline CGRect GreebleRectToCGRect(const Greeble::Rect& rect) {
    return CGRectMake(rect.origin(0), rect.origin(1), rect.size(0), rect.size(1));
}

@implementation DrawingView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return [self initCommon];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return [self initCommon];
}

- (id)initCommon {
    _fillColor = [UIColor blackColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    auto rects = self.dataSource.lock();

    const size_t numRects = rects->getNumRects();
    for (size_t i = 0; i < numRects; ++i) {
        Greeble::Rect rect = rects->getRect(i);

        CGContextSaveGState(context);
        {
            CGRect r = GreebleRectToCGRect(rect);
            CGPoint center = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));

            // Translate to the origin, rotate, translate back. Specified in reverse order.
            CGContextTranslateCTM(context, center.x, center.y);
            CGContextRotateCTM(context, rect.orientation);
            CGContextTranslateCTM(context, -center.x, -center.y);

            CGContextSetFillColorWithColor(context, _fillColor.CGColor);
            CGContextFillRect(context, r);
            
        }
        CGContextRestoreGState(context);
    }

    CGRect r = CGRectMake(100, 100, 100, 140);
    CGFloat radians = 30 / 180.0 * M_PI;

    CGContextSaveGState(context);
    {
        CGPoint center = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));

        // Translate to the origin, rotate, translate back. Specified in reverse order.
        CGContextTranslateCTM(context, center.x, center.y);
        CGContextRotateCTM(context, radians);
        CGContextTranslateCTM(context, -center.x, -center.y);

        CGContextSetFillColorWithColor(context, _fillColor.CGColor);
        CGContextFillRect(context, r);

    }
    CGContextRestoreGState(context);
}

@end
