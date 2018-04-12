(* ::Package:: *)

(* ::Input:: *)
(*r1l = r - 1/2  a dr +1/8 a^2 d2r - (1/8)(1/6)  a^3 d3r+ (1/16)(1/24)a^4 d4r;*)
(*r2l = r - 3/2a dr +(3/2)^2  (1/2)a^2 d2r - (3/2)^3 (1/6)  a^3d3r+ (3/2)^4(1/24)a^4 d4r;*)
(*r1r = r + 1/2  a dr +1/8 a^2 d2r + (1/8)(1/6)  a^3 d3r+ (1/16)(1/24)a^4 d4r;*)
(*r2r = r + 3/2a dr +(3/2)^2 (1/2)a^2 d2r + (3/2)^3 (1/6)  a^3 d3r+ (3/2)^4(1/24)a^4 d4r;*)


(* ::Input:: *)
(*r1r*)
(*r2r*)
(*r1l*)
(*r2l*)


(* ::InheritFromParent:: *)
(*a^3/48+a^4/384+(a^2 d2r)/8+(a dr)/2+r*)


(* ::Input:: *)
(*goRight = r1l(1-r1r)(1-z r2l);*)
(*goLeft = r1r(1-r1l)(1-z r2r);*)


(* ::Input:: *)
(*diff = goRight - goLeft + O[a]^5*)


(* ::Input:: *)
(*nextTerm = CoefficientList[diff, a][[4]]*)


(* ::Input:: *)
(*FullSimplify[nextTerm]*)
