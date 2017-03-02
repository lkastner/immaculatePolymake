my $cube = cube(2);
my $cubeTwo = cube(2,2,0);
my $simplex = simplex(2);
my $simplexTwo = simplex(2,2);
my $simplexThree = simplex(2,3);
my $pt = new Polytope(POINTS=>[[1,0,0]]);
compare_values("(cube,pt)", True, isImmaculatePair($cube, $pt));
compare_values("(cubeTwo,pt)", False, isImmaculatePair($cubeTwo, $pt));
compare_values("(simplex,pt)", True, isImmaculatePair($simplex, $pt));
compare_values("(simplexTwo,pt)", True, isImmaculatePair($simplexTwo, $pt));
compare_values("(simplexThree,pt)", False, isImmaculatePair($simplexThree, $pt));

