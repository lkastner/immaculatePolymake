application "fan";
$hexagon = new Polytope(POINTS=>[[1,0,0],[1,1,0],[1,2,1],[1,2,2],[1,1,2],[1,0,1]]);
$fan = normal_fan($hexagon);
$rho_star = $fan->RAYS;
# This fan has a "weird" ordering of rays:
print $rho_star;
# I will make the same fan, but with a different order of rays.
$rho_star = new Matrix<Rational>([[1,0],[0,1],[-1,1],[-1,0],[0,-1],[1,-1]]);
$fan = new PolyhedralFan(RAYS=>$rho_star, MAXIMAL_CONES=>[[0,1],[1,2],[2,3],[3,4],[4,5],[0,5]]);
@prob = find_temptings($fan);
# There are 34 problematic subsets.
print @prob;
# Computing the cokernerl we get:
$pi = null_space(transpose($rho_star));
# $pi = new Matrix<Rational>([[1,1,1,1,1,1],[1,0,1,0,1,0],[1,0,0,1,0,0],[0,1,0,0,1,0]]);
# But instead we choose from the primitive collections 03 14 25 and 02:
$pi = new Matrix<Rational>([[1,0,0,1,0,0],[0,1,0,0,1,0],[0,0,1,0,0,1],[1,-1,1,0,0,0]]);
print $pi;
$A = new Array<Set<Int>>(@prob);
@a = immaculate_locus_via_intersection($A, new Matrix<Rational>(transpose($pi)));
@bounded = grep($_->BOUNDED, @a);
@unbounded = grep(!$_->BOUNDED, @a);
@lp = map($_->LATTICE_POINTS, @bounded);
@lp = map(@$_, @lp);
$lp_set = new Set<Vector<Integer>>(@lp);
@lp = @$lp_set;
@lp = grep(!$unbounded[0]->contains($_), @lp);
@lp = grep(!$unbounded[1]->contains($_), @lp);
@lp = grep(!$unbounded[2]->contains($_), @lp);
$A = new Matrix(@lp);
print join("\\\\\n", map(join(" & ", @$_), @$A));

$C = $unbounded[0]->VERTICES;
print $C;
$C = $C->minor(All, ~[0]);
print "\\left(\\begin{array}{cccc}".join("\\end{array}\\right)\n\\left(\\begin{array}{cccc}", map(join(" & ", @$_), @$C))."\\end{array}\\right)\n";

$i01 = intersection($unbounded[0], $unbounded[1]);
$i02 = intersection($unbounded[0], $unbounded[2]);
$i21 = intersection($unbounded[2], $unbounded[1]);
print $i01->BOUNDED;
print $i02->BOUNDED;
print $i21->BOUNDED;
print $i01->LATTICE_POINTS;
print $i02->LATTICE_POINTS;
print $i21->LATTICE_POINTS;


# Try to build a exceptional sequence.
@pool = map(intersection($_, cube(4,7,-7)), @unbounded);
@pool = map($_->LATTICE_POINTS, @pool);
@pool = (@pool, $A);
$pool = new Set<Vector<Integer>>(map(@$_, @pool));
$candidates = new Matrix(@$pool);

@exceptionals = find_es_from_immaculate($pool, 6);


application "fulton";
$Q = new RationalDivisorClassGroup(PROJECTION=>transpose($pi));
$tv = new NormalToricVariety(RAYS=>$rho_star, MAXIMAL_CONES=>$fan->MAXIMAL_CONES, RATIONAL_DIVISOR_CLASS_GROUP=>$Q);
print $tv->NEF_CONE->RAYS;

# Group action
# Since we are living in two dimensions, this should be ok.
$pts = $fan->RAYS;
# Take the linear symmetries that act on the vertices of the hexagon. Since we
# are in two dimensions, this is also the group we are looking for.
$gp = linear_symmetries(new Matrix<Rational>($pts));
$gens = $gp->PERMUTATION_ACTION->GENERATORS;
print $gens;
# Get all elements
$all = $gp->PERMUTATION_ACTION->ALL_GROUP_ELEMENTS;
print $all;
# Check whether the group elements preserve the kernel of pi
print $pi * permutation_matrix($_) * $fan->RAYS foreach @$all;
$section = new Matrix([[0,0,0,1,0,0],[0,0,0,0,1,0],[0,0,0,0,0,1],[1,0,0,-1,0,0]]);
$section = transpose($section);
# Check whether this really is a section of pi
print $pi * $section;
# Action on Cl(X) is given by acting on a random preimage under pi, then
# applying pi. More directly, this can be phrased as:
@cl_gp = map($pi * permutation_matrix($_) * $section, @$all);

# Compute orbit of the exceptionals:
# Cut off homogenizing first entry
@a = map(new Matrix($_->minor(All, ~[0])), @exceptionals);
# Calculate orbit of first exc sequence
$b = new Set<Matrix<Integer>>(map($_ * transpose($a[0]), @cl_gp));
print $b->size;
# Size is 12, just like the number of exc sequences
$i = 0;
foreach my $exc (@a){
   print $i,": ",$b->contains(transpose($exc)),"\n";
   $i++;
}
# Returns true for all.

# Checking with the cube:
$c = cube(6,0,-1);
$V = $c->VERTICES->minor(All, ~[0]);
$Q = new Polytope(POINTS=>ones_vector | ($V * transpose($pi)));

$cc = cube(6,5,-5);
$VV = $cc->VERTICES->minor(All, ~[0]);
$QQ = new Polytope(POINTS=>ones_vector | ($VV * transpose($pi)));
@pool = map(intersection($_, $QQ), @unbounded);
@pool = map($_->LATTICE_POINTS, @pool);
@pool = (@pool, $A);
$pool = new Set<Vector<Integer>>(map(@$_, @pool));

@exceptionals = find_es_from_immaculate($pool, 6);
print scalar @exceptionals;
@good_exc = ();
$i = 0;
foreach my $exc (@exceptionals){
   my $check = true;
   foreach my $v (@$exc){
      $check &= $Q->contains(new Vector<Rational>($v));
      if(!$check){last;}
   }
   print $i,": ",$check,"\n";
   if($check){
      foreach my $v (@$exc){
         print $v,": ",$Q->contains(new Vector<Rational>($v)),"\n";
      }
      print "\n";
      push @good_exc, $exc;
   }
   $i++;
}
print scalar @good_exc;
