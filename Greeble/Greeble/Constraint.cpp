#include <Greeble/Constraint.h>

#include <Greeble/Random.h>

namespace Greeble {
    AlignedRectAreaConstraint::AlignedRectAreaConstraint(const AlignedRect& area): area(area) {}

    AlignedRect AlignedRectAreaConstraint::randAlignedRect() const {
        return Random::alignedRect(area, Vec(1,1), Vec(1,1));
    }

    Vec AlignedRectAreaConstraint::randPoint() const {
        return Random::point(area);
    }

    Rect AlignedRectAreaConstraint::randRect() const {
        return Random::rect(area, Vec(1,1), Vec(1,1), Vec(0, 2 * M_PI));
    }

    bool AlignedRectAreaConstraint::satisfies(const AlignedRect& rect) const {
        assert(false);
        return false;
    }

    bool AlignedRectAreaConstraint::satisfies(const Vec& point) const {
        return area.containsPoint(point);
    }

    bool AlignedRectAreaConstraint::satisfies(const Rect& rect) const {
        assert(false);
        return false;
    }
}
