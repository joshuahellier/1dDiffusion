(* ::Package:: *)

(* ::Input:: *)
(*f[x_] = x Log[x]-x;*)


(* ::Input:: *)
(*fullExp[L_, \[Lambda]_, m_, \[Rho]_] = f[\[Rho] L]+f[L(1-\[Rho])] - 2f[L m] -f[L(\[Rho]-m)] - f[L(1-\[Rho]-m)] - m L Log[\[Lambda]];*)


(* ::Input:: *)
(*-L (1-\[Rho])+L (1-m-\[Rho])-L \[Rho]+L (-m+\[Rho])-2 (-L m+L m Log[L m])-L m Log[\[Lambda]]+L (1-\[Rho]) Log[L (1-\[Rho])]-L (1-m-\[Rho]) Log[L (1-m-\[Rho])]+L \[Rho] Log[L \[Rho]]-L (-m+\[Rho]) Log[L (-m+\[Rho])]*)


(* ::Input:: *)
(*FullSimplify[fullExp]*)


(* ::Input:: *)
(*exponent[L_, m_, \[Rho]_, \[Lambda]_] := -2L m Log[m] + (L(1-\[Rho]) -1/2) Log[1-\[Rho]]+ L \[Rho] Log[\[Rho]] - (L(1-\[Rho]-m)-1/2)Log[1-m-\[Rho]] - L(\[Rho]-m)Log[\[Rho]-m] - m L Log[\[Lambda]] -1/2 Log[1-m-\[Rho]] - 1/2 Log[\[Rho]-m];*)


redExp[m_, \[Rho]_, \[Lambda]_] :=  -2 m Log[m] + (1-\[Rho])  Log[1-\[Rho]]+  \[Rho] Log[\[Rho]] - (1-\[Rho]-m)Log[1-m-\[Rho]] - (\[Rho]-m)Log[\[Rho]-m] - m  Log[\[Lambda]] ;


(* ::Input:: *)
(*D[fullExp[L, \[Lambda], m, \[Rho]], m]*)


(* ::Input:: *)
(*saddleM[\[Lambda]_, \[Rho]_]:= (1 -Sqrt[1-4(1-\[Lambda])\[Rho] (1-\[Rho])])/(2(1-\[Lambda]));*)


(* ::Input:: *)
(*ContourPlot[saddleM[\[Lambda], \[Rho]], {\[Lambda], 0, 2}, {\[Rho], 0, 0.5}, RegionFunction->Function[{\[Lambda], \[Rho], z},saddleM[\[Lambda], \[Rho]]<\[Rho]],  PlotLegends->Automatic]*)


(* ::Input:: *)
(*FullSimplify[D[D[fullExp[L, \[Lambda], m, \[Rho]], m], m]]*)


(* ::Input:: *)
(*curvature[\[Lambda]_, m_, \[Rho]_]:= (m+2 (-1+\[Rho]) \[Rho])/(m (m-\[Rho]) (-1+m+\[Rho]));*)


(* ::Input:: *)
(*Plot[curvature[1/2, saddleM[1/2, \[Rho]], \[Rho]], {\[Rho], 0, 1/2}]*)


(* ::Input:: *)
(*FullSimplify[curvature[\[Lambda], saddleM[\[Lambda], \[Rho]], \[Rho]]]*)


(* ::Input:: *)
(*Manipulate[ContourPlot[Re[fullExp[1, \[Lambda], x+I y, \[Rho]]], {x, 0, \[Rho]}, {y, -0.2, 0.2}, PlotRange->{0, 2},  PlotLegends->Automatic], {\[Rho], 0, 0.5}, {\[Lambda], 0, 1}]*)


(* ::Input:: *)
(*intRes[\[Lambda]_, \[Rho]_]:=redExp[saddleM[\[Lambda], \[Rho]],  \[Rho], \[Lambda]]+Log[Sqrt[(2\[Pi])/-curvature[\[Lambda], saddleM[\[Lambda], \[Rho]], \[Rho]]]];*)


