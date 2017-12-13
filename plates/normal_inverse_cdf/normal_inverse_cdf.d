//
// DUMP: Dump of Unsorted Morsels for Programmers
// Normal Inverse CDF
//
// Leandro Motta Barros, December 2017
//

import morsels.acklams_normal_inverse_cdf.acklams_normal_inverse_cdf;

// Calls Gnuplot to plot the output of Acklam's approximation to the normal
// inverse CDF.
void main()
{
    import std.process;

    auto gnuPlot = pipeProcess("gnuplot", Redirect.stdin);
    gnuPlot.stdin.writeln("plot '-' with lines");

    auto x = 0.001;
    while (x < 1.0)
    {
        gnuPlot.stdin.writeln(x, " ", acklams_normal_inverse_cdf(x));
        x += 0.001;
    }

    gnuPlot.stdin.writeln("e");
    gnuPlot.stdin.writeln("pause mouse any");
    gnuPlot.stdin.flush();

    gnuPlot.stdin.writeln("exit");
    gnuPlot.stdin.flush();

    wait(gnuPlot.pid);
}
