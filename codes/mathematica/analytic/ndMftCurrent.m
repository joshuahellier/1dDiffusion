(* ::Package:: *)

(* ::Input:: *)
(*n=7*)
(*i=1;*)
(*zero = 0*UnitVector[n, 1];*)
(*e[i_] := UnitVector[n, i];*)
(*Hess = Table[Piecewise[{{d2p[j, i], j>i}}, d2p[i, j]], {i, 1, n}, {j, 1, n}];*)
(*Jacob = Table[dp[i], {i, 1, n}];*)
(*p[x_] := p0 + Jacob.x + 1/2 x.(Hess.x);*)


rightJ = 1/t0 (1-p[1/2 a e[i]])p[-(1/2)a e[i]](1-z p[-(3/2)a e[i]])Product[Piecewise[{{(1-z p[-a e[j]-1/2 a e[i]])(1-z p[a e[j]-1/2 a e[i]]), j!=i}}, 1], {j, 1, n}];
leftJ = 1/t0 (1-p[-(1/2)a e[i]])p[1/2 a e[i]](1-z p[3/2 a e[i]])Product[Piecewise[{{(1-z p[-a e[j]+1/2 a e[i]])(1-z p[a e[j]+1/2 a e[i]]), j!=i}}, 1], {j, 1, n}];
fullJ = rightJ - leftJ + O[a]^3;
FullSimplify[fullJ]


A[r_, m_, z_]:=(1-z r)^(2(m-1)) (1+z r((2m+1)r-(2m+2)));
Manipulate[Plot[A[r, m, z], {r, 0, 1}, PlotRange->{0, 6}], {m, 1, 7, 1}, {{z, 0}, -1, 1, 0.01}]
