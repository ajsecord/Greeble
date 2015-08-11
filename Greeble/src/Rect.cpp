#include <Greeble/Rect.h>

#include <iostream>

namespace Greeble {

Rect::Rect(): origin(LinAlg::Vec2f::zero()), size(LinAlg::Vec2f::zero()), orientation(0) {}

Rect::Rect(const LinAlg::Vec2f origin, const LinAlg::Vec2f size, const float orientation):
    origin(origin), size(size), orientation(orientation) {}

Rect& Rect::operator=(const Rect& other) {
    this->origin = other.origin;
    this->size = other.size;
    this->orientation = other.orientation;
    return *this;
}


std::ostream& operator<<(std::ostream& o, const Rect& r) {
    return o << r.origin << '(' << r.size(0) << 'x' << r.size(1) << ") " << r.orientation;
}

} // namespace Greeble