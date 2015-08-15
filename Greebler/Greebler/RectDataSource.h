//
//  RectDataSource.h
//  Greebler
//
//  Created by Adrian on 8/15/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#include <Greeble/Rect.h>

@protocol RectDataSource <NSObject>
@required
- (int)numRects;
- (Greeble::Rect)rectAtIndex:(int)index;
@end