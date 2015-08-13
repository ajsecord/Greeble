//
//  DrawingView.h
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

#include <Greeble/RectDataSource.h>

#include <memory>

@interface DrawingView : UIView
@property(strong) UIColor *fillColor;
@property(assign) std::weak_ptr<Greeble::RectDataSource> dataSource;
@end
