application "fulton";
$tv = kleinschmidt(5,new Vector<Int>([2,3,4]));
@prob = find_temptings($tv);
$A = new Array<Set<Int>>(@prob);
@a = intersection_approach($A, new Matrix<Rational>($tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION));


@bounded = grep($_->BOUNDED, @a);
@unbounded = grep(!$_->BOUNDED, @a);

print scalar @unbounded;
print $unbounded[0]->LATTICE_POINTS_GENERATORS;

@lp = map($_->LATTICE_POINTS, @bounded);
@lp = map(@$_, @lp);
$lp = new Set<Vector<Integer>>(@lp);
@lp = grep(!$unbounded[0]->contains($_), @$lp);
$A = new Matrix(@lp);
print $A;

# Try to build a exceptional sequence.
@pool = map(intersection($_, cube(2,100,-100)), @unbounded);
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

sub print_es_table_row{
   my($es_in) = @_;
   my $es = $es_in->minor(~[0], ~[0]);
   my $out = join("  &  ",map(join(" & ",@$_), @$es))."\\\\\n";
   print $out;
}

sub recursive_es{
   my($pool, $selected, $desired_length) = @_;
   if($pool->size == 0){
      if($selected->rows >= $desired_length){
         # print $selected,": ",$selected->rows,"\n";
         print_es_table_row($selected);
         return $selected;
      } else {
         return ();
      }
   } else {
      my @result = ();
      foreach my $candidate (@$pool){
         my $new_pool = step_pool($pool, $candidate);
         push @result, recursive_es($new_pool, new Matrix<Integer>($selected / $candidate), $desired_length);
      }
      return @result;
   }
}

$selected = new Matrix<Integer>([[1,0,0]]);
@exceptionals = recursive_es($pool, $selected, 6);

$dd0 = new Vector<Integer>([1,-1,1]);
print $pool->contains($dd0);
$pool0 = step_pool($pool, $dd0);
$dd1 = new Vector<Integer>([1,-2,2]);
print $pool0->contains($dd1);
$pool1 = step_pool($pool0, $dd1);
$dd2 = new Vector<Integer>([1,1,0]);
print $pool1->contains($dd2);
$pool2 = step_pool($pool1, $dd2);
$dd3 = new Vector<Integer>([1,2,0]);
print $pool2->contains($dd3);
$pool3 = step_pool($pool2, $dd3);
$dd4 = new Vector<Integer>([1,3,0]);
print $pool3->contains($dd4);
$pool4 = step_pool($pool3, $dd4);
$dd5 = new Vector<Integer>([1,2,1]);
print $pool4->contains($dd5);
$pool5 = step_pool($pool4, $dd5);


