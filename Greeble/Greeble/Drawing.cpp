#include <Greeble/Drawing.h>

#include <Greeble/Rect.h>

namespace Greeble {
    class Drawing::Impl {
    public:
        std::vector<Rect> rects;
        std::vector<std::shared_ptr<Constraint>> constraints;
    };

    Drawing::Drawing() : impl{new Impl()} {}
    Drawing::~Drawing() {}  // http://herbsutter.com/gotw/_100/

    size_t Drawing::numRects() const {
        return impl->rects.size();
    }

    void Drawing::addRects(const size_t count) {
        assert(false);
    }

    void Drawing::removeRects(const size_t count) {
        assert(false);
    }

    void Drawing::clearConstraints() {
        impl->constraints.clear();
    }

    void Drawing::addConstraint(const std::shared_ptr<Constraint> constraint) {
        impl->constraints.push_back(constraint);
    }
}