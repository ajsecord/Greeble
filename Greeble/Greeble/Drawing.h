#ifndef Drawing_h
#define Drawing_h

#include <Greeble/Constraint.h>
#include <Greeble/Rect.h>

#include <memory>
#include <vector>

namespace Greeble {

    /// The entire drawing.
    class Drawing {
        Drawing();
        ~Drawing();

        // Managing the list of constraints.
        template <typename Range> void setConstraints(const Range& range);

        // Managing the set of shapes. Added shapes will always respect the currently-set constraints.
        size_t numRects() const;
        void addRects(const size_t count);
        void removeRects(const size_t count);

    private:
        void clearConstraints();
        void addConstraint(const std::shared_ptr<Constraint> constraint);

        class Impl;
        std::unique_ptr<Impl> impl;
    };

    // Template definitions

    template <typename Range>
    void Drawing::setConstraints(const Range& range) {
        clearConstraints();
        for (auto i : range) {
            addConstraint(*i);
        }
    }
}

#endif /* Drawing_h */
