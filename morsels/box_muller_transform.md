# Box-Muller Transform

**Given a source of uniformly-distributed random numbers, generate normally-distributed random numbers.**

Published by George Edward Pelham Box and Mervin Edgar Muller in a 1958 paper. The idea was not original, though: Raymond E. A. C. Paley and Norbert Wiener had published it back in 1934 ([Stigler's law](https://en.wikipedia.org/wiki/Stigler%27s_law_of_eponymy) strikes again).

How *exactly* this works is beyond my comprehension, but the idea is that the transformation starts from two uniformly-distributed random numbers in the (0, 1) interval (`u1` and `u2` in the implementation below). These numbers are converted to a vector of length `r` and angle `theta`. The projections of this vector in either axis (`z1` and `z2`) will be normally-distributed. There is a [very nice visualization](https://en.wikipedia.org/wiki/File:Box-Muller_transform_visualisation.svg) of this process in Wikipedia.

⟨Box-Muller Transform⟩ =
```C++
#include <cassert>
#include <cmath>
using namespace std;

void box_muller_transform(double u1, double u2, double* z0, double* z1) {
    assert(u1 > 0.0 && u1 < 1.0);
    assert(u2 > 0.0 && u2 < 1.0);

    double r = sqrt(-2 * log(u1));
    double theta = 2 * M_PI * u2;

    *z0 = r * cos(theta);
    *z1 = r * sin(theta);
}
```

That was an implementation of the transform *per se*. Most implementations we see around are more like the one below. They already include calls to a uniform random number generator (`rng`) and return only one of the two numbers immediately (`z1`); the other one (`z2`) is kept around so that it can be returned right away in the next call.

⟨Box-Muller normal RNG⟩ =
```C++
⟨Random number generator types⟩

double box_muller_normal_rng(dump_rng_uniform_01 rng) {
    static bool hasZ2 = false;
    static double z2;

    if (hasZ2) {
        hasZ2 = false;
        return z2;
    }

    double z1;
    double u1 = rng();
    double u2 = rng();
    box_muller_transform(u1, u2, &z1, &z2);
    hasZ2 = true;

    return z1;
}
```

## Nutrition Facts

**AKA:** Box-Muller Transformation.

**See also:** The [Polar Method](polar_method.md) is a variation of this method, which doesn't require to compute the sine and cosine. More stuff we can use to generate normally-distributed random numbers are seen in the [Normally-Distributed Random Numbers Demo](../plates/normally_distributed_random_numbers_demo.md).

**Keywords:** Normal distribution, Gaussian distribution.

## References

* Wikipedia, *[Box-Muller Transform](https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform)*.
* Eric W. Weisstein, *[Box-Muller Transformation](http://mathworld.wolfram.com/Box-MullerTransformation.html)*. Wolfram's MathWorld.
* George Edward Pelham Box and Mervin Edgar Muller, *[A Note on the Generation of Random Normal Deviates](https://projecteuclid.org/euclid.aoms/1177706645)*. The Annals of Mathematical Statistics, 1958.
