# Acklam's Inverse Normal CDF Approximation Algorithm

**Calculate a good approximation of the inverse normal CDF at any given point in the (0, 1) interval.**

The inverse cumulative distribution function (CDF) of the normal distribution does not have a closed form. This algorithm provides an approximation of this function, which seems to be quite accurate (see details in the references). It was devised by Peter John Acklam in the early 2000s, maybe late 1990s (or so I estimate) and posted to his personal web page.

One use of this function is to generate random numbers following a normal (Gaussian) distribution. There many other uses, I am sure, but I cannot comment about them.

## Keywords

Inverse normal CDF, inverse normal cumulative distribution function, normal distribution quantile function, probit.

## References

* [John Peter Acklam's home page](http://home.online.no/~pjacklam/notes/invnorm/) (broken link)
* [John Peter Acklam's home page on the Wayback Machine](https://web.archive.org/web/20151110174102/http://home.online.no/~pjacklam/notes/invnorm/)
* [A post I made about the algorithm](https://stackedboxes.org/2017/05/01/acklams-normal-quantile-function/)
