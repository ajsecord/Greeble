#ifndef GREEBLE_RECT_H
#define GREEBLE_RECT_H

#include <LinAlg/Vec2.h>

#include <iosfwd>

namespace Greeble {

class Rect {
public:
    LinAlg::Vec2f origin;
    LinAlg::Vec2f size;
    float orientation;

    Rect();
    Rect(const LinAlg::Vec2f origin, const LinAlg::Vec2f size, const float orientation);
    Rect& operator=(const Rect& other);
};

std::ostream& operator<<(std::ostream& o, const Rect& r);

} // namespace Greeble

#endif // GREEBLE_RECT_H
