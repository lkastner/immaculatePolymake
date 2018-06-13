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
@a = intersection_approach($A, new Matrix<Rational>(transpose($pi)));
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

sub step_pool{
   my($old_pool, $d) = @_;
   my $c = new Vector<Integer>($d);
   $c->[0] = 0;
   my $translated_pool = new Set<Vector<Integer>>(map($_ + $c, @$old_pool));
   my $new_pool = $old_pool * $translated_pool;
   return $new_pool;
}

@imm = (@unbounded, map(new Polytope(POINTS=>[$_]), @lp));
$d0 = new Vector([0,0,0,0]);
foreach my $candidate (@$candidates){
   my $new_pool = step_pool($pool, $candidate);
   print $candidate," : ",$new_pool->size,"\n";
}
$d1 = new Vector([1,-1,0,0,0]);
$old_pool = step_pool($pool, $d1);
foreach my $candidate (@$old_pool){
   my $new_pool = step_pool($old_pool, $candidate);
   print $candidate," : ",$new_pool->size,"\n";
}
$d2 = new Vector<Integer>([1,-1,-1,0,0]);
$old_pool = step_pool($pool, $d2);
foreach my $candidate (@$old_pool){
   my $new_pool = step_pool($old_pool, $candidate);
   print $candidate," : ",$new_pool->size,"\n";
}

sub print_es_table_row{
   my($es_in) = @_;
   my $es = $es_in->minor(~[0], ~[0]);
   my $out = join("  &  ",map(join(" & ",@$_), @$es))."\\\\\n";
   print $out;
}

sub recursive_es{
   my($pool, $selected) = @_;
   if($pool->size == 0){
      if($selected->rows >= 6){
         # print $selected,": ",$selected->rows,"\n";
         print_es_table_row($selected);
      }
      return;
   }
   foreach my $candidate (@$pool){
      my $new_pool = step_pool($pool, $candidate);
      recursive_es($new_pool, new Matrix<Integer>($selected / $candidate));
   }
}


application "fulton";
$Q = new RationalDivisorClassGroup(PROJECTION=>transpose($pi));
$tv = new NormalToricVariety(RAYS=>$rho_star, MAXIMAL_CONES=>$fan->MAXIMAL_CONES, RATIONAL_DIVISOR_CLASS_GROUP=>$Q);
print $tv->NEF_CONE->RAYS;

# Group action
# Since we are living in two dimensions, this should be ok.
$pts = $fan->RAYS;
$gp = linear_symmetries(new Matrix<Rational>($pts));
$gens = $gp->PERMUTATION_ACTION->GENERATORS;
print $gens;
$all = $gp->PERMUTATION_ACTION->ALL_GROUP_ELEMENTS;
print $all;
print $pi * permutation_matrix($_) * $fan->RAYS foreach @$all;
$section = new Matrix([[0,0,0,1,0,0],[0,0,0,0,1,0],[0,0,0,0,0,1],[1,0,0,-1,0,0]]);
$section = transpose($section);
print $pi * $section;

