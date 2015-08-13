#include <Greeble/Rect.h>

#include <iostream>

namespace Greeble {

Rect::Rect(): origin(Vec::zero()), size(Vec::zero()), orientation(0) {}

Rect::Rect(const Vec origin, const Vec size, const float orientation):
    origin(origin), size(size), orientation(orientation) {}

Rect& Rect::operator=(const Rect& other) {
    this->origin = other.origin;
    this->size = other.size;
    this->orientation = other.orientation;
    return *this;
}

Vec Rect::center() const {
    return this->origin + this->size * Scalar(0.5);
}

std::ostream& operator<<(std::ostream& o, const Rect& r) {
    return o << r.origin << '(' << r.size(0) << 'x' << r.size(1) << ") " << r.orientation;
}

} // namespace Greeble