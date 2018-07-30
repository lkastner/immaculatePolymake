$p0=1;
$p1=1;
$c = zero_vector(1);
$b = zero_vector(2);
$p4 = 1;
$p2 = $c->dim;
$p3 = $b->dim;
# canonical for b and c = 0
$K00 = new Vector([-$p2-$p3, $p1-$p3-$p4, -$p0-$p4]);
$pi = rk3_build_pi($p0,$p1,$p2,$p3,$p4,$c, $b);
$tempting = rk3_build_temptings($p0,$p1,$p2,$p3,$p4);
@a = intersection_approach($tempting, transpose(new Matrix<Rational>($pi)));
@bounded = grep($_->BOUNDED, @a);
@lpts = map($_->LATTICE_POINTS, @bounded);
@lpts = map(@$_, @lpts);
$tmp = new Set<Vector<Integer>>(@lpts);
print $tmp->size;
@lpts = @$tmp;
@lines = grep(!$_->BOUNDED, @a);
foreach my $line (@lines){
   @lpts = grep(!$line->contains($_), @lpts);
}
$lpts = new Matrix(@lpts);
print $lpts->rows;
print $lpts;








$p0=5;
$p1=4;
$c = new Vector([0,1,50]);
$b = new Vector([10,100]);
$p4 = 5;
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
@lines = grep(!$_->BOUNDED, @a);
foreach my $line (@lines){
   $P = new Polytope(POINTS=>$line->VERTICES);
   tikz($P->VISUAL,File=>"-");
}
foreach my $line (@lines){
   @lpts = grep(!$line->contains($_), @lpts);
}
$lpts = new Matrix(@lpts);
print $lpts->rows;
print $lpts;
$A1 = $lpts;
$A2 = $lpts;
$S1 = new Set<Vector<Integer>>(@$A1);
$S2 = new Set<Vector<Integer>>(@$A2);
$S12 = $S1 * $S2;
print new Matrix($S12);
$A3 = $lpts;
$S3 = new Set<Vector<Integer>>(@$A3);
$S13 = $S1 * $S3;
$S23 = $S2 * $S3;
print $S12 == $S23;
print $S12 == $S13;
print new Matrix($S13);
print new Matrix($S13)->rows;
$A5 = $lpts;
$S5 = new Set<Vector<Integer>>(@$A5);
$S35 = $S3 * $S5;
print new Matrix($S35);
print new Matrix($S35)->rows;


