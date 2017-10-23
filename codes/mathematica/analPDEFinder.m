(* ::Package:: *)

(* ::Input:: *)
(*n = 4;*)
(*zero = 0*UnitVector[n, 1];*)
(*e[i_] := UnitVector[n, i];*)
(*Hess = Table[Piecewise[{{d2p[j, i], j>i}}, d2p[i, j]], {i, 1, n}, {j, 1, n}];*)
(*Jacob = Table[dp[i], {i, 1, n}];*)
(*p[x_] := p0 + Jacob.x + 1/2 x.(Hess.x);*)
(*loss = -p[zero] Sum[2-(1+z)(p[a e[i]]+p[-a e[i]])+2z p[a e[i]]p[-a e[i]] Product[Piecewise[{{(1-z p[-a e[j]])(1-z p[a e[j]]), j!=i}}, 1], {j, 1, n}], {i, 1, n}] ;*)
(*gain = (1-p[zero])Sum[p[-a e[i]](1-z p[-2a e[i]])Product[Piecewise[{{(1-z p[-a e[j]-a e[i]])(1-z p[a e[j]-a e[i]]), j!=i}}, 1], {j, 1, n}]+p[a e[i]](1-z p[2a e[i]])Product[Piecewise[{{(1-z p[-a e[j]+a e[i]])(1-z p[a e[j]+a e[i]]), j!=i}}, 1], {j, 1, n}],{i, 1, n}];*)
(*total = loss+gain;*)
(*newTot = ExpandAll[total];*)
(*collectedTot = Collect[newTot, a] + O[a]^4;*)
(*FullSimplify[collectedTot]*)


-6 (p0^2 z (-2+p0 z) (-1+p0+p0 z) (2+p0 z (-2+p0 z)))
-4 (p0^2 z (-2+p0 z) (-1+p0+p0 z))
