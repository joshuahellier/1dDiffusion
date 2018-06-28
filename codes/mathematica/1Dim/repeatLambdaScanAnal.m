(* ::Package:: *)

(* ::Input:: *)
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
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan3Repeats/size32/";*)
(*means332 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs332 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow332 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr332 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans332 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs332 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev332 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans332 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars332 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew332 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt332 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan3Repeats/size128/";*)
(*means3128 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs3128 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow3128= Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr3128 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans3128 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs3128 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev3128 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans3128 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars3128 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew3128 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt3128 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan3Repeats/size256/";*)
(*means3256 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs3256 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow3256 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr3256 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans3256 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs3256 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev3256 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans3256 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars3256 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew3256 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt3256 = Import[loc<>"flowKurt.dat", "Data"];*)


(* ::Input:: *)
(*Needs["ErrorBarPlots`"]*)
(*Needs["ErrorBarLogPlots`"]*)
(*fullFlows332 =Table[{flowMeans332[[i]][[1]], 1/2flowMeans332[[i]][[2]], 1/2Sqrt[flowVars332[[i]][[2]]/10000]}, {i, 1, Length[flowMeans332]}];*)
(*fullFlows364 =Table[{flowMeans3[[i]][[1]], flowMeans3[[i]][[2]], Sqrt[flowVars3[[i]][[2]]/10000]}, {i, 1, Length[flowMeans3]}];*)
(*fullFlows3128 =Table[{flowMeans3128[[i]][[1]], 2flowMeans3128[[i]][[2]], 2Sqrt[flowVars3128[[i]][[2]]/10000]}, {i, 1, Length[flowMeans3128]}];*)
(*fullFlows3256 =Table[{flowMeans3256[[i]][[1]], 4flowMeans3256[[i]][[2]], 4Sqrt[flowVars3256[[i]][[2]]/10000]}, {i, 1, Length[flowMeans3256]}];*)
(*Show[ErrorListLogLogPlot[{fullFlows332, fullFlows364, fullFlows3128, fullFlows3256}, PlotRange->{{0.04, 0.25}, {10^-6, 0.01}}, PlotLegends-> SwatchLegend[{"32", "64", "128", "256"}]], FrameLabel->{{"Normalized Flow Rate/s", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)
(*Show[ErrorListPlot[{fullFlows332, fullFlows364, fullFlows3128, fullFlows3256}, PlotRange->{{0.04, 0.25}, {10^-6, 0.00125}}, PlotLegends-> SwatchLegend[{"32", "64", "128", "256"}]], FrameLabel->{{"Normalized Flow Rate/s", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)
(*ListLogLogPlot[{{#[[1]], 1/2 #[[2]]}&/@flowMeans332, flowMeans3, {#[[1]], 2#[[2]]}&/@flowMeans3128, {#[[1]], 4#[[2]]}&/@flowMeans3256}, PlotLegends->True, PlotRange->{{0, 0.25}, {0, 0.0015}}]*)
(*ListPlot[{{#[[1]], 1  #[[2]]}&/@flowVars332, flowVars3, {#[[1]],1 #[[2]]}&/@flowVars3128, {#[[1]], 1 #[[2]]}&/@flowVars3256}, PlotLegends->True, PlotRange->{{0, 0.25}, {0, 0.00002}}]*)
(*Show[ListPlot[{{#[[1]], 1 #[[2]]}&/@means332, means3, {#[[1]],1#[[2]]}&/@means3128, {#[[1]], 1#[[2]]}&/@means3256}, PlotLegends->SwatchLegend[{"32", "64", "128", "256"}], PlotRange->{{0, 0.25}, {0.5, 1}}], FrameLabel->{{"Density", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)


(* ::Input:: *)
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
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan4Repeats/size32/";*)
(*means432 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs432 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow432 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr432 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans432 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs432 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev432 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans432 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars432 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew432 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt432 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan4Repeats/size128/";*)
(*means4128 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs4128 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow4128= Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr4128 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans4128 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs4128 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev4128 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans4128 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars4128 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew4128 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt4128 = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/batchJobs/concRuns/newLambdaScans/lambdaScan4Repeats/size256/";*)
(*means4256 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs4256 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow4256 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr4256 = Import[loc<>"rateErrs.dat", "Data"];*)
(*histMeans4256 = Import[loc<>"histMeans.dat", "Data"];*)
(*histErrs4256 = Import[loc<>"histErrs.dat", "Data"];*)
(*blockDev4256 = Import[loc<>"blockDev.dat", "Data"];*)
(*flowMeans4256 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars4256 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew4256 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt4256 = Import[loc<>"flowKurt.dat", "Data"];*)


(* ::Input:: *)
(*ListPlot[{{#[[1]], 1/2 #[[2]]}&/@flowMeans432, flowMeans4, {#[[1]], 2#[[2]]}&/@flowMeans4128, {#[[1]], 4#[[2]]}&/@flowMeans4256}, PlotLegends->True, PlotRange->{{0, 0.25}, {-0.00005, 0.00035}}]*)
(*ListLogLogPlot[{{#[[1]], 1/2 #[[2]]}&/@flowMeans432, flowMeans4, {#[[1]], 2#[[2]]}&/@flowMeans4128, {#[[1]], 4#[[2]]}&/@flowMeans4256}, PlotLegends->True, PlotRange->Automatic]*)
(*ListPlot[{{#[[1]], 1  #[[2]]}&/@flowVars432, flowVars4, {#[[1]],1 #[[2]]}&/@flowVars4128, {#[[1]], 1 #[[2]]}&/@flowVars4256}, PlotLegends->True, PlotRange->{{0, 0.25}, {0, 0.00002}}]*)
(*ListPlot[{{#[[1]], 1 #[[2]]}&/@means432, means4, {#[[1]],1#[[2]]}&/@means4128, {#[[1]], 1#[[2]]}&/@means4256}, PlotLegends->True, PlotRange->{{0, 0.25}, {0, 1}}]*)


loc="/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideLow/";
meansl= Import[loc<>"densMeans.dat", "Data"];
errsl = Import[loc<>"densErrs.dat", "Data"];
flowl = Import[loc<>"rateMeans.dat", "Data"];
flowErrl = Import[loc<>"rateErrs.dat", "Data"];
histMeansl = Import[loc<>"histMeans.dat", "Data"];
histErrsl = Import[loc<>"histErrs.dat", "Data"];
blockDevl = Import[loc<>"blockDev.dat", "Data"];
flowMeansl = Import[loc<>"flowMeans.dat", "Data"];
flowVarsl = Import[loc<>"flowVars.dat", "Data"];
flowSkewl = Import[loc<>"flowSkew.dat", "Data"];
flowKurtl = Import[loc<>"flowKurt.dat", "Data"];
loc="/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideMid/";
meansm= Import[loc<>"densMeans.dat", "Data"];
errsm = Import[loc<>"densErrs.dat", "Data"];
flowm = Import[loc<>"rateMeans.dat", "Data"];
flowErrm = Import[loc<>"rateErrs.dat", "Data"];
histMeansm = Import[loc<>"histMeans.dat", "Data"];
histErrsm = Import[loc<>"histErrs.dat", "Data"];
blockDevm = Import[loc<>"blockDev.dat", "Data"];
flowMeansm = Import[loc<>"flowMeans.dat", "Data"];
flowVarsm = Import[loc<>"flowVars.dat", "Data"];
flowSkewm = Import[loc<>"flowSkew.dat", "Data"];
flowKurtm = Import[loc<>"flowKurt.dat", "Data"];
loc="/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideHigh/";
meansh= Import[loc<>"densMeans.dat", "Data"];
errsh = Import[loc<>"densErrs.dat", "Data"];
flowh = Import[loc<>"rateMeans.dat", "Data"];
flowErrh = Import[loc<>"rateErrs.dat", "Data"];
histMeansh = Import[loc<>"histMeans.dat", "Data"];
histErrsh = Import[loc<>"histErrs.dat", "Data"];
blockDevh = Import[loc<>"blockDev.dat", "Data"];
flowMeansh = Import[loc<>"flowMeans.dat", "Data"];
flowVarsh = Import[loc<>"flowVars.dat", "Data"];
flowSkewh = Import[loc<>"flowSkew.dat", "Data"];
flowKurth = Import[loc<>"flowKurt.dat", "Data"];


J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));
Show[{ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh}, PlotRange->{{10^-3, 10^3}, {10^-8, 10^4}},  PlotLegends->True], LogLogPlot[J[0.75, 0.25, 1-l]/64, {l, 10^-3, 10^3}]}]
ListPlot[{{Log10[#[[1]]], #[[2]]}&/@flowMeansl, {Log10[#[[1]]], #[[2]]}&/@flowMeansm, {Log10[#[[1]]], #[[2]]}&/@flowMeansh}, PlotRange->{{-3, 6}, {-5, 5}}]
ListLogLogPlot[{flowVarsl, flowVarsm, flowVarsh}, PlotRange->{{0.001, 10^6}, All}]

ListLogLogPlot[{flowSkewl, flowSkewm, flowSkewh}, PlotRange->{{0.001, 10^6}, All}]
ListPlot[{{Log10[#[[1]]], #[[2]]}&/@flowSkewl, {Log10[#[[1]]], #[[2]]}&/@flowSkewm, {Log10[#[[1]]], #[[2]]}&/@flowSkewh}, PlotRange->{{-3, 6}, {-5, 5}}]
ListLogLogPlot[{flowKurtl, flowKurtm, flowKurth}, PlotRange->{{0.001, 10^6}, All}]
ListPlot[{{Log10[#[[1]]], #[[2]]}&/@flowKurtl, {Log10[#[[1]]], #[[2]]}&/@flowKurtm, {Log10[#[[1]]], #[[2]]}&/@flowKurth}, PlotRange->{{-3, 6}, {-2, 10}}]
ListLogLogPlot[{meansl, meansm, meansh}, PlotRange->{{0.001, 10^6}, {0.15, 1}}]
Show[ListLogLogPlot[{errsl, errsm, errsh}, PlotRange->{{0.001, 10^6}, {0.001, 1}}], FrameLabel->{{"Standard Error in Density", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[ListPlot[{{1/#[[1]], #[[2]]}&/@errsl, {1/#[[1]], #[[2]]}&/@errsm, {1/#[[1]], #[[2]]}&/@errsh}, PlotRange->{{0, 40}, {0, 0.3}}], FrameLabel->{{"Standard Error in Density", None}, {"1/\[Lambda]", None}}, RotateLabel->True, Frame->True]


Manipulate[{Show[{ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh}, PlotRange->{{0.01, 10^3}, {10^-8, 10^2}},  PlotLegends->True], LogLogPlot[{Exp[a (Log[x] - b)], Exp[c (Log[x] - d)]}, {x, 0.01, 10^3}]}],  N[Exp[(a b -c d)/(a-c)]]}, {{a, 1}, 0, 5}, {{b, 4.72}, -2, 12}, {{c, 4.63}, 0.1, 5}, {{d, -0.87}, -2, 6}]


Manipulate[Show[{ListLogLogPlot[flowMeansl, PlotRange->{{10^-3, 10^6}, {10^-7, 10^5}}], LogLogPlot[1/(Exp[a (Log[x] - b)]+Exp[c (Log[x] - d)]),{x, 10^-3, 10^6}, PlotRange->{10^-7, 10^5}, PlotStyle->Red]}], {{a, -1.05}, -3, 0}, {{b, 4.7}, 3, 7}, {{c, -3.9}, -6, -3} , {{d, 0}, -1, 1}]


Exp[4.6/-3]


Manipulate[LogLogPlot[Exp[a x+b], {x, 10^-3, 10^3}], {a, -2, 2}, {b, 2, -2}]


Needs["ErrorBarPlots`"]
Needs["ErrorBarLogPlots`"]
flowErrs3 = (Sqrt[#[[2]]/10000]) & /@ flowVars3;
fullFlows =Table[{flowMeans3[[i]][[1]], flowMeans3[[i]][[2]], flowErrs3[[i]]}, {i, 1, Length[flowMeans3]}];
ErrorListLogLogPlot[fullFlows, PlotRange->{{10^-2, 10^0}, {10^-7, 10^(-2)}}]
Manipulate[Show[{ErrorListPlot[fullFlows, PlotRange->{{10^-2, 10^0}, {10^-7, 10^(-2)}}], Plot[1/(Exp[a (Log[x] - b)]+Exp[c (Log[x] - d)]),{x, 10^-2, 10^0}, PlotRange->{10^-7, 10^0}, PlotStyle->Red]}], {{a, -1.05}, -3, 0}, {{b, 4.7}, 3, 7}, {{c, -3.9}, -6, -3} , {{d, 0}, -1, 1}]





flowErrs3


Needs["ErrorBarPlots`"]
Needs["ErrorBarLogPlots`"]
flowErrsm = (Sqrt[#[[2]]/10000]) & /@ flowVarsm;
fullFlowsm =Table[{flowMeansm[[i]][[1]], flowMeansm[[i]][[2]], flowErrsm[[i]]}, {i, 1, Length[flowMeansm]}];
Manipulate[Show[{ErrorListLogLogPlot[fullFlowsm, PlotRange->{{10^-2, 10^3}, {10^-7, 10^(2)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.75, 0.25, 1-l]/64, {l, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}, PlotStyle->{Black, Dashed}], LogLogPlot[1/(Exp[a (Log[x] - b)]+Exp[c (Log[x] - d)]),{x, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}, PlotStyle->{{Red, Dotted}}]}], {{a, -1}, -3, 0}, {{b, 4.68}, 3, 7}, {{c, -4.1}, -5, -3} , {{d, -0.1}, -1, 1}]


LogLogPlot[J[0.75, 0.25, 1-l]/64,{x, 10^-3, 10^3}, PlotRange->{10^-7, 10^0}, PlotStyle->Blue]


FullSimplify[N[J[0.75, 0.25, 1-l]/64]]


(* ::InheritFromParent:: *)
(*1/64 (0.5` -0.59375` (1-l))*)


z = 1-l;
b = 3/4;
t = 1/4;
FullSimplify[((b-t) + z(b^3-t^3+2t^2-2b^2))]


N[Log[19/(32*64)]]


{{a, -1.05}, -3, 0}, {{b, 4.7}, 3, 7}


a = -1; b = 4.68; c = -4.1 ; d= -0.1;
N[Exp[(a b -c d)/(a-c)]]
Show[{ErrorListLogLogPlot[fullFlowsm, PlotRange->{{10^-2, 10^3}, {10^-7, 10^(2)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, PlotStyle->Smaller], LogLogPlot[J[0.75, 0.25, 1-l]/64, {l, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}], LogLogPlot[Exp[-a (Log[x] - b)],{x, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}, PlotStyle->{{Black, Dotted}}], LogLogPlot[Exp[-c (Log[x] - d)],{x, 10^-2, 0.3}, PlotRange->{10^-7, 10^2}, PlotStyle->{{Black, Dotted}}]}]





a=-1.05; b = 4.7; c = -4.4; d = -0.3;
(*Show[{ErrorListLogLogPlot[fullFlowsm, PlotRange->{{10^-2, 10^3}, {10^-7, 10^(2)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.75, 0.25, 1-l]/64, {l, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}, PlotStyle->{Black, Dashed}], LogLogPlot[1/(Exp[a (Log[x] - b)]+Exp[c (Log[x] - d)]),{x, 10^-2, 10^3}, PlotRange->{10^-7, 10^2}, PlotStyle->{{Red, Dotted}}]}]*)
Show[ListLogLogPlot[{meansl, meansm, meansh}, PlotRange->{{10^-1, 10^0}, {0.19, 1}}], FrameLabel->{{"Particle Density", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
Show[{ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh}, PlotRange->{{10^-3, 10^6}, {10^-7, 10^4}}], LogLogPlot[{J[0.5, 0.3, 1-l]/64, J[0.75, 0.25, 1-l]/64, J[0.9, 0.7, 1-l]/64}, {l, 10^-3, 10^6}]}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]








graemeFlow = Import["/home/jhell/Downloads/StickyParticles/100/fort.11", "Table"];
graemeFlowData = {#[[1]], #[[2]]}&/@graemeFlow;


ListLogLogPlot[{graemeFlowData, flowMeansm}]
