(* ::Package:: *)

(* ::Input:: *)
(*loc="/home/jhell/research/results/batchJobs/concRuns/constDensSlice2/";*)
(*means1 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs1 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow1 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr1 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans1 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs1 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev1 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans1 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars1 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew1 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt1 = Import[loc<>"flowKurt.dat", "Data"];*)
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2))/64;*)


(* ::Input:: *)
(*ListDensityPlot[{Log10[#[[1]]], #[[2]], Log10[#[[3]]]}&/@flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{{-2, 0}, {0, 0.5}, {-7, -1}}, FrameLabel->{{"\[Delta]\[Rho]", "\!\(\*SubscriptBox[\(Log\), \(10\)]\)[E[J]/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)]"}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024]*)
(*ListDensityPlot[{Log10[#[[1]]], #[[2]], Log10[#[[3]]]}&/@flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow",  PlotLegends->True, PlotRange->{{-2, 0}, {0, 0.5}, {-9, 6}}, FrameLabel->{{"\[Delta]\[Rho]", "\!\(\*SubscriptBox[\(Log\), \(10\)]\)[Var[J]/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)]"}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024]*)
(*ListDensityPlot[{Log10[#[[1]]], #[[2]], #[[3]]}&/@means1, InterpolationOrder->0, ColorFunction->"Rainbow",  PlotLegends->True, PlotRange->{{-2, 0}, {0, 0.5}, Automatic}, FrameLabel->{{"\[Delta]\[Rho]", "Mean Particle Density"}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024]*)
(*ListDensityPlot[{Log10[#[[1]]], #[[2]], Log10[#[[3]]]}&/@histMeans1, InterpolationOrder->0, ColorFunction->"Rainbow",  PlotLegends->True, PlotRange->{{-2, 0}, {0, 0.5}, Automatic}, FrameLabel->{{"\[Delta]\[Rho]", "\!\(\*SubscriptBox[\(Log\), \(10\)]\)[E[Block Size]-1]"}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024]*)


Show[ListDensityPlot[{Log10[#[[1]]], #[[2]], #[[3]]}&/@means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium], FrameLabel->{{"\[Delta]\[Rho]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListDensityPlot[errs1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]
ListDensityPlot[histMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]
ListDensityPlot[histErrs1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{0, 10000}]
ListDensityPlot[blockDev1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]


Manipulate[Show[{ListDensityPlot[flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{-j, j}], ContourPlot[Sign[diff]J[2/3+diff, 2/3-diff, 1-l]/64==j, {l, 0, 0.6}, {diff, -0.33, 0.33}]}], {j, 10^-7, 0.01}]


ListContourPlot[flowMeans1, InterpolationOrder->1, ColorFunction->"Rainbow", PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", "Numerical Simulation"}}, RotateLabel->True, Frame->True, Contours->20, PlotRange->{-0.012, 0.012}, ImageSize->325, LabelStyle->Directive[Black]]
ListDensityPlot[flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate Variance/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->325, LabelStyle->Directive[Black]]
ListDensityPlot[flowSkew1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate Skewness"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->325, LabelStyle->Directive[Black]]
ListDensityPlot[means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, FrameLabel->{{"\[Delta]\[Rho]", "Observed Density"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->325, LabelStyle->Directive[Black]]
ContourPlot[J[0.5+d, 0.5-d, 1-l],  {l, 0, 0.75}, {d, -0.5, 0.5}, ColorFunction->"Rainbow", PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", "MFT Prediction"}}, RotateLabel->True, Frame->True, Contours->20, PlotRange->{-0.012, 0.012}, ImageSize->325, LabelStyle->Directive[Black]]





Show[{ListDensityPlot[flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium]}, FrameLabel->{{"\[Delta]\[Rho]", "Mean Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True], FrameLabel->{{"\[Delta]\[Rho]", "Flow Variance/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[flowSkew1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True], FrameLabel->{{"\[Delta]\[Rho]", "Flow Skewness"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium], FrameLabel->{{"\[Delta]\[Rho]", None}, {"\[Lambda]", "Density"}}, RotateLabel->True, Frame->True]



