#ifndef Random_h
#define Random_h

#include <Greeble/Rect.h>

namespace Greeble { namespace Random {
    Scalar scalar(const Scalar min, const Scalar max);
    Vec point(const AlignedRect rect);
    AlignedRect alignedRect(const Vec edgeLengthRange, const Vec aspectRatioRange);
    AlignedRect alignedRect(const AlignedRect bounds, const Vec edgeLengthRange, const Vec aspectRatioRange);
    Rect rect(const AlignedRect bounds, const Vec edgeLengthRange, const Vec aspectRatioRange, const Vec orientationRange);
}}

#endif /* Random_h */
