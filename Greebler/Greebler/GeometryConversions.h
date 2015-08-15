//
//  GeometryConversions.h
//  Greebler
//
//  Created by Adrian on 8/15/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#ifndef Greebler_GeometryConversions_h
#define Greebler_GeometryConversions_h

#include <Greeble/Rect.h>
#include <Greeble/Types.h>

#import <CoreGraphics/CoreGraphics.h>

static inline CGRect GreebleRectToCGRectNoOrientation(const Greeble::Rect& rect) {
    return CGRectMake(rect.origin(0), rect.origin(1), rect.size(0), rect.size(1));
}

static inline CGFloat GreebleScalarToCGFloat(const Greeble::Scalar& value) {
    return value;
}

static inline CGPoint GreebleVecToCGPoint(const Greeble::Vec& value) {
    return CGPointMake(value(0), value(1));
}

static inline CGSize GreebleVecToCGSize(const Greeble::Vec& value) {
    return CGSizeMake(value(0), value(1));
}

static inline Greeble::Scalar CGFloatToGreebleScalar(const CGFloat& value) {
    return value;
}

static inline Greeble::Vec CGPointToGreebleVec(const CGPoint& value) {
    return Greeble::Vec(value.x, value.y);
}

static inline Greeble::Vec CGSizeToGreebleVec(const CGSize& value) {
    return Greeble::Vec(value.width, value.height);
}

static inline Greeble::Rect CGRectToGreebleRectNoOrientation(const CGRect& rect) {
    return Greeble::Rect(CGPointToGreebleVec(rect.origin), CGSizeToGreebleVec(rect.size), 0);
}

static inline Greeble::Rect CGRectToGreebleRect(const CGRect& rect, const CGFloat orientation) {
    return Greeble::Rect(CGPointToGreebleVec(rect.origin), CGSizeToGreebleVec(rect.size), orientation);
}

#endif
