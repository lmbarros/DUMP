# Acklam's Inverse Normal CDF Approximation Algorithm

**Calculate a good approximation of the inverse normal CDF at any given point in the (0, 1) interval.**

**See also:** More stuff we can use to generate normally-distributed random numbers are seen in the [Normally-Distributed Random Numbers Demo](../plates/normally_distributed_random_numbers_demo.md).

**Keywords:** Inverse normal CDF, inverse normal cumulative distribution function, normal distribution quantile function, probit.

The inverse cumulative distribution function (CDF) of the normal distribution does not have a closed form. This algorithm provides an approximation of this function, which seems to be quite accurate (see details in the references). It was devised by Peter John Acklam in the early 2000s (maybe late 1990s, I am estimating these dates), who posted it to his personal web page.

One use of this function is to generate random numbers following a normal (Gaussian) distribution. There are many other uses, I am sure, but I cannot comment about them.

The following implementation is a pretty straightforward conversion of the pseudocode originally published by Mr. Acklam himself.

⟨Acklam’s inverse normal CDF approximation⟩ =
```C++
#include <cmath>
#include <cassert>
using namespace std;

double acklams_inverse_normal_cdf(double p) {
    assert(p > 0.0 && p < 1.0);

    // Coefficients in rational approximations
    const double a1 = -3.969683028665376e+01;
    const double a2 =  2.209460984245205e+02;
    const double a3 = -2.759285104469687e+02;
    const double a4 =  1.383577518672690e+02;
    const double a5 = -3.066479806614716e+01;
    const double a6 =  2.506628277459239e+00;

    const double b1 = -5.447609879822406e+01;
    const double b2 =  1.615858368580409e+02;
    const double b3 = -1.556989798598866e+02;
    const double b4 =  6.680131188771972e+01;
    const double b5 = -1.328068155288572e+01;

    const double c1 = -7.784894002430293e-03;
    const double c2 = -3.223964580411365e-01;
    const double c3 = -2.400758277161838e+00;
    const double c4 = -2.549732539343734e+00;
    const double c5 =  4.374664141464968e+00;
    const double c6 =  2.938163982698783e+00;

    const double d1 =  7.784695709041462e-03;
    const double d2 =  3.224671290700398e-01;
    const double d3 =  2.445134137142996e+00;
    const double d4 =  3.754408661907416e+00;

    // Break-points
    const double pLow  = 0.02425;
    const double pHigh = 1 - pLow;

    // Rational approximation for lower region
    if (p < pLow) {
        const double q = sqrt(-2 * log(p));
        return (((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
    }

    // Rational approximation for central region
    else if (p <= pHigh) {
       const double q = p - 0.5;
       const double r = q * q;
       return (((((a1 * r + a2) * r + a3) * r + a4) * r + a5) * r + a6) * q /
           (((((b1 * r + b2) * r + b3) * r + b4) * r + b5) * r + 1);
    }

    // Rational approximation for upper region
    else {
        const double q = sqrt(-2 * log(1-p));
        return -(((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
    }
}
```

Once we have a way to approximate the inverse normal CDF, we can easily apply the [inverse transform sampling method](https://en.wikipedia.org/wiki/Inverse_transform_sampling) to generate normally-distributed numbers from a given source of uniformly-distributed random numbers.

⟨Acklam’s normal RNG⟩ =
```C++
⟨Random number generator types⟩

double acklams_normal_rng(dump_rng_uniform_01 rng) {
    return acklams_inverse_normal_cdf(rng());
}
```

## References

* [Peter John Acklam's home page](http://home.online.no/~pjacklam/notes/invnorm/) (broken link)
* [Peter John Acklam's home page on the Wayback Machine](https://web.archive.org/web/20151110174102/http://home.online.no/~pjacklam/notes/invnorm/)
* [A post I made about the algorithm](https://stackedboxes.org/2017/05/01/acklams-normal-quantile-function/)
