#ifndef Drawing_h
#define Drawing_h

#include <Greeble/Constraint.h>
#include <Greeble/Rect.h>

#include <vector>

namespace Greeble {

    /// The entire drawing.
    class Drawing {
        size_t numRects() const;
        void addRects(const size_t count, const Constraint& constraint);
        void removeRects(const size_t count);

    private:
        std::vector<Rect> rects;
    };

}

#endif /* Drawing_h */
