application "fan";
# Matrix ZZ^Q1 ->> ZZ^Q0
$incidenceMatrix = new Matrix<Integer>([[-1,-1,-1,0,0,0],[1,0,0,1,0,0],[0,1,0,0,1,0],[0,0,1,0,0,1],[0,0,0,-1,-1,-1]]);
# kernel gens
$iota = null_space($incidenceMatrix);
$fanRays = transpose($iota);
$Q = smith_normal_form(new Matrix<Integer>($fanRays));
$fanRays = $fanRays * inv($Q->[2]);
# Canonical weight:
$cw = $incidenceMatrix * ones_vector<Integer>($incidenceMatrix->cols);
# section
$section = dense(inv($Q->[1]))->minor([0..$fanRays->cols-1],All);
# Flow polytope
$eq = -$cw | $incidenceMatrix;
$ineq = unit_matrix($eq->cols);
$P = new Polytope(INEQUALITIES=>$ineq, EQUATIONS=>$eq);
print $P->DIM;
print $P->VERTICES;
# project $P
$vert = $P->VERTICES;
$vert = $vert->minor(All, ~[0]);
$vert = $section * transpose($vert);
$vert = ones_vector | (transpose($vert));
$sP = new Polytope(POINTS=>$vert);
# Getting the problematics
$fan = normal_fan($sP);
@prob = find_maculates($fan);
# The rays in $fan don't have the same ordering, the following takes care of
# that. The ordering will then be the same as in $fanRays.
%rayHash = ();
for(my $i=0; $i<$fanRays->rows; $i++){
   for(my $j=0; $j<$fan->RAYS->rows; $j++){
      if($fanRays->[$i] == $fan->RAYS->[$j]){
         $rayHash{$j} = $i;
      }
   }
}
@prob = map{
   my $s = $_;
   my @s = map($rayHash{$_}, @$s);
   new Set<Int>(@s)
} @prob;
# Finding immaculate locus:
# Remove {} for now..
$A = new Array<Set<Int>>(@prob);
$mat = transpose($incidenceMatrix)->minor(All, ~[$incidenceMatrix->rows-1]);
@a = intersection_approach($A, new Matrix<Rational>($mat));

# Add one vertex in the middle
application "fan";
$M = -ones_vector(4) | zero_vector(4);
$M = $M / (unit_matrix(4) | unit_matrix(4));
$M = dense($M);
$M = $M / (zero_vector(4) | -ones_vector(4));
$incidenceMatrix = new Matrix<Integer>($M);

# Checking something
$mat = new Matrix<Rational>($mat);
@cones = map(build_cone_from_index_set($_, $mat), @prob);
@cones = map((new Polytope(POINTS=>$_)), @cones);
