sub build_pi {
   my($p0, $p1, $p2, $p3, $p4, $c, $b) = @_;
   my $result = (zero_matrix<Rational>(2, $p0)) / (ones_vector<Rational>($p0));
   $result = $result | (((zero_matrix<Rational>(1,$p1)) / -(ones_vector<Rational>($p1))) / zero_vector<Rational>($p1));
   $result = $result | (((ones_matrix<Rational>(1,$p2)) / zero_vector<Rational>($p2)) / -$c);
   $result = $result | ((ones_matrix<Rational>(2,$p3)) / -$b);
   $result = $result | ((zero_matrix<Rational>(1,$p4)) / ones_matrix<Rational>(2, $p4));
   return $result;
}

sub build_tempting_inner{
   my($X0, $X1, $total) = @_;
   my @result = ($X0+$X1, $total-($X0+$X1));
   return @result;
}

sub build_temptings {
   my($p0, $p1, $p2, $p3, $p4) = @_;
   my $X0 = new Set<Int>(0..$p0-1);
   my $start = $p0;
   my $X1 = new Set<Int>($start..($start+$p1-1));
   $start += $p1;
   my $X2 = new Set<Int>($start..($start+$p2-1));
   $start += $p2;
   my $X3 = new Set<Int>($start..($start+$p3-1));
   $start += $p3;
   my $X4 = new Set<Int>($start..($start+$p4-1));
   $start += $p4;
   my $total = new Set<Int>(0..($start-1));
   my @result = build_tempting_inner($X0, $X1, $total);
   @result = (@result, build_tempting_inner($X2, $X1, $total));
   @result = (@result, build_tempting_inner($X2, $X3, $total));
   @result = (@result, build_tempting_inner($X4, $X3, $total));
   @result = (@result, build_tempting_inner($X4, $X0, $total));
   push @result, $total;
   push @result, new Set<Int>();
   return new Array<Set<Int>>(@result);
}

# First example
$c = zero_vector(1);
$pi = build_pi(1,1,1,1,1,$c, $c);
$tempting = build_temptings(1,1,1,1,1);
@a = intersection_approach($tempting, transpose(new Matrix<Rational>($pi)));
$s1 = new Polytope(POINTS=>[[1,-1,-1,-1]]);
@b1 = map(minkowski_sum($s1, $_), @a);
@a1 = ();
foreach my $p (@a){
   foreach my $q (@b1){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a1, $i;
      }
   }
}

$s2 = new Polytope(POINTS=>[[1,-1,-1,-2]]);
@b2 = map(minkowski_sum($s2, $_), @a);
@a2 = ();
foreach my $p (@a1){
   foreach my $q (@b2){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a2, $i;
      }
   }
}

$s3 = new Polytope(POINTS=>[[1,-2,-1,-1]]);
@b3 = map(minkowski_sum($s3, $_), @a);
@a3 = ();
foreach my $p (@a2){
   foreach my $q (@b3){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a3, $i;
      }
   }
}


# Second example
$b = new Vector<Rational>([20]);
$pi = build_pi(1,1,1,1,1,$c, $b);
$tempting = build_temptings(1,1,1,1,1);
@a = intersection_approach($tempting, transpose(new Matrix<Rational>($pi)));
foreach my $a (@a){
   print "Dim: ", $a->DIM,"\n";
   print "LinDim: ", $a->LINEALITY_DIM,"\n";
   print "Vert:\n",$a->VERTICES;
   print "Lineality:\n", $a->LINEALITY_SPACE;
   print "------------------------------------------------\n";
}
@bounded = grep($_->BOUNDED, @a);
@lines = grep(!$_->BOUNDED, @a);
@lpts = map($_->LATTICE_POINTS, @bounded);
@lpts = map(@$_, @lpts);
$tmp = new Set<Vector<Integer>>(@lpts);
print $tmp->size;
@lpts = @$tmp;
foreach my $line (@lines){
   @lpts = grep(!$line->contains($_), @lpts);
}
print new Matrix(@lpts);

