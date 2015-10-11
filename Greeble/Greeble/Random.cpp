#include "Random.h"

namespace Greeble { namespace Random {
    namespace {
        inline Scalar aspectRatio(const Scalar first, const Scalar second) {
            return first > second ? first / second : second / first;
        }
        
        inline bool inRange(const Scalar value, const Vec range) {
            return value >= range(0) && value <= range(1);
        }

        inline Vec rectCenterInBounds(const Vec size, const AlignedRect bounds) {
            const AlignedRect centerBounds = AlignedRect::inset(bounds, Scalar(0.5) * size);
            return point(centerBounds);
        }
    }

    Scalar scalar(const Scalar min, const Scalar max) {
        return min + (arc4random() / Scalar(UINT32_MAX)) * (max - min);
    }

    Vec point(const AlignedRect rect) {
        const Vec max = rect.origin + rect.size;
        return Vec(scalar(rect.origin(0), max(0)), scalar(rect.origin(1), max(1)));
    }

    AlignedRect alignedRect(const Vec edgeLengthRange, const Vec aspectRatioRange) {
        Scalar edge0, edge1;
        do {
            edge0 = scalar(edgeLengthRange(0), edgeLengthRange(1));
            edge1 = scalar(edgeLengthRange(0), edgeLengthRange(1));
        } while (inRange(aspectRatio(edge0, edge1), aspectRatioRange));

        const Vec size = scalar(0,1) > 0.5 ? Vec(edge0, edge1) : Vec(edge1, edge0);
        return AlignedRect::centerAndSize(Vec::zero(), size);
    }

    AlignedRect alignedRect(const AlignedRect bounds, const Vec edgeLengthRange, const Vec aspectRatioRange) {
        const AlignedRect r = alignedRect(edgeLengthRange, aspectRatioRange);
        const Vec center = rectCenterInBounds(r.size, bounds);
        return AlignedRect::centerAndSize(center, r.size);
    }

    Rect rect(const AlignedRect bounds, const Vec edgeLengthRange, const Vec aspectRatioRange, const Vec orientationRange) {
        const Scalar orientation = scalar(orientationRange(0), orientationRange(1));
        AlignedRect aligned = alignedRect(edgeLengthRange, aspectRatioRange);
        Rect r = Rect(Vec::zero(), aligned.size, orientation);
        AlignedRect boundingRect = r.boundingRect();
        Vec center = rectCenterInBounds(boundingRect.size, bounds);
        r.setCenter(center);
        return r;
    }
}}
