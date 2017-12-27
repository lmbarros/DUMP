# Random numbers

## RNG-related types

First, let's define some random number generator (RNG) types. A `dump_rng_uniform_01` must return a random number drawn from an uniform distribution in the open interval (0, 1). Similarly, `dump_rng_normal` must return a random number drawn from a standard normal (Gaussian) distribution (mean μ=0, standard deviaton σ=1) from a `dump_rng_uniform_01`.

⟨Random number generator types⟩ =
```C++
#ifndef _DUMP_RANDOM_NUMBER_GENERATOR_TYPES_
#define _DUMP_RANDOM_NUMBER_GENERATOR_TYPES_

typedef double (*dump_rng_uniform_01)();
typedef double (*dump_rng_normal)(dump_rng_uniform_01);

#endif
```

## Simple uniform (0, 1) RNG

And here's simple generator of uniformly-distributed random numbers in the (0,1) open interval.

⟨Simple uniform (0,1) RNG⟩ =
```C++
#include <cstdlib>
using namespace std;

double dump_simple_uniform_01_rng() {
    double u = 0.0;
    do {
        u = rand() / (double)RAND_MAX;
    } while (u <= 0.0 || u >= 1.0);

    return u;
}
```

We also want a way to randomize our RNG. We don't need to be fancy here.

⟨Simple uniform (0,1) RNG⟩ +=
```C++
#include <ctime>
using namespace std;

void dump_randomize_simple_uniform_01_rng() {
    srand(time(0));
}
```

## Fake uniform (0, 1) RNG

You know when you want to do some benchmarking related with RNGs, but you don't want your timings to be too influenced by the RNG itself. So here's an RNG that should be quite fast, though it will score pretty badly in terms of randomness.

It uses the "Simple uniform (0, 1) RNG" defined above to pre-generate a bunch of random numbers, then just draw from this "buffer" as needed.

⟨Fake uniform (0,1) RNG⟩ =
```C++
⟨Simple uniform (0,1) RNG⟩

const size_t dump_fake_uniform_01_buffer_size = 10000;

double dump_fake_uniform_01_buffer[dump_fake_uniform_01_buffer_size];

void dump_fake_uniform_01_rng_init() {
    dump_randomize_simple_uniform_01_rng();

    for (unsigned i = 0; i < dump_fake_uniform_01_buffer_size; ++i)
        dump_fake_uniform_01_buffer[i] = dump_simple_uniform_01_rng();
}

double dump_fake_uniform_01_rng() {
    static size_t index = 0;

    size_t i = index++ % dump_fake_uniform_01_buffer_size;
    return dump_fake_uniform_01_buffer[i];
}
```
