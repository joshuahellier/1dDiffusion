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
(*loc="/home/jhell/research/results/dim2Runs/narrowScan/lowDens/";*)
(*meanslRep = Import[loc<>"densMeans.dat", "Data"];*)
(*errslRep = Import[loc<>"densErrs.dat", "Data"];*)
(*flowlRep = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrlRep = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeanslRep = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarslRep = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewlRep = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtlRep = Import[loc<>"flowKurt.dat", "Data"];*)


ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh, flowMeanslRep}, PlotRange->{{10^-6, 10^6}, Automatic}]
ListLogPlot[{{#[[1]], Abs[#[[2]]]}&/@flowMeansl, {#[[1]], Abs[#[[2]]]}&/@flowMeanslRep}, PlotRange->{{0.01, 0.75}, {10^-6, 10^-1}}]
ListLogLogPlot[{flowVarsl, flowVarsm, flowVarsh, flowVarslRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{flowSkewl, flowSkewm, flowSkewh, flowSkewlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListPlot[{flowSkewl, flowSkewm, flowSkewh, flowSkewlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{flowKurtl, flowKurtm, flowKurth, flowKurtlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{meansl, meansm, meansh, meanslRep}, PlotRange->{{0.01, 10^4}, Automatic}]
ListLogLogPlot[{errsl, errsm, errsh, errslRep}, PlotRange->{{0.01, 10}, Automatic}]
ListPlot[{errsl, errsm, errsh, errslRep}, PlotRange->{{0.01, 0.6}, Automatic}]





fullFlowsl =Table[{flowMeansl[[i]][[1]], flowMeansl[[i]][[2]], Sqrt[flowVarsl[[i]][[2]]/256]}, {i, 1, Length[flowMeansl]}];
fullFlowslRep =Table[{flowMeanslRep[[i]][[1]], flowMeanslRep[[i]][[2]], Sqrt[flowVarslRep[[i]][[2]]/256]}, {i, 1, Length[flowMeanslRep]}];
fullFlowsm =Table[{flowMeansm[[i]][[1]], flowMeansm[[i]][[2]], Sqrt[flowVarsm[[i]][[2]]/256]}, {i, 1, Length[flowMeansm]}];
fullFlowsh =Table[{flowMeansh[[i]][[1]], flowMeansh[[i]][[2]], Sqrt[flowVarsh[[i]][[2]]/256]}, {i, 1, Length[flowMeansh]}];
Needs["ErrorBarPlots`"]
Needs["ErrorBarLogPlots`"]
ErrorListLogLogPlot[{fullFlowsl}, PlotRange->{10^-9, 10^12}]
ErrorListLogLogPlot[{fullFlowsl, fullFlowsm, fullFlowsh}, PlotRange->{{10^-2, 0.6}, {10^-6, 10^-1}}]



