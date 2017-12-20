# Box-Muller Transform

**Given a source of uniformly distributed random numbers, generate normally distributed random numbers.**

Published by George Edward Pelham Box and Mervin Edgar Muller in a 1958 paper. The idea was not original, though: Raymond E. A. C. Paley and Norbert Wiener had published it back in 1934 ([Stigler's law](https://en.wikipedia.org/wiki/Stigler%27s_law_of_eponymy) strikes again).

The transformation takes two uniformly distributed random numbers and produces two normally distributed numbers. Implementations tend to return one of these numbers immediately and keep the other one around so that it can be returned right away in the next call.

## See also

* [Acklam's Inverse Normal CDF Approximation Algorithm](acklams_inverse_normal_cdf.md) can be used for the same purpose.

## AKA

Box-Muller Transformation

## Keywords

Normal distribution, Gaussian dsitribution

## References

* [Wikipedia](https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform)
* Eric W. Weisstein, *[Box-Muller Transformation](http://mathworld.wolfram.com/Box-MullerTransformation.html)*. Wolfram's MathWorld.
* George Edward Pelham Box and Mervin Edgar Muller, *[A Note on the Generation of Random Normal Deviates](https://projecteuclid.org/euclid.aoms/1177706645)*. The Annals of Mathematical Statistics, 1958.
