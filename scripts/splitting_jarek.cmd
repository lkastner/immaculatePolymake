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

fulton > print $div->IMMACULATE;
polymake: used package ppl
  The Parma Polyhedra Library (PPL): A C++ library for convex polyhedra
  and other numerical abstractions.
  http://www.cs.unipr.it/ppl/

polymake: used package 4ti2
  4ti2 -- A software package for algebraic, geometric and combinatorial problems on linear spaces.
  Copyright by 4ti2 team.
  http://www.4ti2.de/

1

fulton > @a = find_temptings($f);

fulton > print scalar @a;
8
fulton > $pi = transpose($tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION);

fulton > print $pi;
1 0 -1 1 0 1
0 -1 0 0 -1 2
0 0 -1 0 0 -1

fulton > $pi = $tv->RATIONAL_DIVISOR_CLASS_GROUP->PROJECTION;

fulton > print $pi;
1 0 0
0 -1 0
-1 0 -1
1 0 0
0 -1 0
1 2 -1

fulton > $tempt = new Array<Set<Int>>(@a);
fulton > @pp = intersection_approach($tempt, new Matrix<Rational>($pi));

fulton > $pv = transpose($pi) * $div->COEFFICIENTS;

fulton > print $pv;
0 1 -1
fulton > $ppv = new Vector((1,@$pv));

fulton > print $ppv;
1 0 1 -1
fulton > foreach my $p (@pp){
fulton (2)> print "Cont: ", $p->contains($ppv),"\n";
fulton (3)> }
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0
Cont: 0

fulton > print transpose($pi) * primitive($tv->RAYS);
0 0 0
0 0 0
0 0 0

fulton > 
