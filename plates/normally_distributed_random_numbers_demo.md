# Normally-Distributed Random Numbers Demo

This plate uses different methods to generate normally-distributed numbers and create a file that can be passed to `gnuplot` to plot the results.

⟨file:normally_distributed_random_numbers_demo.cpp⟩ =
```C++
⟨Random number generator types⟩
⟨Acklam’s inverse normal CDF approximation⟩
⟨Acklam’s normal RNG⟩
⟨Box-Muller Transform⟩
⟨Box-Muller normal RNG⟩

⟨Simple uniform (0,1) RNG⟩

#include <fstream>

void plot(dump_rng_normal rng, std::ofstream& f, const char* title) {
    f << "plot '-' using (bin($1,binwidth)):(1.0) smooth freq with boxes title '" << title << "'\n";

    for (int i = 0; i < 25000; ++i)
        f << rng(dump_simple_uniform_01_rng) << '\n';

    f << "e\n"
      << "pause mouse any\n\n";
}

int main() {
    std::ofstream f("normally_distributed_random_numbers_demo.gnuplot");

    f << "binwidth = 0.1\n"
      << "set boxwidth binwidth\n"
      << "bin(x, width) = width * floor(x/width) + binwidth/2.0\n\n";

    plot(acklams_normal_rng, f, "Acklam");
    plot(box_muller_normal_rng, f, "Box-Muller");

    return 0;
}
```
