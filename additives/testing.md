# Testing

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
