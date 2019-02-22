(* ::Package:: *)

(* ::Input:: *)
(*location = "/home/jhell/research/results/batchJobs/concRuns/attempt2/";*)
(*rateMeans =Table[Import[location<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, 5}] ;*)
(*rateErrs = Table[Import[location<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, 5}] ;*)
(*densMeans = Table[Import[location<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, 5}] ;*)
(*densErrs = Table[Import[location<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, 5}] ;*)
(*altPlot= Table[Import[location<>ToString[index]<>"/altPlot.dat", "Data"], {index, 0, 5}] ;*)
(*sysSize = 124;*)
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2))/sysSize;*)
(*k = 0.0001;*)
(*lList = {"0p05", "0p09", "0p13", "0p17", "0p21", "0p25"};*)
(*lambda = {"0.05", "0.09", "0.13", "0.17", "0.21", "0.25"};*)
(**)


Table[Export["/home/jhell/research/writingsPhD/actualThesis/numerics/images/concFrames/concDataCurr"<>ToString[lList[[i]]]<>".png", ListDensityPlot[{#[[1]], #[[2]], Log10[Abs[#[[3]]]]}&/@rateMeans[[i]], InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{{0, 1}, {0, 1}, {-6, -2}}, FrameLabel->{{"\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)", "\!\(\*SubscriptBox[\(Log\), \(10\)]\)[|E[J]|/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)]"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(L\)]\)", "\[Lambda]="<>lambda[[i]]}}, RotateLabel->True, Frame->True, ImageSize->1024]], {i, 1, 6}]


Table["\includegraphics[width=0.49\linewidth]{numerics/images/concFrames/concDataCurr"<>lList[[i]]<>".png}", {i, 1, 6}]


Table[Export["/home/jhell/research/writingsPhD/actualThesis/numerics/images/concFrames/concDataDens"<>lList[[i]]<>".png", ListDensityPlot[{#[[1]], #[[2]], #[[3]]}&/@densMeans[[i]], InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{{0, 1}, {0, 1}, {0, 1}}, FrameLabel->{{"\!\(\*SubscriptBox[\(\[Rho]\), \(0\)]\)", "E[\[Rho]]"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(L\)]\)", "\[Lambda]="<>lambda[[i]]}}, RotateLabel->True, Frame->True, ImageSize->1024]], {i, 1, 6}]


(* ::Input:: *)
(*Manipulate[GraphicsGrid[{{Show[{ListDensityPlot[rateMeans[[index+1]], ColorFunction->"Rainbow",ColorFunctionScaling->True, ImageSize->Medium, PlotRange->{-0.0001, 0.0001}, InterpolationOrder->0, PlotLegends->True], ContourPlot[J[b, t, 1-(lList[[index+1]]+shift)]Sign[b-t]==k, {b, 0, 1}, {t, 0, 1}, ContourStyle->Directive[AbsoluteThickness[3],Black, Opacity[0.5]]]}], ListDensityPlot[rateErrs[[index+1]], ColorFunction->"Rainbow",  PlotRange->{0, 100}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}, {ListDensityPlot[densMeans[[index+1]], ColorFunction->"Rainbow", PlotRange->{0, 1}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[densErrs[[index+1]], ColorFunction->"Rainbow", PlotRange->{0, 10}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}}, ImageSize->1200], {index, 0, 5, 1}, {{shift, 0}, -0.2, 0.2 }]*)


(* ::InheritFromParent:: *)
(*Manipulate[GraphicsGrid[*)
(*   {{Show[{ListDensityPlot[rateMeans[[index + 1]], ColorFunction -> *)
(*         "Rainbow", ColorFunctionScaling -> True, ImageSize -> Medium, *)
(*        PlotRange -> {-0.0001, 0.0001}, InterpolationOrder -> 0, *)
(*        PlotLegends -> True], ContourPlot[*)
(*        J[b, t, 1 - (lList[[index + 1]] + shift)]*Sign[b - t] == k, *)
(*        {b, 0, 1}, {t, 0, 1}, ContourStyle -> Directive[AbsoluteThickness[3], *)
(*          Black, Opacity[0.5]]]}], ListDensityPlot[rateErrs[[index + 1]], *)
(*      ColorFunction -> "Rainbow", PlotRange -> {0, 100}, *)
(*      InterpolationOrder -> 0, ImageSize -> Medium, PlotLegends -> True]}, *)
(*    {ListDensityPlot[densMeans[[index + 1]], ColorFunction -> "Rainbow", *)
(*      PlotRange -> {0, 1}, InterpolationOrder -> 0, ImageSize -> Medium, *)
(*      PlotLegends -> True], ListDensityPlot[densErrs[[index + 1]], *)
(*      ColorFunction -> "Rainbow", PlotRange -> {0, 10}, *)
(*      InterpolationOrder -> 0, ImageSize -> Medium, PlotLegends -> True]}}, *)
(*   ImageSize -> 1200], {{index, 5}, 0, 5, 1}, {{shift, 0.09799999999999998}, *)
(*   -0.2, 0.2}]*)


(* ::InheritFromParent:: *)
(*Manipulate[GraphicsGrid[{{ListDensityPlot[rateMeans[[index + 1]], *)
(*      ColorFunction -> "Rainbow", ColorFunctionScaling -> True, *)
(*      PlotRange -> {-0.002, 0.002}, InterpolationOrder -> 0, *)
(*      ImageSize -> Medium, PlotLegends -> True], *)
(*     ListDensityPlot[rateErrs[[index + 1]], ColorFunction -> "Rainbow", *)
(*      PlotRange -> {0, 100}, InterpolationOrder -> 0, ImageSize -> Medium, *)
(*      PlotLegends -> True]}, {ListDensityPlot[densMeans[[index + 1]], *)
(*      ColorFunction -> "Rainbow", PlotRange -> {0, 1}, *)
(*      InterpolationOrder -> 0, ImageSize -> Medium, PlotLegends -> True], *)
(*     ListDensityPlot[densErrs[[index + 1]], ColorFunction -> "Rainbow", *)
(*      PlotRange -> {0, 100}, InterpolationOrder -> 0, ImageSize -> Medium, *)
(*      PlotLegends -> True], ListDensityPlot[altPlot[[index + 1]], *)
(*      ColorFunction -> "Rainbow", ColorFunctionScaling -> True, *)
(*      InterpolationOrder -> 0, ImageSize -> Medium, PlotLegends -> True]}}], *)
(*  {index, 0, 5, 1}]*)


(* ::Input:: *)
(*Manipulate[ListDensityPlot[altPlot[[index+1]], ColorFunction->"Rainbow",ColorFunctionScaling->True,InterpolationOrder->1, ImageSize->Medium, PlotLegends->True, PlotRange->All, PlotRange->{-0.002, 0.002}], {index, 0, 5, 1}]*)


A[rB_, rT_, z_]:=(6 (rB+rT)+(9 rB^3+rB^2 (-16+9 rT)+rB rT (-16+9 rT)+rT^2 (-16+9 rT)) z)/(12+12 (rB^2+rB (-2+rT)+(-2+rT) rT) z);
Manipulate[GraphicsRow[{ListDensityPlot[densMeans[[index+1]], ColorFunction->"Rainbow", PlotRange->{0, 1}, InterpolationOrder->0, ImageSize->Large, PlotLegends->True], ContourPlot[A[rB, rT, 1-lList[[index+1]]], {rB, 0, 1}, {rT, 0, 1}, PlotRange->{0, 1}, PlotLegends->True, ImageSize->Large, ColorFunction->"Rainbow"]}, ImageSize->Large], {index, 0, 5, 1}]
