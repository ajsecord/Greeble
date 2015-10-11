#ifndef GREEBLE_RECT_H
#define GREEBLE_RECT_H


#include <Greeble/Types.h>

#include <iosfwd>
#include <vector>

namespace Greeble {
    /// An axis-aligned rectangle.
    class AlignedRect {
    public:
        Vec origin;
        Vec size;

        AlignedRect();
        AlignedRect(const Vec origin, const Vec size);
        AlignedRect& operator=(const AlignedRect& other);

        static AlignedRect centerAndSize(const Vec center, const Vec size);
        static AlignedRect inset(const AlignedRect rect, const Vec inset);

        bool isEmpty() const;
        Vec getCenter() const;
        bool containsPoint(const Vec& point) const;
        Vec min() const;
        Vec max() const;

        std::vector<Vec> vertices() const;
    };

    std::ostream& operator<<(std::ostream& o, const AlignedRect& r);

    /// A rectangle with orientation.
    class Rect {
    public:
        Vec origin;         // Minimum coordinates.
        Vec size;           // Extents.
        Scalar orientation; // Counter-clockwise rotation about the center.

        Rect();
        Rect(const Vec origin, const Vec size, const Scalar orientation);
        Rect& operator=(const Rect& other);

        bool isEmpty() const;
        Vec getCenter() const;
        void setCenter(const Vec& center);
        bool containsPoint(const Vec& point) const;
        AlignedRect boundingRect() const;

        std::vector<Vec> vertices() const;
    };

    std::ostream& operator<<(std::ostream& o, const Rect& r);
    
} // namespace Greeble

#endif // GREEBLE_RECT_H
