$p0=100;
$p1=1;
$c = zero_vector(1);
$b = new Vector([109]);
$p4 = 1;
$p2 = $c->dim;
$p3 = $b->dim;
$pi = rk3_build_pi($p0,$p1,$p2,$p3,$p4,$c, $b);
$tempting = rk3_build_temptings($p0,$p1,$p2,$p3,$p4);
@a = intersection_approach($tempting, transpose(new Matrix<Rational>($pi)));
@bounded = grep($_->BOUNDED, @a);
@lpts = map($_->LATTICE_POINTS, @bounded);
@lpts = map(@$_, @lpts);
$tmp = new Set<Vector<Integer>>(@lpts);
print $tmp->size;
@lpts = @$tmp;
foreach my $line (@lines){
   @lpts = grep(!$line->contains($_), @lpts);
}
$lpts = new Matrix(@lpts);
print $lpts->rows;

$A1 = $lpts;
# Make some more...
#
$S1 = new Set<Vector<Integer>>(@$A1);
$S2 = new Set<Vector<Integer>>(@$A2);
$S3 = new Set<Vector<Integer>>(@$A3);
$S12 = $S1 * $S2;
$S13 = $S1 * $S3;
$S23 = $S2 * $S3;
print $S12 == $S23;
print $S12 == $S13;
