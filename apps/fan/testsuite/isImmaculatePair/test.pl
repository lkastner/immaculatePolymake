my $cube = cube(2);
my $cubeTwo = cube(2,2,0);
my $simplex = simplex(2);
my $simplexTwo = simplex(2,2);
my $simplexThree = simplex(2,3);
my $pt = new Polytope(POINTS=>[[1,0,0]]);
compare_values("(cube,pt)", isImmaculatePair($cube, $pt), True);
compare_values("(cubeTwo,pt)", isImmaculatePair($cubeTwo, $pt), False);
compare_values("(simplex,pt)", isImmaculatePair($simplex, $pt), True);
compare_values("(simplexTwo,pt)", isImmaculatePair($simplexTwo, $pt), True);
compare_values("(simplexThree,pt)", isImmaculatePair($simplexThree, $pt), False);

