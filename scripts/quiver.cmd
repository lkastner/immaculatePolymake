application "fan";
$A = new Vector([1,-1,0]);
$B = new Vector([1,0,-1]);
$C = new Vector([0,1,-1]);
$D = new Vector([0,1, 0]);
$E = new Vector([0,0, 1]);

$M = new Matrix([
[1,-1,0],
[1,0,-1],
[0,1,-1],
[0,1, 0],
[0,0, 1]]
);

sub make_cone{
   my ($index, $M) = @_;
   my $negative = - $M->minor($index, All);
   my $positive = $M->minor(~$index, All);
   my $root = transpose($negative) * ones_vector($negative->rows);
   my $gens = new Matrix(zero_vector | $negative);
   $gens /= zero_vector | $positive;
   $gens /= ones_vector(1) | $root;
   return $gens;
}

sub build_cone_pair {
   my ($index, $M) = @_;
   my $entire = new Set<Int>(0..($M->rows - 1));
   my $comp = $entire - $index;
   my $A = make_cone($index, $M);
   my $B = make_cone($comp, $M);
   return($A, $B);
}

$entire = new Set<Int>(0,1,2,3,4);
$AB = new Set<Int>(0,1);
$AE = new Set<Int>(0,4);
$BC = new Set<Int>(1,2);
$CD = new Set<Int>(2,3);
$DE = new Set<Int>(3,4);

@a = ($entire, $AB, $AE, $BC, $CD, $DE);

@a = map{
   my $p = $_;
   my($A, $B) = build_cone_pair($p, $M);
   (new Polytope(POINTS=>$A), new Polytope(POINTS=>$B))
} @a;

$n = 5;
$cube = cube(3, $n, -$n);
$lattice = new Matrix<Rational>($cube->LATTICE_POINTS);
@good = grep{
   my $p = $_;
   my @c = grep($_->contains($p), @a);
   (scalar @c) == 0
} @$lattice;

print new Matrix(@good);
@good = map((new Vector([$_->[1], $_->[2], $_->[3], -$_->[1]-$_->[2]-$_->[3]])), @good);
print new Matrix(@good);

$check = new Polytope(POINTS=>[[1,-1,0,0],[0,0,1,0],[0,0,-1,0]]);
$check1 = new Polytope(POINTS=>[[1,-1,0,1],[0,0,1,0],[0,0,-1,0]]);
$check2 = new Polytope(POINTS=>[[1,0,-1,0],[0,1,0,-1],[0,-1,0,1]]);
$check3 = new Polytope(POINTS=>[[1,0,0,-1],[0,1,0,-1],[0,-1,0,1]]);
foreach my $cone (@a){
   my $int = intersection($check3, $cone);
   print "Check:",$int->FEASIBLE,"\n";
}

# contains seems to fail for lines
@non_line_pts = grep{
   !($check->contains($_) || $check1->contains($_) || $check2->contains($_) || $check3->contains($_))
} @good;


# New Polymake stuff.
application "fan";
$A = new Array<Set<Int> >([[0,1,2,3,4],[0,1],[0,4],[1,2],[2,3],[3,4]]);
$M = new Matrix([
[1,-1,0],
[1,0,-1],
[0,1,-1],
[0,1, 0],
[0,0, 1]]
);
@a = intersection_approach($A, $M);

