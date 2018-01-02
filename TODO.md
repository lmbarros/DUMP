# DUMP: Dump of Unsorted Morsels for Programmers

## TODO

### General improvements

* I have one or two cases of `#ifdef`s in the code to avoid having stuff being defined multiple times. I should add to [Halp](https://github.com/lmbarros/Halp) the ability to define blocks that are expanded at most once per output file. This would be cleaner for whover would be reading the code.

### Stuff I'd like to include

* Sorting algorithms. Too classic to not include! I should consider implementing an additive to measure things like number of comparisons and the number of swaps. Would be nice for benchmarking, but would also make the implementations more noisy. Must weight the pros and cons.
* [The Right Way to Calculate Stuff](http://www.plunk.org/~hatch/rightway.php). This is some wonderful material by Don Hatch, which I'd hate to lose. (We'll, I never really used this stuff, but somehow I am sure this will save my life sooner or later).
* Kumaraswamy distribution ([Wikipedia](https://en.wikipedia.org/wiki/Kumaraswamy_distribution), [random blog post](https://www.johndcook.com/blog/2009/11/24/kumaraswamy-distribution/)). I'd like to play around with this distribution a bit. Could be a useful thing to include in general-purpose RNG routines.
