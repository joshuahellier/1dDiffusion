(* ::Package:: *)

(* ::Input:: *)
(*r0 = r;*)
(*r1l = r -a dr +1/2 a^2 d2r;*)
(*r2l = r - 2a dr +2 a^2 d2r;*)
(*r1r = r +a dr +1/2 a^2 d2r;*)
(*r2r = r + 2a dr +2 a^2 d2r;*)
(*b0 = b;*)
(*b1l = b -a db +1/2 a^2 d2b;*)
(*b2l = b - 2a db +2 a^2 d2b;*)
(*b1r = r +a db +1/2 a^2 d2b;*)
(*b2r = r + 2a db +2 a^2 d2b;*)


(* ::Input:: *)
(*dtrPlus = Rr(1-r0)(r1l((1-r2l)(1-b1l)+r2l(1-b1l)Lrr +(1-r2l)b1l Lrb +r2l b1l Lrb Lrr)+ r1r((1-r2r)(1-b1r)+r2r(1-b1r)Lrr +(1-r2r)b1r Lrb +r2r b1r Lrb Lrr));*)
(*dtrMinus = Rr r0 ((1-r1l)((1-r1r)(1-b0)+r1r(1-b0)Lrr +(1-r1r)b0 Lrb +r1r b0 Lrb Lrr)+(1-r1r)((1-r1l)(1-b0)+r1l(1-b0)Lrr +(1-r1l)b0 Lrb +r1l b0 Lrb Lrr));*)


(* ::Input:: *)
(*dtr = dtrPlus - dtrMinus;*)


(* ::Input:: *)
(*FullSimplify[CoefficientList[dtr, a]]*)
