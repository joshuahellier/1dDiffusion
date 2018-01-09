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
(*ListDensityPlot[flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]*)
(*ListDensityPlot[flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True]*)
(*ListDensityPlot[flowSkew1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True]*)
(*ListDensityPlot[flowKurt1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True]*)


Show[ListDensityPlot[means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium], FrameLabel->{{"\[Delta]\[Rho]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListDensityPlot[errs1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]
ListDensityPlot[histMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]
ListDensityPlot[histErrs1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{0, 10000}]
ListDensityPlot[blockDev1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic]


Manipulate[Show[{ListDensityPlot[flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->{-j, j}], ContourPlot[Sign[diff]J[2/3+diff, 2/3-diff, 1-l]/64==j, {l, 0, 0.6}, {diff, -0.33, 0.33}]}], {j, 10^-7, 0.01}]


ListContourPlot[flowMeans1, InterpolationOrder->1, ColorFunction->"Rainbow", PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, Contours->20, PlotRange->{-0.012, 0.012}]
ListDensityPlot[flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate Variance/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListDensityPlot[flowSkew1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate Skewness"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListDensityPlot[means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, FrameLabel->{{"\[Delta]\[Rho]", "Observed Density"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ContourPlot[J[0.5+d, 0.5-d, 1-l],  {l, 0, 0.75}, {d, -0.5, 0.5}, ColorFunction->"Rainbow", PlotLegends->True, FrameLabel->{{"\[Delta]\[Rho]", "Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, Contours->20, PlotRange->{-0.012, 0.012}]





Show[{ListDensityPlot[flowMeans1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium]}, FrameLabel->{{"\[Delta]\[Rho]", "Mean Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[flowVars1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True], FrameLabel->{{"\[Delta]\[Rho]", "Flow Variance/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[flowSkew1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotRange->Automatic, PlotLegends->True], FrameLabel->{{"\[Delta]\[Rho]", "Flow Skewness"}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListDensityPlot[means1, InterpolationOrder->0, ColorFunction->"Rainbow", PlotLegends->True, PlotRange->Automatic, ImageSize->Medium], FrameLabel->{{"\[Delta]\[Rho]", None}, {"\[Lambda]", "Density"}}, RotateLabel->True, Frame->True]



