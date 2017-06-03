application "fan";

# First example
$c = zero_vector(1);
$pi = rk3_build_pi(1,1,1,1,1,$c, $c);
$tempting = rk3_build_temptings(1,1,1,1,1);
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
$pi = rk3_build_pi(1,1,1,1,1,$c, $b);
$tempting = rk3_build_temptings(1,1,1,1,1);
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

