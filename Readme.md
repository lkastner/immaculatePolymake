# Immaculate line bundles on toric varieties - an Extension for polymake

## Purpose
This extension for [polymake] (https://www.polymake.org) was devloped alongside
the article [Immaculate line bundles on toric varieties - authors below]
(https://arxiv.org/abs/1808.09312). It can determine whether the whole
cohomology of a line bundle on a toric variety is trivial (we call such a line
bundle ``immaculate'') in a purely combinatorial manner.



## Installation
First clone the git into a directory. Then open polymake and
```
import_extension("/path/to/git/folder");
```
Most of the functionality is added to the toric application of polymake. This
application is named `fulton`. Before starting, switch to this application with
```
application "fulton";
```
The basic usage is explained below. For further examples, please have a look at
the `scripts` folder. This folder also contains the computations of the
article.

## Usage

### Immaculacy of divisors
One can determine directly, whether a divisor is immaculate, using the
`IMMACULATE` property introduced in the extension.
```
fulton > $tv = projective_space(3);

fulton > $d = $tv->DIVISOR(COEFFICIENTS=>[-1,-1,-1,-1]);

fulton > print $d->IMMACULATE;
false

```
As an intermediate step, one can determine the decomposition of a divisor into
nef divisors in the following way:
```
fulton > $tv = projective_space(3);

fulton > $d = $tv->DIVISOR(COEFFICIENTS=>[-1,-1,-1,-1]);

fulton > ($d1, $d2) = $tv->decompose_into_nef_pair($d);

fulton > print $d1->COEFFICIENTS;
0 0 0 0
fulton > print $d2->COEFFICIENTS;
4 0 0 0
fulton > print is_immaculate_pair($d1->SECTION_POLYTOPE, $d2->SECTION_POLYTOPE);
false
```
In the end, one can use `is_immaculate_pair` to determine immaculacy of a pair
of divisors.


## References
[Immaculate line bundles on toric varieties - authors below] (https://arxiv.org/abs/1808.09312)


## Authors
[Klaus Altmann] (http://www.math.fu-berlin.de/altmann/)

[Jarosław Buczyński] (https://www.mimuw.edu.pl/~jabu/)

[Lars Kastner] (http://page.math.tu-berlin.de/~kastner/)

[Anna-Lena Winz] (http://www.mi.fu-berlin.de/math/groups/ag-algebra/members/mitarbeiter/Winz.html)
