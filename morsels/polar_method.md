# Polar Method

**Given a source of uniformly-distributed random numbers, generate normally-distributed random numbers.**

**AKA:** Marsaglia polar method.

**See also:** More stuff we can use to generate normally-distributed random numbers are seen in the [Normally-Distributed Random Numbers Demo](../plates/normally_distributed_random_numbers_demo.md).

**Keywords:** Normal distribution, Gaussian distribution.

Attributed to the great George Marsaglia (along with with T. A. Bray, in the 1964 paper *A Convenient Method for Generating Normal Variables*).

⟨Polar Method normal RNG⟩ =
```C++
#include <cassert>
#include <cmath>
using namespace std;

⟨Random number generator types⟩
double polar_method_normal_rng(dump_rng_uniform_01 rng) {
    static bool hasZ2 = false;
    static double z2;

    if (hasZ2) {
        hasZ2 = false;
        return z2;
    } else {
        double u, v, s, z1;
        do {
            u = rng() * 2.0 - 1.0;
            v = rng() * 2.0 - 1.0;
            s = u*u + v*v;
        } while (s >= 1 || s == 0);

        double mul = sqrt(-2.0 * log(s) / s);
        z1 = u * mul;
        z2 = v * mul;
        hasZ2 = true;
        return z1;
    }
}
```

## References

* Wikipedia, *[Marsaglia polar method](https://en.wikipedia.org/wiki/Marsaglia_polar_method)*.
