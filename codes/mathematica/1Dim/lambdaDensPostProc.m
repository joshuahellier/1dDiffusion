(* ::Package:: *)

(* ::Input:: *)
(*dataPlace = "/home/jhell/research/results/exactSolns/densityLambdaRuns/secondAttempt/";*)
(*autoCorrData = {#[[2]], Log10[#[[1]]], Log10[#[[3]]]}&/@Select[Import[dataPlace<>"autoCorrTimeSet.dat", "Data"],( Length[#]>1)&];*)
(*currData =Select[Import[dataPlace<>"currSet.dat", "Data"],( Length[#]>1)&];*)
(*densData = {#[[2]], Log10[#[[1]]], #[[3]]}&/@Select[Import[dataPlace<>"densSet.dat", "Data"],( Length[#]>1)&];*)
(*entData = {#[[2]], Log10[#[[1]]], #[[3]]}&/@Select[Import[dataPlace<>"entSet.dat", "Data"],( Length[#]>1)&];*)
(*eigData = {#[[2]], Log10[#[[1]]], Log10[Abs[#[[3]]]]}&/@Select[Import[dataPlace<>"eigSet.dat", "Data"],( Length[#]>1)&];*)


eigData


(* ::Input:: *)
(**)


(* ::Input:: *)
(*currData*)


(* ::Input:: *)
(*ListContourPlot[autoCorrData, InterpolationOrder->0, Contours->50, PlotRange->All, ColorFunction->"Rainbow"]*)
(*ListContourPlot[{#[[2]], Log10[#[[1]]], Log10[-#[[3]]]}&/@currData, InterpolationOrder->1, Contours->50, PlotRange->{All,All,All}, ColorFunction->"Rainbow"]*)
(*ListDensityPlot[currData, InterpolationOrder->1, PlotRange->{All,All,All}, ColorFunction->"Rainbow"]*)
(*ListContourPlot[densData, InterpolationOrder->0, Contours->50, PlotRange->{All,All,All}, ColorFunction->"Rainbow"]*)
(*ListContourPlot[entData, InterpolationOrder->0, Contours->50, PlotRange->{All,All,{0, 2}}, ColorFunction->"Rainbow", PlotLegends->Automatic]*)
(*ListDensityPlot[eigData, InterpolationOrder->0, PlotRange->{All,All,All}, ColorFunction->"Rainbow", PlotLegends->Automatic]*)


splitCurrs = GatherBy[ {Log10[#[[1]]], #[[2]], Log10[-#[[3]]]}&/@currData, Part[#, 2]&];
descDerivCalc[x_] := Table[{(x[[i+1]][[1]]+x[[i]][[1]])/2, x[[i]][[2]], (x[[i+1]][[3]]-x[[i]][[3]])/(x[[i+1]][[1]]-x[[i]][[1]])},{i, 1, Length[x]-1}];
orderParamData = Flatten[Table[descDerivCalc[splitCurrs[[i]]],{i, 1, Length[splitCurrs]}], 1];
Show[ListContourPlot[{#[[2]], #[[1]], #[[3]]}&/@orderParamData, InterpolationOrder->1, Contours->30, PlotRange->{All, {-3, 1},{0.0, 5}}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->512], FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", "Diffusion Coefficient Exponent"}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]
Show[ListContourPlot[entData, InterpolationOrder->1, Contours->30, PlotRange->{All, {-3, 1},Automatic}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->512], FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", "Entropy"}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]
Show[ListContourPlot[{#[[2]], Log10[#[[1]]], Log10[-#[[3]]*10]}&/@currData, InterpolationOrder->1, Contours->30, PlotRange->{All, {-3, 1},Automatic}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->512], FrameLabel->{{"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", "\!\(\*SubscriptBox[\(Log\), \(10\)]\)[DiffCoeff]"}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[eigData, InterpolationOrder->0, PlotRange->{All, All, All}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->512], FrameLabel->{{"Log[\[Lambda]]", "Log[Abs[Eigenvalue]]"}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]


Show[ListContourPlot[{#[[2]], #[[1]], #[[3]]}&/@orderParamData, InterpolationOrder->1, Contours->30, PlotRange->{All, {-3, 1},{0.0, 4}}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->512], FrameLabel->{{"Log[\[Lambda]]", "Diffusion Coefficient Exponent"}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]
