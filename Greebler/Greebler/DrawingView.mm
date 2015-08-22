//
//  DrawingView.m
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import "DrawingView.h"

#import "GeometryConversions.h"

#include <Greeble/Rect.h>
#include <iostream>

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
    if (!_dataSource) {
        return;
    }

    CGContextRef context = UIGraphicsGetCurrentContext();

    const int numRects = [_dataSource numRectsForDrawingView:self];
    for (int i = 0; i < numRects; ++i) {
        Greeble::Rect rect = [_dataSource rectForDrawingView:self atIndex:i];

        CGContextSaveGState(context);
        {
            CGRect r = GreebleRectToCGRectNoOrientation(rect);
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
}

@end
