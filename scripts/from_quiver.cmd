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
# Finding immaculate locus:
# Remove {} for now..
$A = new Array<Set<Int>>(@prob);
$mat = transpose($incidenceMatrix)->minor(All, ~[$incidenceMatrix->rows-1]);
@a = intersection_approach($A, new Matrix<Rational>($mat));
