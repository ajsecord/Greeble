#include <algorithm>
#include <iostream>

#include <Greeble/SimulatedAnnealing.h>
#include <Greeble/Types.h>

using namespace Greeble;

struct SampleProblem {
    struct State {
        Scalar energy;
    };

    State selectNeighbor(const State& state) const {
        State neighbor = state;
        neighbor.energy += Random::scalar(-1, 1);
        return neighbor;
    }

    Scalar evalEnergy(const State& state) const {
        return state.energy;
    }

    Scalar reduceTemp(const Scalar temp) const {
        //return std::max<Scalar>(0, temp - 1);
        return 0.99 * temp;
    }
};

struct SampleReporter {
    void operator()(const SampleProblem::State& state, const Scalar temp, const size_t iters) {
        std::cout << state.energy << ' ' << temp << ' ' << iters << '\n';
    }
};


int main(int argc, const char * argv[]) {
    SampleProblem problem;
    SampleProblem::State state = { 100 };
    SampleReporter reporter;
    std::tuple<SampleProblem::State, Scalar> result = SimulatedAnnealing::optimize(problem, state, 1000, 1e-3, reporter, 10000);
    std::cout << "Final: " << std::get<0>(result).energy << ' ' << std::get<1>(result) << std::endl;
    return 0;
}
