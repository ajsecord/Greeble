//
//  DrawingView.h
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RectDataSource.h"

#include <memory>

@interface DrawingView : UIView
@property(nonatomic) UIColor *fillColor;
@property(nonatomic) id<RectDataSource> dataSource;
@end
