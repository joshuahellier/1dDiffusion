(* ::Package:: *)

(* ::Input:: *)
(*r1r = r + 1/2 a dr +1/8 a^2 d2r;*)
(*r2r = r + 3/2 a dr +9/8 a^2 d2r;*)
(*r1l = r - 1/2 a dr +1/8 a^2 d2r;*)
(*r2l = r - 3/2 a dr +9/8 a^2 d2r;*)
(*n1r = n + 1/2 a dn +1/8 a^2 d2n;*)
(*n2r = n + 3/2 a dn +9/8 a^2 d2n;*)
(*n1l = n - 1/2 a dn +1/8 a^2 d2n;*)
(*n2l = n - 3/2 a dn +9/8 a^2 d2n;*)


goRight = r1l(1-r1r)( (1-n1l)(1-r2l) + (1-n1l)r2l L1 + n1l(1-r2l)L2 + n1l r2l L3);
goLeft = r1r(1-r1l)( (1-n1r)(1-r2r) + (1-n1r)r2r L1 + n1r(1-r2r)L2 + n1r r2r L3);


coeffs = CoefficientList[goRight-goLeft, a];


FullSimplify[-coeffs[[2]]]


Jn[r_, n_, z1_, z2_, m_] := (-1+r) r (z2-m r);
Jr[r_, n_, z1_, z2_, m_]:= (1+z1 r (-4+3 r)+n (-z2+4m r-3m r^2))


Manipulate[GraphicsGrid[{{DensityPlot[Jn[r, n, z1, z2, m], {r, 0, 1}, {n, 0, 1}, ColorFunction->"Rainbow", ImageSize->Large], DensityPlot[Jr[r, n, z1, z2, m], {r, 0, 1}, {n, 0, 1}, ColorFunction->"Rainbow", ImageSize->Large]}}], {{z1, 0}, -1, 1}, {{z2, 0}, -1, 1}, {{m, 0}, -1, 1}]
