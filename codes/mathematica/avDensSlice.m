(* ::Package:: *)

(* ::Input:: *)
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));*)


(* ::Input:: *)
(*Manipulate[DensityPlot[Sign[diff]J[r+0.5diff, r - 0.5diff, 1-l], {diff, Max[-2r, -1], Min[2r, 1]}, {l, 0, 0.5}, PlotRange->{0.01, 2}, ColorFunction->"Rainbow", PlotPoints->200], {r, 0.01, 0.99}]*)
