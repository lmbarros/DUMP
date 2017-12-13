//
// DUMP: Dump of Unsorted Morsels for Programmers
// Acklam's Normal Inverse CDF
//
// Leandro Motta Barros, December 2017
//

module morsels.acklams_normal_inverse_cdf.acklams_normal_inverse_cdf;

// This is a pretty straightforward conversion of the pseudocode provided by
// Peter John Acklam himself in his now-defuct web page.
double acklams_normal_inverse_cdf(double p)
{
    import std.math: sqrt, log;

    assert(p > 0.0 && p < 1.0, "`p` must be in the open interval (0, 1)");

    // Coefficients in rational approximations
    const a1 = -3.969683028665376e+01;
    const a2 =  2.209460984245205e+02;
    const a3 = -2.759285104469687e+02;
    const a4 =  1.383577518672690e+02;
    const a5 = -3.066479806614716e+01;
    const a6 =  2.506628277459239e+00;

    const b1 = -5.447609879822406e+01;
    const b2 =  1.615858368580409e+02;
    const b3 = -1.556989798598866e+02;
    const b4 =  6.680131188771972e+01;
    const b5 = -1.328068155288572e+01;

    const c1 = -7.784894002430293e-03;
    const c2 = -3.223964580411365e-01;
    const c3 = -2.400758277161838e+00;
    const c4 = -2.549732539343734e+00;
    const c5 =  4.374664141464968e+00;
    const c6 =  2.938163982698783e+00;

    const d1 =  7.784695709041462e-03;
    const d2 =  3.224671290700398e-01;
    const d3 =  2.445134137142996e+00;
    const d4 =  3.754408661907416e+00;

    // Break-points
    const pLow  = 0.02425;
    const pHigh = 1 - pLow;

    // Rational approximation for lower region
    if (p < pLow)
    {
        const q = sqrt(-2 * log(p));
        return (((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
    }

    // Rational approximation for central region
    else if (p <= pHigh)
    {
       const q = p - 0.5;
       const r = q * q;
       return (((((a1 * r + a2) * r + a3) * r + a4) * r + a5) * r + a6) * q /
           (((((b1 * r + b2) * r + b3) * r + b4) * r + b5) * r + 1);
    }

    // Rational approximation for upper region
    else
    {
        const q = sqrt(-2 * log(1-p));
        return -(((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
    }
}
