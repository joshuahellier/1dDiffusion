(* ::Package:: *)

(* ::Input:: *)
(*loc="/home/jhell/research/results/batchJobs/concRuns/lambdaScan2/";*)
(*means2 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs2 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow2 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr2 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans2 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs2 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev2 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans2 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars2 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew2 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt2 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/lambdaScan3/";*)
(*means3 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs3 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow3 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr3 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans3 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs3 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev3 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans3 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars3 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew3 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt3 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/lambdaScan4/";*)
(*means4 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs4 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow4 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr4 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans4 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs4 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev4 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans4 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars4 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew4 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt4 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/lambdaScan5/";*)
(*means5 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs5 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow5 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr5 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans5 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs5 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev5 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans5 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars5 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew5 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt5 = Import[loc<>"flowKurt.dat", "Data"];*)
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));*)
(*A[rB_, rT_, z_]:=(6 (rB+rT)+(9 rB^3+rB^2 (-16+9 rT)+rB rT (-16+9 rT)+rT^2 (-16+9 rT)) z)/(12+12 (rB^2+rB (-2+rT)+(-2+rT) rT) z)*)


(* ::Input:: *)
(*ListPlot[{means2, means3, means4, means5}, PlotRange->{{0, 2},{0.2, 1}}, ImageSize->Large]*)
(*ListPlot[{errs2, errs3, errs4, errs5}, PlotRange->{{0, 2},All}, ImageSize->Large]*)
(*Show[{ListPlot[{flow2, flow3, flow4, flow5}, PlotRange->{{0, 2},{0, 0.008}}, ImageSize->Large, DataRange->{{0, 2}, All}], Plot[J[1, 0, 1-l]/64, {l, 0, 2}]}]*)
(*ListPlot[{flowErr2, flowErr3, flowErr4, flowErr5}, PlotRange->{{0, 2},{0, 200}}, ImageSize->Large]*)
(*ListPlot[{histMeans2, histMeans3, histMeans4, histMeans5}, PlotRange->{{0, 2},{0, 40}}, ImageSize->Large]*)
(*ListPlot[{histErrs2, histErrs3, histErrs4, histErrs5}, PlotRange->{{0, 2},{0, 1}}, ImageSize->Large]*)
(*ListPlot[{blockDev2, blockDev3, blockDev4, blockDev5}, PlotRange->{{0, 2},{-20, 5}}, ImageSize->Large]*)


Show[{ListPlot[{flowMeans2, flowMeans3, flowMeans4, flowMeans5}, PlotRange->{{0, 0.7}, {0, 0.005}}, ImageSize->Large, PlotLegends->True], Plot[{J[2/3, 2/3, 1-l]/64, J[3/4, 1/4, 1-l]/64, J[0.75, 0.58, 1-l]/64, J[1, 0, 1-l]/64}, {l, 0, 2}]}]
ListPlot[{flowVars2, flowVars3, flowVars4, flowVars5}, PlotRange->{{0, 0.7},  {0, 0.000005}}, ImageSize->Large]
ListPlot[{flowSkew2, flowSkew3, flowSkew4, flowSkew5}, PlotRange->{{0, 0.7}, {-1, 1}}, ImageSize->Large]
ListPlot[{flowKurt2, flowKurt3, flowKurt4, flowKurt5}, PlotRange->{{0, 0.7}, {0, 15}}, ImageSize->Large]














Show[ListPlot[{means2, means4, means3, means5}, PlotRange->{{0, 0.7},{0.2, 1}}, ImageSize->Medium, PlotLegends->False], FrameLabel->{{"Density", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[{ListPlot[{flowMeans2, flowMeans4, flowMeans3, flowMeans5}, PlotRange->{{0, 0.7}, {0, 0.005}}, ImageSize->Medium, PlotLegends->False, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], Plot[{J[2/3, 2/3, 1-l]/64, J[3/4, 0.58, 1-l]/64, J[0.75, 1/4, 1-l]/64, J[1, 0, 1-l]/64}, {l, 0, 0.7}]}]
ListPlot[{flowVars2, flowVars4, flowVars3, flowVars5}, PlotRange->{{0, 0.7},  {0, 0.00001}}, ImageSize->Medium, PlotLegends->False, FrameLabel->{{"Flow Rate Fluctuation/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
ListPlot[{flowSkew2, flowSkew4, flowSkew3, flowSkew5}, PlotRange->{{0, 0.7}, {-0.6, 0.6}}, ImageSize->Medium, PlotLegends->False, FrameLabel->{{"Flow Rate Skewness", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]






