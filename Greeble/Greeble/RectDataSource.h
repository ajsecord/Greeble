//
//  RectDataSource.h
//  Greeble
//
//  Created by Adrian on 8/13/15.
//
//

#ifndef Greeble_RectDataSource_h
#define Greeble_RectDataSource_h

#include <Greeble/Rect.h>

namespace Greeble {

class RectDataSource {
public:
    virtual size_t getNumRects() const = 0;
    virtual const Rect& getRect(const size_t index) const = 0;
    virtual Rect& getRect(const size_t index) = 0;
};

} // namespace Greeble

#endif
