(* ::Package:: *)

(* ::Input:: *)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/lowDens/";*)
(*meansl = Import[loc<>"densMeans.dat", "Data"];*)
(*errsl = Import[loc<>"densErrs.dat", "Data"];*)
(*flowl = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrl = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansl = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsl = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewl = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtl = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/midDens/";*)
(*meansm = Import[loc<>"densMeans.dat", "Data"];*)
(*errsm = Import[loc<>"densErrs.dat", "Data"];*)
(*flowm = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrm = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansm = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsm = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewm = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtm = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/highDens/";*)
(*meansh = Import[loc<>"densMeans.dat", "Data"];*)
(*errsh = Import[loc<>"densErrs.dat", "Data"];*)
(*flowh = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrh = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansh = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsh = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewh = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurth = Import[loc<>"flowKurt.dat", "Data"];*)


ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh}, PlotRange->{{0.01, 10}, {10^-6, 10^4}}]
ListLogLogPlot[{flowVarsl, flowVarsm, flowVarsh}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{meansl, meansm, meansh}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{errsl, errsm, errsh}, PlotRange->{{0.01, 10}, Automatic}]



