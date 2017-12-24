# Random numbers

First, let's define some random number generator (RNG) types. A `dump_rng_uniform_01` must return a random number drawn from an uniform distribution in the open interval (0, 1). Similarly, `dump_rng_normal` must return a random number drawn from a standard normal (Gaussian) distribution (mean μ=0, standard deviaton σ=1) from a `dump_rng_uniform_01`.

⟨Random number generator types⟩ =
```C++
#ifndef _DUMP_RANDOM_NUMBER_GENERATOR_TYPES_
#define _DUMP_RANDOM_NUMBER_GENERATOR_TYPES_

typedef double (*dump_rng_uniform_01)();
typedef double (*dump_rng_normal)(dump_rng_uniform_01);

#endif
```

And here's simple generator of uniformly-distributed random numbers in the (0,1) open interval.

⟨Simple uniform (0,1) RNG⟩ =
```C++
#include <cstdlib>

double dump_simple_uniform_01_rng() {
    double u = 0.0;
    do {
        u = rand() / (double)RAND_MAX;
    } while (u <= 0.0 || u >= 1.0);

    return u;
}
```
