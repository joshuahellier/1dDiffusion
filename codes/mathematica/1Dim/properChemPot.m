(* ::Package:: *)

(* ::Input:: *)
(*redExp[m_, \[Rho]_, \[Lambda]_] :=  -2 m Log[m] + (1-\[Rho])  Log[1-\[Rho]]+  \[Rho] Log[\[Rho]] - (1-\[Rho]-m)Log[1-m-\[Rho]] - (\[Rho]-m)Log[\[Rho]-m] -(\[Rho]- m)  Log[\[Lambda]];*)


(* ::Input:: *)
(*D[D[redExp[m, \[Rho], \[Lambda]], m], m]*)


(* ::InheritFromParent:: *)
(*-2 Log[m]+Log[\[Lambda]]+Log[1-m-\[Rho]]+Log[-m+\[Rho]]*)


(* ::Input:: *)
(*Collect[\[Lambda](1-m-\[Rho])(\[Rho]-m)-m^2, m]*)


(* ::Input:: *)
(*mCrit[\[Lambda]_, \[Rho]_] := (-\[Lambda]+Sqrt[\[Lambda]^2+4\[Lambda](1-\[Lambda])\[Rho](1-\[Rho])])/(2(1-\[Lambda]));*)


(* ::Input:: *)
(*curvature[\[Lambda]_, \[Rho]_, m_]:= -(2/m)-1/(1-m-\[Rho])-1/(-m+\[Rho]);*)


(* ::Input:: *)
(*DensityPlot[curvature[\[Lambda], \[Rho], mCrit[\[Lambda], \[Rho]]], {\[Rho], 0, 1}, {\[Lambda], 0, 1}, PlotLegends->Automatic]*)


(* ::Input:: *)
(*partFnLog[\[Rho]_, \[Lambda]_]:= redExp[mCrit[\[Lambda], \[Rho]], \[Rho], \[Lambda]]+Log[Sqrt[(-2\[Pi])/curvature[\[Lambda], \[Rho], mCrit[\[Lambda], \[Rho]]]]];*)


(* ::Input:: *)
(*partFnLog[0.2, 0.3]*)


(* ::Input:: *)
(*ContourPlot[ -partFnLog[\[Rho], 10^\[Tau]], {\[Rho], 0.01, 0.99}, {\[Tau], -6, 6}, PlotLegends->Automatic, Contours->30, ColorFunction->"Pastel", FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", "-Ln Z"}, {"\[Rho]", None}}, Frame->True, ImageSize->400]*)


D[-partFnLog[\[Rho], \[Lambda]], \[Rho]]


(* ::Input:: *)
(*FullSimplify[partFnLog[\[Lambda], \[Rho]], {0<\[Lambda]<1, 0<\[Rho]<1}]*)


(* ::Input:: *)
(*TeXForm[-partFnLog[\[Lambda], \[Rho]]]*)


\[Mu][\[Lambda]_, \[Rho]_]:=-((((2 (1-\[Lambda]) (4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho]))/(Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]] (-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])^2)+(-1-(4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho])/(4 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]]))/(1-\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))^2+(1-(4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho])/(4 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]]))/(\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))^2) ((4 (1-\[Lambda]))/(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])+1/(1-\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))+1/(\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))))/(2 (-((4 (1-\[Lambda]))/(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]]))-1/(1-\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))-1/(\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))^2))+(1-(4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho])/(4 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])) Log[\[Lambda]]+Log[1-\[Rho]]-Log[\[Rho]]+((4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho]) Log[(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))])/(2 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])+(-1-(4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho])/(4 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])) Log[1-\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))]+(1-(4 (1-\[Lambda]) \[Lambda] (1-\[Rho])-4 (1-\[Lambda]) \[Lambda] \[Rho])/(4 (1-\[Lambda]) Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])) Log[\[Rho]-(-\[Lambda]+Sqrt[\[Lambda]^2+4 (1-\[Lambda]) \[Lambda] (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))];


ContourPlot[\[Mu][E^\[Tau], \[Rho]], {\[Rho], 0, 1}, {\[Tau], 4, 8}, Contours->50]


Manipulate[Plot[\[Mu][E^\[Tau], \[Rho]], {\[Rho], 0, 1}], {\[Tau], 4, 9}]


Manipulate[Plot[\[Mu][E^\[Tau], \[Rho]], {\[Rho], 0, 1}], {\[Tau], -6, 6}]


N[E^6]


FullSimplify[Exp[partFnLog[\[Lambda], \[Rho]]]]


ContourPlot[ -partFnLog[\[Rho], 10^\[Tau]], {\[Rho], 0.01, 0.99}, {\[Tau], -3, 3}, PlotLegends->Automatic, Contours->30, ColorFunction->"Pastel", FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", "Free Energy Density"}, {"\[Rho]", None}}, Frame->True, ImageSize->500]


ContourPlot[ \[Mu][10^\[Tau] , \[Rho]], {\[Rho], 0.01, 0.99}, {\[Tau], -3, 3}, PlotLegends->Automatic, Contours->30, ColorFunction->"Pastel", FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", "Chemical Potential"}, {"\[Rho]", None}}, Frame->True, ImageSize->500, PlotRange->{-25, 25}]


ContourPlot[mCrit[\[Lambda], \[Rho]], {\[Rho], 0, 1}, {\[Lambda], 0, 10}, PlotLegends->Automatic, RegionFunction->Function[{\[Lambda], \[Rho], z}, Re[mCrit[\[Lambda], \[Rho]]]<1-\[Rho]]]


mCrit[8, 0.9]


Plot[1-4\[Rho](1-\[Rho]), {\[Rho], -1, 2}]


Expand[4(\[Rho]-1/2)^2]


mCrit[\[Lambda], \[Rho]]


partFnLog[\[Lambda], \[Rho]]


FullSimplify[Expand[\[Mu][\[Rho], \[Lambda]]]]


FullSimplify[D[mCrit[\[Lambda], \[Rho]], \[Rho]]]
