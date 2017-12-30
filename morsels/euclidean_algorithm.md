# Euclidean Algorithm

**Given two numbers, find their greatest common divider (GCD).**

Popularized by Euclid's Elements (circa 300 BC) but possibly discovered at least a handful of decades earlier, it is one of the oldest algorithms still regularly used.

Here's a good way to visualize this algorithm in action. You want to compute the GCD of two numbers, *a* and *b*. Start picturing a rectangle measuring *a*×*b*. Finding the GCD is equivalent to finding the size of the largest square tile that could be used to fully cover this rectangle.

The original formulation given by Euclid himself was based on successive subtractions, which can be seen as a way to shrink the largest side of the said rectangle until we end up with a square. (Just notice that both sides may alternate as the largest one as the algorithm runs).

⟨Original Euclidean Algorithm⟩ =
```C++
int euclidean_algorithm_original(int a, int b) {
    while (a != b) {
        if (a > b)
            a -= b;
        else
            b -= a;
    }

    return a;
}
```

Nowadays, everybody uses a more efficient implementation, based on the modulo operator. It is the same idea as before -- we are just shrinking our rectangle faster.

⟨Euclidean Algorithm⟩ =
```C++
int euclidean_algorithm(int a, int b) {
    do {
        auto c = a;
        a = b % a;
        b = c;
    } while (a > 0);

    return b;
}
```

Finally, for the sake of completeness, here's a recursive variation of the algorithm -- also a common spot in the wild.

⟨Recursive Euclidean Algorithm⟩ =
```C++
int euclidean_algorithm_recursive(int a, int b) {
    if (b == 0)
        return a;
    else
        return euclidean_algorithm_recursive(b, a % b);
}
```

## Nutrition Facts

**AKA:** Euclid's Algorithm.

**Keywords:** GCD, greatest common divisor, GCF, greatest common factor HCF, highest common factor, GCM, greatest common measure, HCD, highest common divisor.

## References

* Wikipedia, *[Euclidean Algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm)*.
* Robert Sedgewick, *Algorithms in C++*, Third Edition. Addison-Wesley, 1998. (Page 205.)
* Mladen Victor Wickerhauser, *Mathematics for Multimedia*. Birkhäuser, 2009. (Page 4.)
