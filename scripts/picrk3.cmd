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

# Third example
# p_i=1, p_4=2
$c = zero_vector(1);
$pi = rk3_build_pi(1,1,1,1,2,$c, $c);
$tempting = rk3_build_temptings(1,1,1,1,2);
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
$s1 = new Polytope(POINTS=>[[1,-1,-2,-2]]);
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
@pts = map($_->LATTICE_POINTS, @a2);
@pts = map(@$_, @pts);
$pts = new Set<Vector<Integer>>(@pts);
print $pts->size;

$s3 = new Polytope(POINTS=>[[1,-1,-2,-3]]);
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
@pts = map($_->LATTICE_POINTS, @a3);
@pts = map(@$_, @pts);
$pts = new Set<Vector<Integer>>(@pts);
print $pts->size;

$s4 = new Polytope(POINTS=>[[1,-1,-2,-4]]);
@b4 = map(minkowski_sum($s4, $_), @a);
@a4 = ();
foreach my $p (@a3){
   foreach my $q (@b4){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a4, $i;
      }
   }
}
@pts = map($_->LATTICE_POINTS, @a4);
@pts = map(@$_, @pts);
$pts = new Set<Vector<Integer>>(@pts);
print $pts->size;

$s5 = new Polytope(POINTS=>[[1,-2,-2,-1]]);
@b5 = map(minkowski_sum($s5, $_), @a);
@a5 = ();
foreach my $p (@a4){
   foreach my $q (@b5){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a5, $i;
      }
   }
}
@pts = map($_->LATTICE_POINTS, @a5);
@pts = map(@$_, @pts);
$pts = new Set<Vector<Integer>>(@pts);
print $pts->size;

$s6 = new Polytope(POINTS=>[[1,-2,-2,-2]]);
@b6 = map(minkowski_sum($s6, $_), @a);
@a6 = ();
foreach my $p (@a5){
   foreach my $q (@b6){
      my $i = intersection($p, $q);
      if($i->FEASIBLE){
         push @a6, $i;
      }
   }
}
@pts = map($_->LATTICE_POINTS, @a6);
@pts = map(@$_, @pts);
$pts = new Set<Vector<Integer>>(@pts);
print $pts->size;
