application "fulton";
$tv = kleinschmidt(5,new Vector<Int>([2,3,4]));
@prob = find_temptings($tv);
$A = new Array<Set<Int>>(@prob);
@a = intersection_approach($A, new Matrix<Rational>($tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION));

$c = cube(2,10, -10);
$l = $tv->RATIONAL_DIVISOR_CLASS_GROUP->LIFTING;
$A = $c->LATTICE_POINTS;
$A = $A->minor(All,~[0]);
$d = $tv->DIVISOR(COEFFICIENTS=>$A->[0] * $l);
print $d->IMMACULATE;


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
@pool = map(intersection($_, cube(2,5,-2)), @unbounded);
@pool = map($_->LATTICE_POINTS, @pool);
@pool = (@pool, $A);
$pool = new Set<Vector<Integer>>(map(@$_, @pool));
$candidates = new Matrix(@$pool);


@exceptionals = find_es_from_immaculate($pool, 12);

$dd0 = new Vector<Integer>([1,-1,1]);
print $pool->contains($dd0);
$pool0 = step_pool($pool, $pool, $dd0);
$dd1 = new Vector<Integer>([1,-2,2]);
print $pool0->contains($dd1);
$pool1 = step_pool($pool, $pool0, $dd1);
$dd2 = new Vector<Integer>([1,1,0]);
print $pool1->contains($dd2);
$pool2 = step_pool($pool, $pool1, $dd2);
$dd3 = new Vector<Integer>([1,2,0]);
print $pool2->contains($dd3);
$pool3 = step_pool($pool, $pool2, $dd3);
$dd4 = new Vector<Integer>([1,3,0]);
print $pool3->contains($dd4);
$pool4 = step_pool($pool, $pool3, $dd4);
$dd5 = new Vector<Integer>([1,2,1]);
print $pool4->contains($dd5);
$pool5 = step_pool($pool, $pool4, $dd5);

$pi = $tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION;
$c = cube($pi->rows,0,-1);
$V = $c->VERTICES->minor(All, ~[0]);
$Q = new Polytope(POINTS=>ones_vector | ($V * $pi));

