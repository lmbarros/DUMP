//
// DUMP: Dump of Unsorted Morsels for Programmers
// Euclidean Algorithm
//
// Leandro Motta Barros, December 2017
//

module morsels.eclidean_algorithm;


// Implementations used nowadays tend to look like this one.
int euclidean_algorithm(int a, int b)
{
    do
    {
        auto c = a;
        a = b % a;
        b = c;
    } while (a > 0);

    return b;
}

unittest
{
    assert(euclidean_algorithm(4, 2) == 2);
    assert(euclidean_algorithm(2, 4) == 2);
    assert(euclidean_algorithm(40, 11) == 1);
    assert(euclidean_algorithm(10, 5) == 5);
    assert(euclidean_algorithm(12, 16) == 4);
    assert(euclidean_algorithm(20, 24) == 4);
}


// A recursive variation.
int euclidean_algorithm_recursive(int a, int b)
{
    if (b == 0)
        return a;
    else
        return euclidean_algorithm_recursive(b, a % b);
}

unittest
{
    assert(euclidean_algorithm_recursive(4, 2) == 2);
    assert(euclidean_algorithm_recursive(2, 4) == 2);
    assert(euclidean_algorithm_recursive(40, 11) == 1);
    assert(euclidean_algorithm_recursive(10, 5) == 5);
    assert(euclidean_algorithm_recursive(12, 16) == 4);
    assert(euclidean_algorithm_recursive(20, 24) == 4);
}


// This is a more direct translation of Euclid's original formulation, based on
// successive subtractions.
int euclidean_algorithm_original(int a, int b)
{
    while (a != b)
    {
        if (a > b)
            a -= b;
        else
            b -= a;
    }

    return a;
}

unittest
{
    assert(euclidean_algorithm_original(4, 2) == 2);
    assert(euclidean_algorithm_original(2, 4) == 2);
    assert(euclidean_algorithm_original(40, 11) == 1);
    assert(euclidean_algorithm_original(10, 5) == 5);
    assert(euclidean_algorithm_original(12, 16) == 4);
    assert(euclidean_algorithm_original(20, 24) == 4);
}
