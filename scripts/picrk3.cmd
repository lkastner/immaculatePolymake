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

# Fourth example
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


# Fourth example
# Pentagon
$c = zero_vector(1);
$b = new Vector([11]);
$pi = rk3_build_pi(1,1,1,1,1,$c, $b);
print $pi;
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
$lpts = new Matrix(@lpts);
print $lpts;
$canonical = ones_matrix(1,$lpts->rows) * $lpts;
$canonical = (new Rational(2,($lpts->rows)))*$canonical;
print $canonical;

# Fifth example
# Innocent vector
$c = zero_vector(1);
$b = new Vector([11]);
$pi = rk3_build_pi(1,1,1,1,2,$c, $b);
print $pi;
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
$lpts = new Matrix(@lpts);
print $lpts;
$canonical = ones_matrix(1,$lpts->rows) * $lpts;
$canonical = (new Rational(2,($lpts->rows)))*$canonical;
print $canonical;

# Sixth example
# Guilty vector
$c = new Vector([0,9]);
$b = new Vector([9]);
$pi = rk3_build_pi(1,1,2,1,1,$c, $b);
print $pi;
$tempting = rk3_build_temptings(1,1,2,1,1);
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
$lpts = new Matrix(@lpts);
print $lpts;
$canonical = ones_matrix(1,$lpts->rows) * $lpts;
$canonical = (new Rational(2,($lpts->rows)))*$canonical;
print $canonical;

# Sixth example
# Two Guilty vectors
$c = new Vector([0,9]);
$b = new Vector([1,9]);
$pi = rk3_build_pi(1,1,2,2,1,$c, $b);
print $pi;
$tempting = rk3_build_temptings(1,1,2,2,1);
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
   print "Dim: ", $line->DIM,"\n";
   print "LinDim: ", $line->LINEALITY_DIM,"\n";
   print "Gens:\n",$line->LATTICE_POINTS_GENERATORS;
   print "Direction:\n", $line->LINEALITY_SPACE;
   print "------------------------------------------------\n";
}
$lpts = new Matrix(@lpts);
print $lpts;
$canonical = ones_matrix(1,$lpts->rows) * $lpts;
$canonical = (new Rational(2,($lpts->rows)))*$canonical;
print $canonical;

# Input
application "fan";
$p0=1;
$p1=1;
$c = new Vector([0]);
$b = new Vector([11]);
$p4 = 1;
rk3_everything($p0,$p1, $c, $b, $p4);



# ab hier nichts aendern. 
$p2 = $c->dim;
$p3 = $b->dim;
$pi = rk3_build_pi($p0,$p1,$p2,$p3,$p4,$c, $b);
$tempting = rk3_build_temptings($p0,$p1,$p2,$p3,$p4);
@a = intersection_approach($tempting, transpose(new Matrix<Rational>($pi)));
@bounded = grep($_->BOUNDED, @a);
@lines = grep(!$_->BOUNDED, @a);
@test = group_lines(@lines);
@lpts = map($_->LATTICE_POINTS, @bounded);
@lpts = map(@$_, @lpts);
$tmp = new Set<Vector<Integer>>(@lpts);
print $tmp->size;
@lpts = @$tmp;
foreach my $line (@lines){
   @lpts = grep(!$line->contains($_), @lpts);
   print "Dim: ", $line->DIM,"\n";
   print "LinDim: ", $line->LINEALITY_DIM,"\n";
   print "Gens:\n",$line->LATTICE_POINTS_GENERATORS->[0];
   print "Direction:\n", $line->LINEALITY_SPACE;
   print "------------------------------------------------\n";
}
$lpts = new Matrix(@lpts);
print $lpts;
$canonical = ones_matrix(1,$lpts->rows) * $lpts;
$canonical = (new Rational(2,($lpts->rows)))*$canonical;
print "Canonical:", $canonical, "\n";

@zlines = grep($_->LINEALITY_SPACE==$lines[1]->LINEALITY_SPACE, @lines);
$pts = $zlines[1]->LATTICE_POINTS_GENERATORS->[0];
$pts = $pts / $zlines[2]->LATTICE_POINTS_GENERATORS->[0];
$pts = $pts / $zlines[3]->LATTICE_POINTS_GENERATORS->[0];
$pts = $pts / $zlines[0]->LATTICE_POINTS_GENERATORS->[0];
$p = new Polytope(POINTS=>$pts);
print $p->VERTICES;
print $p->N_LATTICE_POINTS;
print $p->LATTICE_POINTS;
#all the lattice points are in some of the lattice points generators.



# The following code is to calculate the cones sigma_R.
# First given by rays, and as it seems to be more convenient 
# for the proof later, then by inequalities.
$b = 11;
$Remp = new Matrix([0,-1,0],[1,1,-$b],[0,1,1]);
$R0 = new Matrix([0,0,1],[-1,0,0],[0,-1,-1]);
$R1 = new Matrix([0,0,-1],[1,0,0],[-1,-1,$b]);
$R2 = new Matrix([0,1,0],[1,0,0],[0,-1,-1]);
$R3 = new Matrix([0,0,-1],[-1,0,0],[1,1,-$b],[0,1,1]);
$R4 = new Matrix([0,0,1],[0,1,0],[-1,0,0],[-1,-1,$b]);


$b = 11;
$Remp = new Matrix([0,0,1],[0,-1,0],[1,0,0],[1,1,-$b],[0,1,1]);
$R0 = new Matrix([0,0,1],[0,-1,0],[-1,0,0],[-1,-1,$b],[0,-1,-1]);
$R1 = new Matrix([0,0,-1],[0,-1,0],[1,0,0],[-1,-1,$b],[0,-1,-1]);
$R2 = new Matrix([0,0,-1],[0,1,0],[1,0,0],[1,1,-$b],[0,-1,-1]);
$R3 = new Matrix([0,0,-1],[0,1,0],[-1,0,0],[1,1,-$b],[0,1,1]);
$R4 = new Matrix([0,0,1],[0,1,0],[-1,0,0],[-1,-1,$b],[0,1,1]);

$Cemp = new Cone(INPUT_RAYS=>$Remp);
$C0 = new Cone(INPUT_RAYS=>$R0);
$C1 = new Cone(INPUT_RAYS=>$R1);
$C2 = new Cone(INPUT_RAYS=>$R2);
$C3 = new Cone(INPUT_RAYS=>$R3);
$C4 = new Cone(INPUT_RAYS=>$R4);

print $Cemp->RAYS;
print $C0->RAYS;
print $C1->RAYS;
print $C2->RAYS;
print $C3->RAYS;
print $C4->RAYS;

print $Cemp->FACETS;
print $C0->FACETS;
print $C1->FACETS;
print $C2->FACETS;
print $C3->FACETS;
print $C4->FACETS;



# code to check the automatization of building the cones.

application "fan";
$p0=1;
$p1=1;
$c = new Vector([0,0]);
$b = new Vector([1,11]);
$p4 = 1;
$R = new Set<Int>(0,1);
$R2 = new Set<Int>();
print rk3_build_rays_for_tempting($p0,$p1, $c, $b, $p4, $R);
print rk3_build_rays_for_tempting($p0,$p1, $c, $b, $p4, $R2);
