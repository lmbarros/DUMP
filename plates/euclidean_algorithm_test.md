# Euclidean Algorithm Test

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

    return 0;
}
```
