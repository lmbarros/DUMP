    # Polar Method

**Given a source of uniformly-distributed random numbers, generate normally-distributed random numbers.**

**AKA:** Marsaglia polar method.

**See also:** This is a variation of the [Box-Muller Transform](box_muller_transform.md). More stuff we can use to generate normally-distributed random numbers are seen in the [Normally-Distributed Random Numbers Demo](../plates/normally_distributed_random_numbers_demo.md).

**Keywords:** Normal distribution, Gaussian distribution.

This method was, it seems, initially proposed by the great George Marsaglia along with T. A. Bray, in the 1964 paper *A Convenient Method for Generating Normal Variables*.

The Polar Method is a variation of the [Box-Muller Transform](box_muller_transform,md). Instead of directly creating the angle and magnitude of a vector and then projecting it to the axes, this method goes through a different route. It first create a point lying in the unit circle (and it does so by trial and error, rejecting points that fall outside it, in the `do`/`while` loop).

Then, this point is scaled so that it lies in the unit circumference (that's the division by `sqrt(s)`). Finally, it is scaled by some magic number (the multiplication by `sqrt(-2.0 * log(s))`, which, by the way, can also be seen in Box-Muller) which will leave the point in exactly the same position as the tip of the Box-Muller vector. Since here the point is already in rectangular coordinates, we can use it directly, without using sine and cosine to project it to the axes.

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

        double m = sqrt(-2.0 * log(s) / s);
        z1 = u * m;
        z2 = v * m;
        hasZ2 = true;
        return z1;
    }
}
```

## References

* Wikipedia, *[Marsaglia polar method](https://en.wikipedia.org/wiki/Marsaglia_polar_method)*.
