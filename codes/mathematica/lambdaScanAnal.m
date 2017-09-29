(* ::Package:: *)

(* ::Input:: *)
(*loc="/home/s1373240/research/results/batchJobs/concRuns/lambdaScan2/";*)
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
(*loc="/home/s1373240/research/results/batchJobs/concRuns/lambdaScan3/";*)
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
(*J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));*)


(* ::Input:: *)
(*ListPlot[{means2, means3}, PlotRange->{{0, 2},{0.4, 1}}, ImageSize->Large]*)
(*ListPlot[{errs2, errs3}, PlotRange->{{0, 2},All}, ImageSize->Large]*)
(*Show[{ListPlot[{flow2, flow3}, PlotRange->{{0, 2},{0, 0.008}}, ImageSize->Large], Plot[J[3/4, 4/3 -3/4, 1-l]/64, {l, 0, 2}]}]*)
(*ListPlot[{flowErr2, flowErr3}, PlotRange->{{0, 2},{0, 200}}, ImageSize->Large]*)
(*ListPlot[{histMeans2, histMeans3}, PlotRange->{{0, 2},{0, 40}}, ImageSize->Large]*)
(*ListPlot[{histErrs2, histErrs3}, PlotRange->{{0, 2},{0, 1}}, ImageSize->Large]*)
(*ListPlot[{blockDev2, blockDev3}, PlotRange->{{0, 2},{-20, 5}}, ImageSize->Large]*)


ListPlot[{flowMeans2, flowMeans3}, PlotRange->{{0, 0.7}, {0, 0.004}}, ImageSize->Large]
ListPlot[{flowVars2, flowVars3}, PlotRange->{{0, 0.7}, {0, 10^-5}}, ImageSize->Large]
ListPlot[{flowSkew2, flowSkew3}, PlotRange->{{0, 0.7}, {-1, 0.4}}, ImageSize->Large]
ListPlot[{flowKurt2, flowKurt3}, PlotRange->{{0, 0.7}, {0, 15}}, ImageSize->Large]



