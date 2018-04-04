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
# But instead we choose:
$pi = new Matrix<Rational>([[1,1,1,1,1,1],[1,0,1,0,1,0],[1,0,0,1,0,0],[0,1,0,0,1,0]]);
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
