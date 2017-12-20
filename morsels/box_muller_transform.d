//
// DUMP: Dump of Unsorted Morsels for Programmers
// Box-Muller Transform
//
// Leandro Motta Barros, December 2017
//

module morsels.box_muller_transform;


// This is an implementation of transform itself: it takes two numbers from a
// uniform distribution (`u1` and `u2`) and returns two numbers normally
// distributed (`z0` and `z1`).
void box_muller_transform(double u1, double u2, double* z0, double* z1)
{
    import std.math;

    assert(u1 > 0.0 && u1 < 1.0, "Input `u1` must be in the (0, 1) interval");
    assert(u2 > 0.0 && u2 < 1.0, "Input `u2` must be in the (0, 1) interval");

    *z0 = sqrt(-2 * log(u1)) * cos(2 * PI * u2);
    *z1 = sqrt(-2 * log(u1)) * sin(2 * PI * u2);
}


// Function that generates random numbers in the (0, 1) interval.
alias RNG01 = double function();

// This is how the transform is often used: in conjunction with a random number
// generator, to generate normally-distrbuted numbers.
double box_muller_transform_rand(RNG01 rng01)
{
    static bool hasZ1 = false;
    static double z1;

    if (hasZ1)
    {
        hasZ1 = false;
        return z1;
    }

    double z0;
    double u1 = rng01();
    double u2 = rng01();
    box_muller_transform(u1, u2, &z0, &z1);
    hasZ1 = true;

    return z0;
}
