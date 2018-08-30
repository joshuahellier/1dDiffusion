(* ::Package:: *)

(* ::Input:: *)
(*(*Graeme's data*)*)
(*roughData12 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.12", "Table"];*)
(*roughData10 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.10", "Table"];*)
(*roughData11 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.11", "Table"];*)
(*occDataRough = {Log10[#[[3]]], #[[1]], #[[2]]}&/@roughData12;*)
(*flucDataRough = {#[[1]], #[[6]]}&/@roughData10;*)
(*flowDataRough = {#[[1]], #[[2]]}&/@roughData11;*)
(*fineData12 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.12", "Table"];*)
(*fineData10 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.10", "Table"];*)
(*fineData11 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.11", "Table"];*)
(*occDataFine = {Log10[#[[3]]], #[[1]], #[[2]]}&/@fineData12;*)
(*flucDataFine = {#[[1]], #[[7]]}&/@fineData10;*)
(*flowDataFine = {#[[1]], #[[2]]}&/@fineData11;*)
(*ovFlowData = Join[flowDataFine, flowDataRough];*)
(*ovFlucData = Join[flucDataFine, flucDataRough];*)


(*KMC stuff*)
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
J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));


(* ::Input:: *)
(*(*Pure matrix stuff*)*)
(*lMin = 10^-6;*)
(*lMax = 10^6;*)
(*numLambda = 1024;*)
(*numEigs = 5;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/compatScans/origMid/";*)
(*eigs = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];*)
(*eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];*)
(**)
(*dens = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/densVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];*)
(*densFiltered = Select[dens, (Length[#[[2]][[1]]]>2)&];*)
(*densTable = Table[Flatten[Table[Table[{densFiltered[[i]][[1]], k, densFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+4}], {i, 1, Length[densFiltered]}], 1], {j, 1, numEigs}];*)
(*botDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[2]]}, {i, 1, Length[densFiltered]}];*)
(*topDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+3]]}, {i, 1, Length[densFiltered]}];*)
(*botDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[1]]}, {i, 1, Length[densFiltered]}];*)
(*topDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+4]]}, {i, 1, Length[densFiltered]}];*)
(**)
(*curs = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];*)
(*cursFiltered = Select[curs, (Length[#[[2]][[1]]]>2)&];*)
(*cursTable = Table[Flatten[Table[Table[{cursFiltered[[i]][[1]], k, cursFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+3}], {i, 1, Length[cursFiltered]}], 1], {j, 1, numEigs}];*)
(*midCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFiltered]}];*)
(*absMidCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFiltered]}];*)


(* ::Input:: *)
(*Show[{ListLogLogPlot[{{#[[1]], 100*#[[2]]*0.5}&/@ovFlowData, {#[[1]], 11*#[[2]]}&/@midCurs, {#[[1]], 64*#[[2]]}&/@flowMeansm}, PlotRange->{{0.01, 100}, {0.5*10^-7, 100}}, PlotLegends->SwatchLegend[Automatic, {"Metropolis-Hastings", "Transition Rate Matrix", "KMC"}]], LogLogPlot[J[0.75, 0.25, 1-l], {l, 0.01, 100}, PlotStyle->{Black, Dashed}]}]*)


Show[{ListPlot[{{#[[1]], 100*#[[2]]*0.5}&/@ovFlowData, {#[[1]], 11*#[[2]]}&/@midCurs, {#[[1]], 64*#[[2]]}&/@flowMeansm}, PlotRange->{{0.01, 10}, {10^-7, 10}}], Plot[J[0.75, 0.25, 1-l], {l, 0.01, 100}]}]


Show[{ListPlot[{{#[[1]], 100*#[[2]]*0.5}&/@ovFlowData, {#[[1]], 11*#[[2]]}&/@midCurs, {#[[1]], 64*#[[2]]}&/@flowMeansm}, PlotRange->{{0.0, 1.0}, {-0.01, 0.5}}, PlotLegends->Automatic], Plot[J[0.75, 0.25, 1-l], {l, 0.00, 1.0}]}]


Manipulate[Show[{ListLogLogPlot[midCurs, PlotRange->{{10^-3, 10^2}, {0.5*10^-11, 10^(1)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.75, 0.25, 1-l]/10, {l, 10^-6, 10^6}, PlotRange->{10^-7, 10^4}, PlotStyle->{Black, Dashed}], LogLogPlot[{Exp[-a (Log[x] - b)], Exp[-c (Log[x] - d)]}, {x, 10^-6, 10^6}, PlotRange->{10^-16, 10^4}, PlotStyle->{{Red, Dotted}}]}], {{a, -1.01}, -3, 0}, {{b, 2.98}, 2, 7}, {{c, -4.1}, -5, -3} , {{d, -0.54}, -1, 1}]


a=-1.01; b=2.98; c=-4.15 ;d=-0.55;
Show[{ListLogLogPlot[midCurs, PlotRange->{{10^-3, 10^2}, {0.5*10^-11, 10^(1)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.75, 0.25, 1-l]/10, {l, 10^-6, 10^6}, PlotRange->{10^-7, 10^4}, PlotStyle->Black], LogLogPlot[{Exp[-a (Log[x] - b)], Exp[-c (Log[x] - d)]}, {x, 10^-6, 10^6}, PlotRange->{10^-16, 10^4}, PlotStyle->{{Red, Dotted}}]}]
