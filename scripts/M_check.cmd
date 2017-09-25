application "fan";
$sP = cube(3);
# You can also construct a fan differently
$fan = normal_fan($sP);
# The following line computes all tempting index sets
@prob = find_temptings($fan);
# To determine the maculate cones, the following should work
@macRegions = map(build_cone_from_index_set($_, $fan->RAYS), @prob);
# The rays in $fan don't have the same ordering, the following takes care of
# that. The ordering will then be the same as in $fanRays.
