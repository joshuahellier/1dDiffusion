(* ::Package:: *)

(* ::Input:: *)
(*n=2*)


(* ::Input:: *)
(*flowForm = (1-z r)^(2(n-1)) (1+z r((2n+1)r-(2n+2)))*)


(* ::Input:: *)
(*soln = Integrate[flowForm, r]*)


(* ::Input:: *)
(*FullSimplify[soln]*)


(* ::Input:: *)
(*solnForm[r_, z_] := soln*)


(* ::Input:: *)
(*solnForm[r0, z]*)


(* ::Input:: *)
(*current[r0_, rL_, z_] := r0-4 r0^2 z+r0^5 z^3-1/2 r0^4 z^2 (5+3 z)+1/3 r0^3 z (5+13 z) - (rL-4 rL^2 z+rL^5 z^3-1/2 rL^4 z^2 (5+3 z)+1/3 rL^3 z (5+13 z));*)


(* ::Input:: *)
(*Manipulate[ContourPlot[current[r0, rL, 1-l], {r0, 0, 1}, {rL, 0,1}, ColorFunction->"Rainbow", PlotRange->{-4, 4}, Contours->200], {l, 0, 2, 0.001}]*)
