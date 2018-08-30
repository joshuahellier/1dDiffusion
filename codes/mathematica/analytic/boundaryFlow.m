(* ::Package:: *)

(* ::Input:: *)
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));*)


(* ::Input:: *)
(*ContourPlot[J[b, t, 0.8], {b, 0, 1}, {t, 0, 1},  PlotLegends->True, FrameLabel->{{"\!\(\*SubscriptBox[\(\[Rho]\), \(B\)]\)", None}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(T\)]\)", None}}, RotateLabel->True, Frame->True, Contours->20, PlotPoints->100]*)


Plot[{J[0.3, 0.1, 1-l], J[0.6, 0.4, 1-l], J[0.9, 0.7, 1-l]}, {l, 0, 2},   PlotLegends->SwatchLegend[Automatic, {"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], FrameLabel->{{"\!\(\*SubscriptBox[\(J\[Tau]\), \(0\)]\)/\!\(\*SuperscriptBox[\(a\), \(2\)]\)", None}, {"\[Lambda]", None}}, Frame->True]


curr = J[b, t, 1-l]


FullSimplify[Solve[curr==0, l]]


Expand[b^2+b (-2+t)+(-2+t) t]


ContourPlot[1+1/(b^2+b (-2+t)+(-2+t) t), {b, 0, 1}, {t, 0, 1}, PlotRange->{0, 0.25}, ColorFunction->"Rainbow", PlotLegends->True, PlotPoints->100, ColorFunctionScaling->True, FrameLabel->{{"\!\(\*SubscriptBox[\(\[Rho]\), \(L\)]\)", Subscript[\[Lambda], c]}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)", None}}, Frame->True]
