# Normally-Distributed Random Numbers Benchmark

So we have different methods to generate normally-distributed random numbers from a source of uniformly-distributed random number. How fast they are compared to each other? Let's find out!

Our main file looks like this:

⟨file:normally_distributed_random_numbers_benchmark.cpp⟩ =
```C++
⟨Normally-Distributed Random Numbers Benchmark definitions⟩

int main() {
    ⟨Main code for the Normally-Distributed Random Numbers Benchmark⟩
    return 0;
}
```

We'll need to use DUMP's benchmarking utilities and our fake uniform random number generator (RNG).

⟨Normally-Distributed Random Numbers Benchmark definitions⟩ =
```C++
⟨Benchmarking utilities⟩
⟨Fake uniform (0,1) RNG⟩
```

Next, let's define the function to be benchmarked, based on Acklam's algorithm.

⟨Normally-Distributed Random Numbers Benchmark definitions⟩ +=
```C++
⟨Acklam’s inverse normal CDF approximation⟩
⟨Acklam’s normal RNG⟩

double acklams_fake() {
    return acklams_normal_rng(dump_fake_uniform_01_rng);
}

int acklams_draw() {
    return (int)acklams_fake();
}
```

Same for Box-Muller.

⟨Normally-Distributed Random Numbers Benchmark definitions⟩ +=
```C++
⟨Box-Muller Transform⟩
⟨Box-Muller normal RNG⟩

double box_muller_fake() {
    return box_muller_normal_rng(dump_fake_uniform_01_rng);
}

int box_muller_draw() {
    return (int)box_muller_fake();
}
```

Same for the Polar Method.

⟨Normally-Distributed Random Numbers Benchmark definitions⟩ +=
```C++
⟨Polar Method normal RNG⟩

double polar_method_fake() {
    return polar_method_normal_rng(dump_fake_uniform_01_rng);
}

int polar_method_draw() {
    return (int)polar_method_fake();
}
```

Same for Ziggurat Algorithm:
⟨Normally-Distributed Random Numbers Benchmark definitions⟩ +=
```C++
⟨Ziggurat Algorithm normal RNG⟩

double ziggurat_algorithm_fake() {
    return ziggurat_algorithm_normal_rng(dump_fake_uniform_01_rng);
}

int ziggurat_algorithm_draw() {
    return (int)ziggurat_algorithm_fake();
}
```



And here's our main code: we just initialize the fake RNG and benchmark the desired functions.

⟨Main code for the Normally-Distributed Random Numbers Benchmark⟩ =
```C++
dump_fake_uniform_01_rng_init();

dump_benchmark("Acklam's", acklams_draw);
dump_benchmark("Box-Muller", box_muller_draw);
dump_benchmark("Polar Method", polar_method_draw);
dump_benchmark("Ziggurat Algorithm", ziggurat_algorithm_draw);
```

## Results

For those curious, this is what I get from an Intel Core i5-4460 @ 3.20GHz:

```
[8.45665e+07 calls/second] Acklam's
[2.13757e+07 calls/second] Box-Muller
[4.68149e+07 calls/second] Polar Method
```
