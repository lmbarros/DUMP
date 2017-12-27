# Benchmarking

Our support for benchmarking is pretty basic. We just want to know how many times per second a given piece of code executes. This piece of code will be represented as function without parameters. Noticed that it returns an `int`? We'll use this return value, but not in any special way. This is just to avoid the call to be optimized away. So, just make sure your functions return anything non-obvious.

⟨Benchmarking utilities⟩ =
```C++
typedef int (*dump_benchmarkable_function)();
```

Our strategy is calling the code to be benchmarked in a loop and measure how many times it executed per second. We want this loop to execute for at least `dump_benchmarking_min_time` seconds. If the loop execution takes less than that, we'll increase the number of executions.

In this increment, we'll try to estimate how many calls we need to make to ensure that the execution takes those `dump_benchmarking_min_time` seconds. However, to avoid surprises, let's say that we'll never increment by less than `dump_benchmarking_min_increment_multiplier` times nor by more than `dump_benchmarking_max_increment_multiplier` times. The actual increment is obviously an integer that must be greater than 1. And one extra detail: when incrementing, we'll not target the minimum time, but some slightly larger value `dump_benchmarking_target_time`; this makes us reach the minimum time quicker.

⟨Benchmarking utilities⟩ +=
```C++
const double dump_benchmarking_min_time = 3.0;
const double dump_benchmarking_target_time = 3.3;
const double dump_benchmarking_min_increment_multiplier = 1.1;
const double dump_benchmarking_max_increment_multiplier = 500.0;
```

We'll use C++'s `chrono` library for measuring the elapsed time. Here's the code implementing the strategy outlined above. The `dump_benchmark()` takes two parameters: one "title" to be displayed along with the number of executions per second and the function to benchmark.

⟨Benchmarking utilities⟩ +=
```C++
#include <chrono>
#include <iostream>
using namespace std::chrono;
using namespace std;

void dump_benchmark(const char* title, dump_benchmarkable_function f) {
    typedef high_resolution_clock clock_t;
    typedef time_point<clock_t> time_point_t;
    typedef duration<double, ratio<1> > second_t;

    double time_taken = 0.0;
    unsigned long num_calls = 1;
    double calls_per_second = 0.0;
    int dummy = 0;

    do {
        time_point_t start = clock_t::now();

        for (unsigned long i = 0; i < num_calls; ++i)
            dummy += f();

        time_taken = duration_cast<second_t>(clock_t::now() - start).count();

        calls_per_second = num_calls / time_taken;
        unsigned long ideal_num_calls =
            calls_per_second * dump_benchmarking_target_time;
        double ideal_increment_multiplier = (double)ideal_num_calls / num_calls;

        double increment_multiplier = ideal_increment_multiplier;
        if (increment_multiplier > dump_benchmarking_max_increment_multiplier)
            increment_multiplier = dump_benchmarking_max_increment_multiplier;
        if (increment_multiplier < dump_benchmarking_min_increment_multiplier)
            increment_multiplier = dump_benchmarking_min_increment_multiplier;

        ideal_num_calls = num_calls * increment_multiplier;

        if (ideal_num_calls == num_calls)
            ++ideal_num_calls;

        num_calls = ideal_num_calls;
    } while (time_taken < dump_benchmarking_min_time);

    cout << "[" << calls_per_second << " calls/second] " << title
         << (dummy % 2 ? " \n" : "\n");
}
```
