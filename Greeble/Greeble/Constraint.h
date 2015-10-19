#ifndef Constraint_h
#define Constraint_h

#include <Greeble/Rect.h>

namespace Greeble {
    class Constraint {
    public:
        virtual AlignedRect randAlignedRect() const = 0;
        virtual Vec randPoint() const = 0;
        virtual Rect randRect() const = 0;
        virtual bool satisfies(const AlignedRect& rect) const = 0;
        virtual bool satisfies(const Vec& point) const = 0;
        virtual bool satisfies(const Rect& rect) const = 0;

        virtual ~Constraint() {}
    };

    class AlignedRectAreaConstraint : public Constraint {
    public:
        AlignedRectAreaConstraint(const AlignedRect& area = AlignedRect());

        virtual AlignedRect randAlignedRect() const;
        virtual Vec randPoint() const;
        virtual Rect randRect() const;
        virtual bool satisfies(const AlignedRect& rect) const;
        virtual bool satisfies(const Vec& point) const;
        virtual bool satisfies(const Rect& rect) const;

    private:
        AlignedRect area;
    };
}

#endif /* Constraint_h */
