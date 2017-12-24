# DUMP: Dump of Unsorted Morsels for Programmers

**What is this?** This is a repository of more or less random programming things, which I am making for my own amusement and edification (and reference,I guess).  I don't know how this will evolve over time (if at all), but I imagine this will consist mainly in implementations of algorithms and data structures.

**What is in?** DUMP is composed of two main parts: the [morsels](morsels) and the [plates](plates). Morsels are the *raison d'être* of this "project", they are the "programming things" themselves. Plates are things made with the morsels: demonstrations, benchmarks, perhaps visualizations. A third part, [additives](additives) (yeah, I am abusing the the metaphor!) are some infrastructure and utilities used by the two main parts.

**Which language and why?** I wanted to include both code and written notes about the "programming things". I soon noted that [literate programming](https://en.wikipedia.org/wiki/Literate_programming) would be a nice tool for this endeavor, so I quickly hacked a Markdown-based tool for this task: [Halp](https://github.com/lmbarros/Halp) (there already several other, arguably better Markdown-based literate programming tools around; I just wanted something slightly different than them). So, this very file is DUMP's source code. I use Halp to extract the code snippets to files that can be further compiled.

Concerning the code itself: given the reference aspect of DUMP, I'd prefer to write everything in C (The One True Lingua Franca of Computing and one that will probably be around for a long time). Too bad I can't stand writing much C anymore. So, I am resorting to C++ (which wouldn't be my number one choice for pretty much anything else these days). I'll try to restrain myself to the C subset of C++ as much as I can while still having fun, especially in the morsels -- I'll be more liberal in the plates and additives.

**What else?** Needless to say, this is by no means a library of ready-to-reuse stuff.

**Licensing.** DUMP is licensed under the [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) license. The code snippets are also licensed under the [MIT license](LICENSE.MIT.md). See [LICENSE.md](LICENSE.md) for details.