(* ::Input:: *)
(*intRes[\[Lambda], \[Rho]]*)


(* ::Input:: *)
(*freeEnergy[\[Lambda]_, \[Rho]_] := -Log[\[Lambda]]intRes[\[Lambda], \[Rho]];*)
(*freeEnergy[\[Lambda], \[Rho]]*)
(*D[freeEnergy[\[Lambda], \[Rho]], \[Rho]]*)
(*chemPot[\[Lambda]_, \[Rho]_]:= -((Sqrt[\[Pi]] (-(((2 (-1+\[Rho])+2 \[Rho]-(-4 (1-\[Lambda]) (1-\[Rho])+4 (1-\[Lambda]) \[Rho])/(4 (1-\[Lambda]) Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])) (1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]]) (-\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))) (-1+\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))/((1-\[Lambda]) (2 (-1+\[Rho]) \[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda])))^2))+((1-(-4 (1-\[Lambda]) (1-\[Rho])+4 (1-\[Lambda]) \[Rho])/(4 (1-\[Lambda]) Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])) (1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]]) (-\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))/((1-\[Lambda]) (2 (-1+\[Rho]) \[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))+((-1-(-4 (1-\[Lambda]) (1-\[Rho])+4 (1-\[Lambda]) \[Rho])/(4 (1-\[Lambda]) Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])) (1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]]) (-1+\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))/((1-\[Lambda]) (2 (-1+\[Rho]) \[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))-((-4 (1-\[Lambda]) (1-\[Rho])+4 (1-\[Lambda]) \[Rho]) (-\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))) (-1+\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))/(2 (1-\[Lambda]) Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]] (2 (-1+\[Rho]) \[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))) Log[\[Lambda]])/(2 Sqrt[((1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]]) (-\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))) (-1+\[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))/((1-\[Lambda]) (2 (-1+\[Rho]) \[Rho]+(1-Sqrt[1-4 (1-\[Lambda]) (1-\[Rho]) \[Rho]])/(2 (1-\[Lambda]))))]));*)
(*ContourPlot[I chemPot[Exp[\[Tau]], \[Rho]], {\[Tau], -6, 6}, {\[Rho], 0.001, 0.5}, PlotRange->Automatic]*)


(* ::Input:: *)
(*FullSimplify[chemPot[\[Lambda], \[Rho]]]*)


(* ::Input:: *)
(*Numerator[%78]*)


(* ::Input:: *)
(*chemPot[0.3, 0.2]*)


(* ::Input:: *)
(*With[{n=Abs[0. +2.64245 I],a=Arg[0. +2.64245 I]},Defer[n E^(I a)]]*)


(* ::Input:: *)
(*Graphics[{}, AspectRatio -> 1, DisplayFunction -> Identity, Frame -> True, FrameTicks -> {{Automatic, Automatic}, {Automatic, Automatic}}, GridLinesStyle -> Directive[GrayLevel[0.5, 0.4]], Method -> {"DefaultBoundaryStyle" -> Automatic}, PlotRange -> {{0., 0.}, {0., 0.}}, PlotRangeClipping -> True, PlotRangePadding -> {{Scaled[0.02], Scaled[0.02]}, {Scaled[0.02], Scaled[0.02]}}, Ticks -> {Automatic, Automatic}]*)


ContourPlot[freeEnergy[\[Lambda], \[Rho]], {\[Lambda], 0, 2}, {\[Rho], 0, 1}, PlotRange->{-2, 2}, PlotLegends->Automatic, Contours->50]


chemPot[\[Lambda], \[Rho]] := D[freeEnergy[\[Lambda], \[Rho]], \[Rho]]


chemPot[0.9, 0.55]


ContourPlot[freeEnergy[Exp[\[Tau]], \[Rho]], {\[Rho], 0.0, 0.5}, {\[Tau], -6, 6}, PlotLegends->Automatic, Contours->50, ColorFunction->"Rainbow"]


freeEnergy[\[Lambda], \[Rho]]
