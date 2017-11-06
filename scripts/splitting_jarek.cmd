application "fulton";
$rays = new Matrix<Rational>([
    [1, 0, 0],
    [1, 2, 0],
    [0, 0, 1],
    [-2, -2, -1],
    [1, 1, 0],
    [-1, -1, 0]
]);
$c = new Array<Set<Int>>([
    [ 1, 3, 5 ],
    [ 2, 3, 5 ],
    [ 1, 4, 5 ],
    [ 2, 4, 5 ],
    [ 1, 3, 6 ],
    [ 2, 3, 6 ],
    [ 1, 4, 6 ],
    [ 2, 4, 6 ]
]);
# Magma apparently starts counting at 1, so we fix that
@a = map{my $b = $_; (new Set<Int>(map($_-1, @$b)))}@$c;
$f = new PolyhedralFan(INPUT_RAYS=>$rays, INPUT_CONES=>\@a);
$tv = new NormalToricVariety($f);
print $tv->RAYS;
$div = $tv->add("DIVISOR",COEFFICIENTS=>[1,0,1,0,-1,0]);
print $div->IMMACULATE;
