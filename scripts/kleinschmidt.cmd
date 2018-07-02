application "fulton";
$tv = kleinschmidt(5,new Vector<Int>([2,3,4]));
@prob = find_temptings($tv);
$A = new Array<Set<Int>>(@prob);
@a = intersection_approach($A, new Matrix<Rational>($tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION));


@bounded = grep($_->BOUNDED, @a);
@unbounded = grep(!$_->BOUNDED, @a);

print scalar @unbounded;
print $unbounded[0]->LATTICE_POINTS_GENERATORS;


