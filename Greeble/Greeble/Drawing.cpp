#include <Greeble/Drawing.h>

#include <Greeble/Rect.h>

namespace Greeble {
    namespace {

        inline Scalar randScalar(Scalar min, Scalar max) {
            return min + (arc4random() / (Scalar)UINT32_MAX) * (max - min);
        }

        inline Rect randRect(AlignedRect outerBounds, Vec maxSize) {
            Vec size = Vec(randScalar(0, maxSize(0)), randScalar(0, maxSize(1)));
            Scalar widest = hypotf(size(0) / 2, size(1) / 2);
            Vec origin = Vec(randScalar(outerBounds.min()(0) + widest, outerBounds.max()(0) - widest),
                             randScalar(outerBounds.min()(1) + widest, outerBounds.max()(1) - widest));
            Scalar orientation = randScalar(0, M_PI * 2);

            return Greeble::Rect(origin, size, orientation);
        }
    }
    
    
}