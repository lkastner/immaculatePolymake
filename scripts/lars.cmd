application "fan";
$pc1 = new PolyhedralComplex(VERTICES=>[[1,0,0],[1,1,0],[1,1,1],[1,0,1]],MAXIMAL_POLYTOPES=>[[0,1,2,3]]);
$pc = new PolyhedralComplex(VERTICES=>[[1,0,0],[1,1,0],[1,1,1],[1,0,1]],MAXIMAL_POLYTOPES=>[[0,1],[1,2],[2,3],[3,0]]);
print $pc->HOMOLOGY;
print $pc->CONTRACTIBLE;
