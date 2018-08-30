(* ::Package:: *)

(* ::Input:: *)
(*x[r_, rB_, rT_, z_] := -((r(1-2z r +z r^2))/(rB-rT+z(rB^3-rT^3+2rT^2-2rB^2)));*)
(*Integrate[x[r, rB, rT, z], {r, rB, rT}]*)


(* ::Input:: *)
(*intX[rB_, rT_, z_]:=(6 (rB+rT)+(3 rB^3+rB^2 (-8+3 rT)+rB rT (-8+3 rT)+rT^2 (-8+3 rT)) z)/(12+12 (rB^2+rB (-2+rT)+(-2+rT) rT) z);*)


(* ::Input:: *)
(*Manipulate[Plot[x[r, 3/4, 1/4, z], {r, 3/4, 1/4}], {z, 0, 100, 0.01}]*)


(* ::Input:: *)
(*intX[rB, rT, z]*)


(* ::InheritFromParent:: *)
(*(6 (rB+rT)+(3 rB^3+rB^2 (-8+3 rT)+rB rT (-8+3 rT)+rT^2 (-8+3 rT)) z)/(12+12 (rB^2+rB (-2+rT)+(-2+rT) rT) z)*)


(* ::Input:: *)
(*intR[rB_, rT_, z_]:=  rT x[rT, rB, rT, z] - rB x[rB, rB, rT, z]-intX[rB, rT, z]*)


(* ::Input:: *)
(*A[rB_, rT_, z_]:= intR[rB, rT, z]/(x[rT, rB, rT, z]-x[rB, rB, rT, z]);*)


(* ::Input:: *)
(*FullSimplify[A[rB, rT, z]]*)


(* ::Input:: *)
(*Plot[{A[0.3, 0.1, 1-l], A[0.6, 0.4, 1-l], A[0.9, 0.7, 1-l]}, {l, 0.25, 2}, PlotRange->{0.1, 0.9},   PlotLegends->SwatchLegend[Automatic, {"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], FrameLabel->{{"\!\(\*OverscriptBox[\(\[Rho]\), \(_\)]\)", None}, {"\[Lambda]", None}}, Frame->True]*)
(*LogLogPlot[{A[0.3, 0.1, 1-l], A[0.6, 0.4, 1-l], A[0.9, 0.7, 1-l]}, {l, 0.25, 10^6}, PlotRange->{0.1, 0.9},   PlotLegends->SwatchLegend[Automatic, {"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], FrameLabel->{{"\!\(\*OverscriptBox[\(\[Rho]\), \(_\)]\)", None}, {"\[Lambda]", None}}, Frame->True]*)


(* ::Input:: *)
(*Manipulate[Plot[x[r, 0.75, 0.25, 1-l], {r, 0.25, 0.75}], {l, 0.25, 0.75}]*)


(* ::Input:: *)
(*Manipulate[ContourPlot[A[rB, rT, z], {rB, 0, 1}, {rT, 0, 1}, PlotRange->{0, 1}, PlotLegends->True], {z, 0, 1, 0.02}]*)


Manipulate[Plot[x[r, rB, rT, z], {r, rB, rT}], {rB, 0.5, 1, 0.01}, {rT, 0, 0.5, 0.01}, {z, 0, 0.75}]


LogLogPlot[A[0.9, 0.7, 1-l], {l, 1/4, 10^3}]


FullSimplify[Expand[(9 rB^3+rB^2 (-16+9 rT)+rB rT (-16+9 rT)+rT^2 (-16+9 rT))]]


Expand[(9 rB^3+rB^2 (-16+9 rT)+rB rT (-16+9 rT)+rT^2 (-16+9 rT))]
