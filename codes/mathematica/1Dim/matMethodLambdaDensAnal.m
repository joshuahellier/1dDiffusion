(* ::Package:: *)

(* ::Input:: *)
(*pwd = "/home/jhell/research/results/exactSolns/concDiffRuns/secondAttempt/";*)


eigData = Import[pwd<>"eigSet.dat", "Table"];
revEigData = {Log10[#[[1]]], #[[2]], #[[3]]}&/@eigData;


(* ::Input:: *)
(*currData = Import[pwd<>"currSet.dat", "Table"];*)
(*currDataFiltered = Select[currData,( #[[3]]>0)&];*)
(*revCurrData = {Log10[#[[1]]], #[[2]],Log10[Abs[#[[3]]]]}&/@currDataFiltered;*)
(*wholeCurrData = {#[[1]], #[[2]],#[[3]]}&/@currDataFiltered;*)
(*entData = Import[pwd<>"entSet.dat", "Table"];*)
(*entDataFiltered = Select[entData,( Abs[#[[3]]]>10^-10)&];*)
(*revEntData = {Log10[#[[1]]], #[[2]], Log10[#[[3]]]}&/@entDataFiltered;*)
(*densData = Import[pwd<>"densSet.dat", "Table"];*)
(*revDensData = {Log10[#[[1]]], #[[2]], Abs[#[[3]]]}&/@densData;*)
(*eigData = Import[pwd<>"eigSet.dat", "Table"];*)
(*revEigData = {Log10[#[[1]]], #[[2]], #[[3]]}&/@eigData;*)


(* ::Input:: *)
(*ListContourPlot[revEntData, InterpolationOrder->1, PlotRange->All, Contours->100, PlotLegends->Automatic, ImageSize->1024, FrameLabel->{{"\[Delta]\[Rho]", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ColorFunction->"Rainbow"]*)


(* ::Input:: *)
(*ListContourPlot[revDensData, InterpolationOrder->1, PlotRange->{0, 1}, Contours->100, PlotLegends->Automatic, ImageSize->1024, FrameLabel->{{"\[Delta]\[Rho]", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ColorFunction->"Rainbow"]*)


(* ::Input:: *)
(*ListContourPlot[revCurrData, InterpolationOrder->1, PlotRange->{{-3, 3}, {0, 1}, {-8, 2}}, Contours->100, PlotLegends->Automatic, FrameLabel->{{"\[Delta]\[Rho]", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ColorFunction->"Rainbow", ImageSize->1024]*)


ListContourPlot[wholeCurrData, PlotRange->{{0, 2}, {0, 1}, {0, 1}}, Contours->100, InterpolationOrder->1, ColorFunction->"Rainbow"]


ListContourPlot[revEigData, InterpolationOrder->1, PlotRange->{10^-20, 10^-15}, Contours->100]
