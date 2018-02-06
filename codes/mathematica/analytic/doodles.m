(* ::Package:: *)

(* ::Input:: *)
(*LHS = (1-pl)(1-pr)+l pl(1-pr) + l(1-pl)pr +l^2 pl pr;*)
(*LHS2 = (1-pl)(1-z pr)+ (1-pr)(1-z pl)*)
(*FullSimplify[LHS2]*)
(*Collect[LHS, a, FullSimplify]*)


(* ::Input:: *)
(*pl =  p - a dp +1/2 a^2 d2p;*)
(*pr =  p + a dp +1/2 a^2  d2p;*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*v = Sqrt[2z];*)
(*u = (1+z)/v;*)
(*Collect[Expand[(u - v pl)(u-v pr)+1-1/(2 z)-z/2] - LHS2, {pr, pl}]*)


(* ::Input:: *)
(*FullSimplify[1-1/(2 z)-z/2]*)


(* ::Input:: *)
(*SymmetricReduction[LHS2, {pl, pr}]*)
