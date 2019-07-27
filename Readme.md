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

### Tempting subsets
There is a method `find_temptings`, taking a fan and returning the tempting
subsets of the rays, as sets of indices:
```
fulton > $hexagon = new Polytope(POINTS=>[[1,0,0],[1,1,0],[1,2,1],[1,2,2],[1,1,2],[1,0,1]]);

fulton > $fan = normal_fan($hexagon);

fulton > @tempt = find_temptings($fan);

fulton > print join("\n", @tempt);
{0 3}
{0 4}
{0 5}
{1 2}
{1 3}
{1 4}
{2 4}
{2 5}
{3 5}
{0 1 3}
{0 1 4}
{0 2 4}
{0 2 5}
{0 3 4}
{0 3 5}
{0 4 5}
{1 2 3}
{1 2 4}
{1 2 5}
{1 3 4}
{1 3 5}
{2 3 5}
{2 4 5}
{0 1 2 4}
{0 1 3 4}
{0 1 3 5}
{0 2 3 5}
{0 2 4 5}
{0 3 4 5}
{1 2 3 4}
{1 2 3 5}
{1 2 4 5}
{0 1 2 3 4 5}
{}
```
The result is a perl array of `Set<Int>`s.


### Immaculate locus
The immaculate locus can be computed as the repeated intersection of
complements of cones. Usually these complements are not closed, but since we
are only interested in the lattice points thereof, we can just move the facets
of a cone out by one and change its directions. The complement is then the
union of these halfspaces. Intersecting complements of cones boils down to
intersecting these halfspaces. We have implemented this approach as a
`user_method` of `NormalToricVariety`:
```
fulton > $hexagon = new Polytope(POINTS=>[[1,0,0],[1,1,0],[1,2,1],[1,2,2],[1,1,2],[1,0,1]]);

fulton > $fan = normal_fan($hexagon);

fulton > $tv = new NormalToricVariety($fan);

fulton > @imm = $tv->immaculate_locus;
There are 34 intersection steps ahead.
Step 1: The cone has 6 facets.
Step 1: The result contains 5 polyhedra.
Step 2: The cone has 6 facets.
Step 2: The result contains 7 polyhedra.
Step 3: The cone has 6 facets.
Step 3: The result contains 10 polyhedra.
[...]
Step 34: The cone has 6 facets.
Step 34: The result contains 83 polyhedra.

fulton > print scalar @imm;
83
fulton > @bounded = grep($_->BOUNDED, @imm);

fulton > print scalar @bounded;
80
fulton > @unbounded = grep(!$_->BOUNDED, @imm);

fulton > print scalar @unbounded;
3
```
The return value is a perl array of polyhedra. The output is intended as a
status report on the computation, so that one can estimate whether it will
finish. It means that after the i-th step we have a list of n polyhedra that
will then be intersected with the complement of the next cone.

Note that there is a final reduction step such that the result may be less than
what was reported for the last step.


## References
[Immaculate line bundles on toric varieties - authors below] (https://arxiv.org/abs/1808.09312)


## Authors
[Klaus Altmann] (http://www.math.fu-berlin.de/altmann/)

[Jarosław Buczyński] (https://www.mimuw.edu.pl/~jabu/)

[Lars Kastner] (http://page.math.tu-berlin.de/~kastner/)

[Anna-Lena Winz] (http://www.mi.fu-berlin.de/math/groups/ag-algebra/members/mitarbeiter/Winz.html)
