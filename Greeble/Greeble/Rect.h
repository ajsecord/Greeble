#ifndef GREEBLE_RECT_H
#define GREEBLE_RECT_H


#include <Greeble/Types.h>

#include <iosfwd>

namespace Greeble {

class Rect {
public:
    Vec origin;
    Vec size;
    Scalar orientation;

    Rect();
    Rect(const Vec origin, const Vec size, const Scalar orientation);
    Rect& operator=(const Rect& other);

    Vec center() const;
};

std::ostream& operator<<(std::ostream& o, const Rect& r);

} // namespace Greeble

#endif // GREEBLE_RECT_H
