(* ::Package:: *)

(* ::Input:: *)
(*roughData12 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40/fort.12", "Table"];*)
(*roughData10 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40/fort.10", "Table"];*)
(*roughData11 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40/fort.11", "Table"];*)
(*occDataRough = {Log10[#[[3]]], #[[1]], #[[2]]}&/@roughData12;*)
(*flucDataRough = {#[[1]], #[[7]]}&/@roughData10;*)
(*flowDataRough = {#[[1]], #[[2]]}&/@roughData11;*)
(*fineData12 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40big/fort.12", "Table"];*)
(*fineData10 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40big/fort.10", "Table"];*)
(*fineData11 = Import["/home/jhell/research/results/graemeData/wholeBunch/60_40big/fort.11", "Table"];*)
(*occDataFine = {Log10[#[[3]]], #[[1]], #[[2]]}&/@fineData12;*)
(*flucDataFine = {#[[1]], #[[6]]}&/@fineData10;*)
(*flowDataFine = {#[[1]], #[[2]]}&/@fineData11;*)
(*ovFlowData = Join[flowDataFine, flowDataRough];*)
(*ovFlucData = Join[flucDataFine, flucDataRough];*)
(*ovOccData = Join[occDataFine, occDataRough]*)


flucDataFine


(* ::Input:: *)
(*data*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*ListDensityPlot[ovOccData, PlotRange->{{-2, 2}, {0, 102}, {0.4, 1}}, InterpolationOrder->0, ColorFunction->(Blend[{{0, Purple}, {(0.5-0.4)/0.6, Blue},  {(0.7-0.4)/0.6, Green}, {(0.9-0.4)/0.6, Yellow}, {1, Red}}, #]&), FrameLabel->{{"Position", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", None}}, RotateLabel->True, Frame->True, PlotLegends->Automatic]*)
(*ListDensityPlot[ovOccData, PlotRange->{{-2, 2}, {0, 102}, {0.4, 1}}, InterpolationOrder->0, ColorFunction->"Rainbow", FrameLabel->{{"Position", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", None}}, RotateLabel->True, Frame->True, PlotLegends->Automatic]*)


(* ::Input:: *)
(*DensityPlot[x+y, {x, -1, 1}, {y, -1, 1}, ColorFunction->(Blend[{{0, Green}, {0.5, Blue}, {1, Red}}, #]&),  PlotLegends->Automatic]*)


ListPlot[ovFlucData, PlotRange->{{0, 0.6}, All}]
ListLogLogPlot[ovFlowData, PlotRange->{{0.01, 100}, {10^-7, 1}}]








ListDensityPlot[ovOccData]


roughData12


datVerySticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]<3*10^-2)&];
datQuiteSticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>0.249 && #[[3]]<0.251)&];
datSlightSticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>0.749 && #[[3]]<0.751)&];
datNeutral = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>0.99 && #[[3]]<1.01)&];
datUnsticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>2.742 && #[[3]]<2.744)&];
datQuiteUnsticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>10 && #[[3]]<11)&];
datSuperUnsticky = {#[[1]], #[[2]]}&/@Select[roughData12, (#[[3]]>70000)&];


ListLinePlot[{datVerySticky, datQuiteSticky, datSlightSticky, datNeutral, datUnsticky, datQuiteUnsticky, datSuperUnsticky}, PlotRange->{0, 1}, FrameLabel->{{"Average Occupation", None}, {"Position", None}}, RotateLabel->True,
Frame->True, PlotLegends->SwatchLegend[Automatic, {"\[Lambda] = 0.025", "\[Lambda] = 0.250", "\[Lambda] = 0.750", "\[Lambda] = 1", "\[Lambda] = 2.743", "\[Lambda] = 10.5", "\[Lambda] = 7.0\!\(\*SuperscriptBox[\(x10\), \(4\)]\)"}]]


datQuiteSticky


ListPlot[datSuperUnsticky]


ListLogLogPlot[ovFlucData, FrameLabel->{{"Density Fluctuation", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListPlot[ovFlucData, PlotRange->{{0, 1}, {0, 0.0045}}]



