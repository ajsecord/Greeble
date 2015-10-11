#include <Greeble/Rect.h>

#include <iostream>
#include <LinAlg/Transform2.h>

namespace Greeble {

    namespace {
        // Return a transform that maps:
        // * The origin to center, and
        // * The axes to a rotated set by orientation radians.
        inline Transform centerCoordsToWorldCoords(const Vec& center, const Scalar& orientation) {
            return Transform::translation(center) * Transform::rotation(orientation);
        }

        // Return a transform that maps:
        // * The rotated axes (by orientation radians) back to the standard axes, and
        // * The point at center to the origin.
        inline Transform worldCoordsToCenterCoords(const Vec& center, const Scalar& orientation) {
            return Transform::rotation(-orientation) * Transform::translation(-center);
        }
    }


    Rect::Rect(): origin(Vec::zero()), size(Vec::zero()), orientation(0) {}

    Rect::Rect(const Vec origin, const Vec size, const float orientation):
        origin(origin), size(size), orientation(orientation) {}

    Rect& Rect::operator=(const Rect& other) {
        origin = other.origin;
        size = other.size;
        orientation = other.orientation;
        return *this;
    }

    bool Rect::isEmpty() const {
        return size(0) <= 0 || size(1) <= 0;
    }

    bool Rect::containsPoint(const Vec& point) const {
        const Vec center = getCenter();
        const Transform transform = worldCoordsToCenterCoords(center, orientation);
        const Vec p = transform.transPoint(point);

        const Vec halfExtents = Scalar(0.5) * size;
        return p(0) >= -halfExtents(0) && p(0) <= halfExtents(0) &&
               p(1) >= -halfExtents(1) && p(1) <= halfExtents(1);
    }

    AlignedRect Rect::boundingRect() const {
        std::vector<Vec> vertices = this->vertices();
        const Scalar scalarMax = std::numeric_limits<Scalar>::max();
        Vec p0 = Vec(scalarMax, scalarMax);
        Vec p1 = -p0;
        for (size_t i = 0; i < 4; ++i) {
            p0 = min(p0, vertices[i]);
            p1 = max(p1, vertices[i]);
        }
        return AlignedRect(p0, p1 - p0);
    }

    Vec Rect::getCenter() const {
        return origin + size * Scalar(0.5);
    }

    void Rect::setCenter(const Vec& center) {
        const Vec curCenter = getCenter();
        origin += center - curCenter;
    }


    // The origin is at center - size/2, the max extent is at center + size/2.
    std::vector<Vec> Rect::vertices() const {
        const Vec center = getCenter();
        const Transform transform = centerCoordsToWorldCoords(center, orientation);

        const Vec max = Scalar(0.5) * size;
        const Vec min = -max;
        std::vector<Vec> vertices(4);
        vertices[0] = transform.transPoint(min);
        vertices[1] = transform.transPoint(Vec(max(0), min(1)));
        vertices[2] = transform.transPoint(max);
        vertices[3] = transform.transPoint(Vec(min(0), max(1)));
        return vertices;
    }

    std::ostream& operator<<(std::ostream& o, const Rect& r) {
        return o << r.origin << '(' << r.size(0) << 'x' << r.size(1) << ") " << r.orientation;
    }

    AlignedRect::AlignedRect(): origin(Vec::zero()), size(Vec::zero()) {}

    AlignedRect::AlignedRect(const Vec origin, const Vec size): origin(origin), size(size) {}

    AlignedRect& AlignedRect::operator=(const AlignedRect& other) {
        origin = other.origin;
        size = other.size;
        return *this;
    }

    AlignedRect AlignedRect::centerAndSize(const Vec center, const Vec size) {
        return AlignedRect(center - Scalar(0.5) * size, size);
    }

    AlignedRect AlignedRect::inset(const AlignedRect rect, const Vec inset) {
        return AlignedRect(rect.origin + inset, rect.size - Scalar(2) * inset);
    }

    bool AlignedRect::isEmpty() const {
        return size(0) <= 0 || size(1) <= 0;
    }

    Vec AlignedRect::getCenter() const {
        return origin + size / Scalar(2);
    }

    bool AlignedRect::containsPoint(const Vec& point) const {
        const Vec maxExtent = origin + size;
        return point(0) >= origin(0) && point(0) <= maxExtent(0) &&
               point(1) >= origin(1) && point(1) <= maxExtent(1);
    }

    Vec AlignedRect::min() const {
        return origin;
    }

    Vec AlignedRect::max() const {
        return origin + size;
    }

    std::vector<Vec> AlignedRect::vertices() const {
        const Vec maxExtent = origin + size;
        std::vector<Vec> vertices(4);
        vertices[0] = origin;
        vertices[1] = Vec(maxExtent(0), origin(1));
        vertices[2] = maxExtent;
        vertices[3] = Vec(origin(0), maxExtent(1));
        return vertices;
    }

    std::ostream& operator<<(std::ostream& o, const AlignedRect& r) {
        return o << r.origin << '(' << r.size(0) << 'x' << r.size(1) << ')';
    }

} // namespace Greeble