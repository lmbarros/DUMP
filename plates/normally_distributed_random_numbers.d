//
// DUMP: Dump of Unsorted Morsels for Programmers
// Normally Distributed Random Numbers
//
// Leandro Motta Barros, December 2017
//

import morsels.box_muller_transform;


enum numSamples = 25_000;


// First, let's define a uniformly distributed random number generator. Since we
// want to benchmark only the "uniform to normal" conversion, we generate the
// whole random sequence beforehand. The `rng01` function itself
double[numSamples] uniformRandomNumbers;
int nextUniformRandomNumber = 0;

void initRNG()
{
    import std.random;
    foreach (i; 0..numSamples)
        uniformRandomNumbers[i] = uniform!"()"(0.0, 1.0);
    nextUniformRandomNumber = 0;
}

void resetRNG()
{
    nextUniformRandomNumber = 0;
}

double rng01()
{
    return uniformRandomNumbers[nextUniformRandomNumber++];
}


//
double [numSamples]normalNumbers;

void genNormalNumbers()
{
    resetRNG();
    foreach (i; 0..numSamples)
        normalNumbers[i] = box_muller_transform_rand(&rng01);
}


//
void main()
{
    import std.stdio;
    import std.process;

    initRNG();

    auto gnuPlot = pipeProcess("gnuplot", Redirect.stdin);
    gnuPlot.stdin.writeln("binwidth = 0.1");
    gnuPlot.stdin.writeln("set boxwidth binwidth");
    gnuPlot.stdin.writeln("bin(x, width) = width * floor(x/width) + binwidth/2.0");
    gnuPlot.stdin.writeln("plot '-' using (bin($1,binwidth)):(1.0) smooth freq with boxes title 'xxxxxxxxxxxxxxxxxxx'");

    genNormalNumbers();
    foreach (n; normalNumbers)
        gnuPlot.stdin.writeln(n);

    gnuPlot.stdin.writeln("e");
    gnuPlot.stdin.writeln("pause mouse any");
    gnuPlot.stdin.flush();

    gnuPlot.stdin.writeln("exit");
    gnuPlot.stdin.flush();

    wait(gnuPlot.pid);
}
