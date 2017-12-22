# DUMP: Dump of Unsorted Morsels for Programmers

**What is this?** This is a repository of more or less random programming things, which I am making for my own amusement and edification (and reference,I guess).  I don't know how this will evolve over time (if at all), but I imagine this will consist mainly in implementations of algorithms and data structures.

**What is in?** DUMP is composed of two main parts: the [morsels](#morsels) and the [plates](#plates). Morsels are the *raison d'être* of this "project", they are the "programming things" themselves. Plates are things made with the morsels: demonstrations, benchmarks, perhaps visualizations. A third part, [additives](#additives) (yeah, I am abusing the the metaphor!) are some infrastructure and utilities used by the two main parts.

**Which language and why?** I wanted to include both code and written notes about the "programming things". I soon noted that [literate programming](https://en.wikipedia.org/wiki/Literate_programming) would be a nice tool for this endeavor, so I quickly hacked a Markdown-based tool for this task: [Halp](https://github.com/lmbarros/Halp) (there already several other, arguably better Markdown-based literate programming tools around; I just wanted something slightly different than them). So, this very file is DUMP's source code. I use Halp to extract the code snippets to files that can be further compiled.

Concerning the code itself: given the reference aspect of DUMP, I'd prefer to write everything in C (The One True Lingua Franca of Computing and one that will probably be around for a long time). Too bad I can't stand writing much C anymore. So, I am resorting to C++ (which wouldn't be my number one choice for pretty much anything else these days). I'll try to restrain myself to the C subset of C++ as much as I can while still having fun, especially in the morsels -- I'll be more liberal in the plates and additives.

**What else?** Needless to say, this is by no means a library of ready-to-reuse stuff.

**Licensing.** DUMP is licensed under the [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) license. In additional to this, the code snippets (everything enclosed in triple backticks) are also licensed under the [MIT license](LICENSE.MIT.md).


## <a name="morsels"></a>Morsels

<!-- Morsel template

### Name

**Summary:** Blah.

**AKA:** Blah.

**Complexity:** O(*n*)

**See also:** [Other morsel](#other-morsel)

**Keywords:** Skeleton, keyhole, lock, public, private.

#### Notes and Implementation

Blah, blah, implementation, blah, blah...

#### References

* Wikipedia, *[Morsel](https://en.wikipedia.org/wiki/Morsel)*.
* Author, *Book title*, Edition. Publisher, Year. (Page 123.)
* Author, *Paper title*. Conference/Magazine, Year.
* Eric W. Weisstein, *[Article Name](http://mathworld.wolfram.com/Article.html)*. Wolfram's MathWorld.

-->

### Euclidean Algorithm

**Summary:** Given two numbers, find their greatest common divider (GCD).

**AKA:** Euclid's Algorithm

**Keywords:** GCD, greatest common divisor, GCF, greatest common factor HCF, highest common factor, GCM, greatest common measure, HCD, highest common divisor.

#### Notes and Implementation

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

#### References

* Wikipedia, *[Euclidean Algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm)*.
* Robert Sedgewick, *Algorithms in C++*, Third Edition. Addison-Wesley, 1998. (Page 205.)
* Mladen Victor Wickerhauser, *Mathematics for Multimedia*. Birkhäuser, 2009. (Page 4.)


## <a name="plates"></a>Plates

### Euclidean Algorithm Test

This is just a simple test for the various implementations of the Euclidean Algorithm we discussed in the Morsels section.

⟨file:euclidean_algorithm_test.cpp⟩ =
```C++
⟨Assert routines for testing⟩

⟨Original Euclidean Algorithm⟩
⟨Euclidean Algorithm⟩
⟨Recursive Euclidean Algorithm⟩

int main() {
    dump_assert_equals(euclidean_algorithm_original(4, 2), 2);
    dump_assert_equals(euclidean_algorithm_original(12, 16), 4);
    dump_assert_equals(euclidean_algorithm_original(40, 11), 1);
    dump_assert_equals(euclidean_algorithm_original(356, 44), 4);

    dump_assert_equals(euclidean_algorithm(555, 33), 3);
    dump_assert_equals(euclidean_algorithm(33, 555), 3);
    dump_assert_equals(euclidean_algorithm(17, 17), 17);
    dump_assert_equals(euclidean_algorithm(56, 12), 4);

    dump_assert_equals(euclidean_algorithm_recursive(15, 5), 5);
    dump_assert_equals(euclidean_algorithm_recursive(1234, 4321), 1);
    dump_assert_equals(euclidean_algorithm_recursive(3000, 69), 3);
    dump_assert_equals(euclidean_algorithm_recursive(12, 501), 3);
}
```

## <a name="additives"></a>Additives

Additives are assorted utilities used by the morsels and plates.

### Testing

The most fundamental testing facilities are a nice set of `assert`-like routines. This particular implementation is tailored for DUMP's needs: simple test applications that are showcases of the morsels. We want to be very explicit about what the test is testing, that's why we are quite verbose even when the test succeeds. As for failures, we bail out on the first error, because our tests here we are expected to always succeed.

We use a pair of `auto` intermediate variables (`a` and `b`) to make sure that the expressions passed as parameters are evaluated only once. By the way, we are well into the 21st century and I am still using preprocessor macros. Well, maybe the latest revisions of C++ have some cryptic replacement for them, but this will do for now.

⟨Assert routines for testing⟩ =
```C++
#include <iostream>
#include <cstdlib>

#define dump_assert_equals(exprA, exprB)                             \
    {                                                                \
        auto a = (exprA);                                            \
        auto b = (exprB);                                            \
        std::cout << #exprA << " == " << #exprB << "? ";             \
        if (a == b) {                                                \
            std::cout << "[Yup! " << a << " == " << b << "]\n";      \
        } else {                                                     \
            std::cout << "[Nope! " << a << " != " << b << "]\n";     \
            std::exit(1);                                            \
        }                                                            \
    }
```
