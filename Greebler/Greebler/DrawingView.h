//
//  DrawingView.h
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <memory>

#import <Greeble/Rect.h>

@class DrawingView;

@protocol RectDataSource <NSObject>
@required
- (int)numRectsForDrawingView:(DrawingView *)drawingView;
- (Greeble::Rect)rectForDrawingView:(DrawingView *)drawingView atIndex:(int)index;
@end

@interface DrawingView : UIView
@property(nonatomic) UIColor *fillColor;
@property(nonatomic) id<RectDataSource> dataSource;
@end
