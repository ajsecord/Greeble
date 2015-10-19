#ifndef Annealing_h
#define Annealing_h

#include <Greeble/Random.h>
#include <Greeble/Types.h>

namespace Greeble {
    namespace Annealing {
        // A do-nothing reporter object if you don't care about the output.
        template <typename State>
        struct NullReporter {
            void operator()(const State& state, const Scalar temp, const size_t iters) {}
        };

        template <typename State, typename Problem, typename Reporter>
        std::tuple<State, Scalar> optimize(const Problem& problem, const State& initialState,
                                           const Scalar initialTemp, const Scalar minTemp,
                                           Reporter reporter,
                                           const size_t maxIters) {
            State state = initialState;
            Scalar temp = initialTemp;
            Scalar energy = problem.evalEnergy(initialState);

            size_t iters = 0;
            while (temp > minTemp && iters < maxIters) {
                reporter(state, temp, iters);

                ++iters;

                const State neighbor = problem.selectNeighbor(state);
                const Scalar newEnergy = problem.evalEnergy(neighbor);

                // If better, take it.  If not, maybe take it.
                if (newEnergy < energy || Random::scalar(0, 1) < exp((energy - newEnergy) / temp)) {
                    state = neighbor;
                    energy = newEnergy;
                }

                // Reduce temperature.
                const Scalar oldTemp = temp;
                temp = problem.reduceTemp(temp); // More params?
                assert(temp <= oldTemp);
            }

            return std::make_tuple(state, temp);
        }
    }
}

#endif /* Annealing_h */
