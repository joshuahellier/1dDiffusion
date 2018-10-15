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
(*Manipulate[ContourPlot[current[r0, rL, 1-l], {r0, 0, 1}, {rL, 0,1}, ColorFunction->"Rainbow", PlotRange->{-1, 1}, Contours->200], {l, 0, 2, 0.001}]*)


Show[ContourPlot[current[r0, rL, 1-0.2], {r0, 0, 1}, {rL, 0,1}, ColorFunction->"Rainbow", PlotRange->All, Contours->30, PlotPoints->100, PlotLegends->Automatic, ImageSize->300], FrameLabel->{{"\!\(\*SubscriptBox[\(\[Rho]\), \(L\)]\)", "\!\(\*SubscriptBox[\(J\), \(0\)]\)"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)", None}}, RotateLabel->True, Frame->True]


TeXForm[FullSimplify[current[Subscript[\[Rho], 0], Subscript[\[Rho], L], \[Zeta]]]]


latex


TraditionalForm[current[r0, rL, z]]


Show[LogLogPlot[{current[0.3, 0.1, 1-l], current[0.6, 0.4, 1-l], current[0.9, 0.7, 1-l]}, {l, 10^-2, 10^2}, PlotRange->{10^-3, 10^5}, PlotPoints->100, PlotLegends->{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}, ImageSize->512], FrameLabel->{{"\!\(\*SubscriptBox[\(J\), \(0\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


diffCoeff[r_, z_]:=D[current[r+1/2 dr, r-1/2 dr, z], dr]


diffCoeff[r, z]
