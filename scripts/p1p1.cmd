application "fan";
$f = new PolyhedralFan(INPUT_RAYS=>[[1,0],[0,1],[-1,0],[0,-1]], INPUT_CONES=>[[0,1],[1,2],[2,3],[0,3]]);
@prob = find_temptings($f);
$A = new Array<Set<Int> >(@prob);
$mat = null_space(transpose($f->RAYS));
@a = intersection_approach($A, new Matrix<Rational>(transpose($mat)));



application "fan";
$f = new PolyhedralFan(INPUT_RAYS=>[[-1, -1, 0], [1, 0, 0], [0, 1, 0], [0, 0, 1], [0, 1, -1]],INPUT_CONES=>[[0, 1, 3], [0, 1, 4], [0, 2, 3], [0, 2, 4], [1, 2, 3], [1, 2, 4]]);
@prob = find_temptings($f);
$mat = null_space(transpose($f->RAYS));
$mat = new Matrix<Rational>(transpose($mat));
$A = new Array<Set<Int> >(@prob);
@a = intersection_approach($A, $mat);
@cones = map(build_cone_from_index_set($_, $mat), @prob);
@cones = map((new Polytope(POINTS=>$_)), @cones);


