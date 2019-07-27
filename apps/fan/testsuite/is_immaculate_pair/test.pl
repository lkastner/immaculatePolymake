my $cube = cube(2,1,0);
my $cubeTwo = cube(2,2,0);
my $simplex = simplex(2);
my $simplexTwo = simplex(2,2);
my $simplexThree = simplex(2,3);
my $pt = new Polytope(POINTS=>[[1,0,0]]);
compare_values("(cube,pt)", 1, is_immaculate_pair($cube, $pt));
compare_values("(cubeTwo,pt)", 0, is_immaculate_pair($cubeTwo, $pt));
compare_values("(simplex,pt)", 1, is_immaculate_pair($simplex, $pt));
compare_values("(simplexTwo,pt)", 1, is_immaculate_pair($simplexTwo, $pt));
compare_values("(simplexThree,pt)", 0, is_immaculate_pair($simplexThree, $pt));

my $line = new Polytope(POINTS=>[[1,0,0],[1,0,2]]);
compare_values("(line, simplex)", 0, is_immaculate_pair($line, $simplex));
compare_values("(simplex, line)", 1, is_immaculate_pair($simplex, $line));

my $diagonal = new Polytope(POINTS=>[[1,0,0],[1,1,1]]);
compare_values("(simplex, diagonal)", 0, is_immaculate_pair($simplex, $diagonal));
compare_values("(diagonal, simplex)", 1, is_immaculate_pair($diagonal, $simplex));
