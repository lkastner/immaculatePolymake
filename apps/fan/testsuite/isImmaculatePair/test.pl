my $cube = cube(2,1,0);
my $cubeTwo = cube(2,2,0);
my $simplex = simplex(2);
my $simplexTwo = simplex(2,2);
my $simplexThree = simplex(2,3);
my $pt = new Polytope(POINTS=>[[1,0,0]]);
compare_values("(cube,pt)", 1, isImmaculatePair($cube, $pt));
compare_values("(cubeTwo,pt)", 0, isImmaculatePair($cubeTwo, $pt));
compare_values("(simplex,pt)", 1, isImmaculatePair($simplex, $pt));
compare_values("(simplexTwo,pt)", 1, isImmaculatePair($simplexTwo, $pt));
compare_values("(simplexThree,pt)", 0, isImmaculatePair($simplexThree, $pt));

