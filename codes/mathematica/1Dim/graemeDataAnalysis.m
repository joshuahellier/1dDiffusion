(* ::Package:: *)

(* ::Input:: *)
(*data = Import["/home/jhell/Downloads/StickyParticles/100/fort.12", "Table"];*)
(**)


(* ::Input:: *)
(*data*)


(* ::Input:: *)
(*occData = {Log10[#[[3]]], #[[1]], #[[2]]}&/@data;*)


(* ::Input:: *)
(*ListDensityPlot[occData, PlotRange->{{-2, 2}, {0, 102}, {0.4, 1}}, InterpolationOrder->0, ColorFunction->(Blend[{{0, Purple}, {(0.5-0.4)/0.6, Blue},  {(0.7-0.4)/0.6, Green}, {(0.9-0.4)/0.6, Yellow}, {1, Red}}, #]&), FrameLabel->{{"Position", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", None}}, RotateLabel->True, Frame->True, PlotLegends->Automatic]*)
(*ListDensityPlot[occData, PlotRange->{{-2, 2}, {0, 102}, {0.4, 1}}, InterpolationOrder->0, ColorFunction->"Rainbow", FrameLabel->{{"Position", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", None}}, RotateLabel->True, Frame->True, PlotLegends->Automatic]*)


(* ::Input:: *)
(*DensityPlot[x+y, {x, -1, 1}, {y, -1, 1}, ColorFunction->(Blend[{{0, Green}, {0.5, Blue}, {1, Red}}, #]&),  PlotLegends->Automatic]*)
