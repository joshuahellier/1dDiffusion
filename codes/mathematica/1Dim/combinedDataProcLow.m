(* ::Package:: *)

(* ::Input:: *)
(*(*Graeme stuff*)*)
(*fineData22 = Import["/home/jhell/research/results/graemeData/wholeBunch/30_10/fort.12", "Table"];*)
(*fineData20 = Import["/home/jhell/research/results/graemeData/wholeBunch/30_10/fort.10", "Table"];*)
(*fineData21 = Import["/home/jhell/research/results/graemeData/wholeBunch/30_10/fort.11", "Table"];*)
(*occDataFineLow = {Log10[#[[3]]], #[[1]], #[[2]]}&/@fineData22;*)
(*flucDataFineLow = {#[[1]], #[[6]]}&/@fineData20;*)
(*flowDataFineLow = {#[[1]], #[[2]]}&/@fineData21;*)


fineData32 = Import["/home/jhell/research/results/graemeData/wholeBunch/90_70/fort.12", "Table"];
fineData30 = Import["/home/jhell/research/results/graemeData/wholeBunch/90_70/fort.10", "Table"];
fineData31 = Import["/home/jhell/research/results/graemeData/wholeBunch/90_70/fort.11", "Table"];
occDataFineHigh = {Log10[#[[3]]], #[[1]], #[[2]]}&/@fineData32;
flucDataFineHigh = {#[[1]], #[[6]]}&/@fineData30;
flowDataFineHigh = {#[[1]], #[[2]]}&/@fineData31;


roughData12 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.12", "Table"];
roughData10 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.10", "Table"];
roughData11 = Import["/home/jhell/research/results/graemeData/75to25/size100/fort.11", "Table"];
occDataRough = {Log10[#[[3]]], #[[1]], #[[2]]}&/@roughData12;
flucDataRough = {#[[1]], #[[6]]}&/@roughData10;
flowDataRough = {#[[1]], #[[2]]}&/@roughData11;
fineData12 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.12", "Table"];
fineData10 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.10", "Table"];
fineData11 = Import["/home/jhell/research/results/graemeData/75to25/fineRes/fort.11", "Table"];
occDataFineMid = {Log10[#[[3]]], #[[1]], #[[2]]}&/@fineData12;
flucDataFineMid = {#[[1]], #[[7]]}&/@fineData10;
flowDataFineMid = {#[[1]], #[[2]]}&/@fineData11;


(* KMCStuff *)
loc ="/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideLow/";
meansl = Import[loc<>"densMeans.dat", "Data"];
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
J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));
loc = "/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideMid/";
meansm = Import[loc<>"densMeans.dat", "Data"];
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
loc = "/home/jhell/research/results/batchJobs/concRuns/wideSweep/wideHigh/";
meansh = Import[loc<>"densMeans.dat", "Data"];
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


(*Pure matrix stuff*)
lMin = 10^-3;
lMax = 10^3;
threshold = 10^-9;
numLambda = 2048;
numEigs = 1;
lDiff = (lMax - lMin)/numLambda;
bigL = 8;
topLevel = "/home/jhell/research/results/exactSolns/compScanRepeats/";
pwd = topLevel<>"low/";
cursLow = Table[{i, Flatten[Table[{Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[j+1]]]}, {j, 0, numEigs-1}], 1]}, {i, 0, numLambda-1}]
cursFilteredLow = Select[cursLow, ((Length[#[[2]][[1]]]>2) && (#[[2]][[2]]<threshold*Exp[(#[[1]]/numLambda)Log[lMax]+(1 - #[[1]]/numLambda)Log[lMin]]))&];
midCursLow = Table[{Exp[(cursFilteredLow[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredLow[[i]][[1]]/numLambda)Log[lMin]], cursFilteredLow[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFilteredLow]}];
absMidCursLow = Table[{Exp[(cursFilteredLow[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredLow[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFilteredLow[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFilteredLow]}];
pwd = topLevel<>"origMid/";
cursMid = Table[{i, Flatten[Table[{Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[j+1]]]}, {j, 0, numEigs-1}], 1]}, {i, 0, numLambda-1}]
cursFilteredMid = Select[cursMid, ((Length[#[[2]][[1]]]>2) && (#[[2]][[2]]<threshold*Exp[(#[[1]]/numLambda)Log[lMax]+(1 - #[[1]]/numLambda)Log[lMin]]))&];
midCursMid = Table[{Exp[(cursFilteredMid[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredMid[[i]][[1]]/numLambda)Log[lMin]], cursFilteredMid[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFilteredMid]}];
absMidCursMid = Table[{Exp[(cursFilteredMid[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredMid[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFilteredMid[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFilteredMid]}];
pwd = topLevel<>"high/";
cursHigh = Table[{i, Flatten[Table[{Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[j+1]]]}, {j, 0, numEigs-1}], 1]}, {i, 0, numLambda-1}]
cursFilteredHigh = Select[cursHigh, ((Length[#[[2]][[1]]]>2) && (#[[2]][[2]]<threshold*Exp[(#[[1]]/numLambda)Log[lMax]+(1 - #[[1]]/numLambda)Log[lMin]]))&];
midCursHigh = Table[{Exp[(cursFilteredHigh[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredHigh[[i]][[1]]/numLambda)Log[lMin]], cursFilteredHigh[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFilteredHigh]}];
absMidCursHigh = Table[{Exp[(cursFilteredHigh[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFilteredHigh[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFilteredHigh[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFilteredHigh]}];


ListLogLogPlot[midCursHigh]


pwd = "/home/jhell/research/results/exactSolns/compatScans/low/";
eigsLow = Table[{i, Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[1]]]}, {i, 0, numLambda-1}];
cursLow = Table[{i, Flatten[Table[{Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[j+1]]]}, {j, 0, numEigs-1}], 1]}, {i, 0, numLambda-1}]


cursLow[[3]][[2]][[2]]


Abs[Flatten[Import[pwd<>ToString[2]<>"/eigenvalues.dat", "Data"]][[1]]]


cursFilteredLow = Select[cursLow, ((Length[#[[2]][[1]]]>2) && (#[[2]][[2]]<threshold*Exp[(#[[1]]/numLambda)Log[lMax]+(1 - #[[1]]/numLambda)Log[lMin]]))&]



cursLow[[5]][[2]][[1]]


Show[{ListLogLogPlot[{{#[[1]], 100*#[[2]]*0.2}&/@flowDataFineLow, {#[[1]], 11*#[[2]]}&/@midCurs, {#[[1]], 64*#[[2]]}&/@flowMeansl}, PlotRange->{{0.01, 10}, {10^-7, 10}}], LogLogPlot[J[0.3, 0.1, 1-l], {l, 0.01, 10}]}]


Needs["PolygonPlotMarkers`"]


fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]
Show[{ListPlot[{{#[[1]], (bigL+1)*#[[2]]}&/@midCursLow, {#[[1]], (bigL+1)*#[[2]]}&/@midCursMid, {#[[1]], (bigL+1)*#[[2]]}&/@midCursHigh}, PlotRange->{{0.01*10^-2, 6*10^-1}, {10^-6, 3*10^-1}}, PlotMarkers->em["Circle", 1], Joined->True, PlotStyle->{Darker[Blue], Darker[Green],
Darker[Red]}, ImageSize->400], ListPlot[{{#[[1]], 100*#[[2]]*0.2}&/@flowDataFineLow, {#[[1]], 100*#[[2]]*0.5}&/@flowDataFineMid, {#[[1]], 100*#[[2]]*0.2}&/@flowDataFineHigh}, PlotMarkers->fm["Triangle", 2],
PlotStyle->{Darker[Blue], Darker[Green], Darker[Red]}], ListPlot[{{#[[1]], 64*#[[2]]}&/@flowMeansl, {#[[1]], 64*#[[2]]}&/@flowMeansm, {#[[1]], 64*#[[2]]}&/@flowMeansh}, PlotMarkers->fm/@{"DiagonalCross"}, PlotStyle->{Darker[Blue], Darker[Green],
Darker[Red]}],  Plot[{J[0.3, 0.1, 1-l], J[0.75, 0.25, 1-l], J[0.9, 0.7, 1-l]}, {l, 10^-4, 10^4}, PlotStyle->{{Darker[Blue], Dashed}, {Darker[Green], Dashed}, {Darker[Red], Dashed}},
PlotLegends->SwatchLegend[Automatic, {"(0.3, 0.1)", "(0.75, 0.25)", "(0.9, 0.7)"}]]}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


 LogLogPlot[{J[0.3, 0.1, 1-l], J[0.75, 0.25, 1-l], J[0.9, 0.7, 1-l]}, {l, 0.01, 10}]


PlotStyle->{Darker Blue, Darker Blue, Darker Blue, Darker Red, Darker Red, Darker Red, Darker Green, Darker Green, Darker Green}


flowDataFineHigh


ListLogLogPlot[{{#[[1]], 100*#[[2]]*0.2}&/@flowDataFineLow, {#[[1]], 100*#[[2]]*0.5}&/@flowDataFineMid, {#[[1]], 100*#[[2]]*0.2}&/@flowDataFineHigh}]


ListLogLogPlot[{#[[1]], 100*#[[2]]*0.2}&/@flowDataFineHigh]


Manipulate[Show[{ListLogLogPlot[midCursLow, PlotRange->{{10^-6, 10^6}, {0.5*10^-11, 10^(1)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.3, 0.1, 1-l]/10, {l, 10^-6, 10^6}, PlotRange->{10^-7, 10^4}, PlotStyle->{Black, Dashed}], LogLogPlot[{Exp[-a (Log[x] - b)], Exp[-c (Log[x] - d)]}, {x, 10^-6, 10^6}, PlotRange->{10^-16, 10^4}, PlotStyle->{{Red, Dotted}}]}], {{a, -1.01}, -3, 0}, {{b, 2.98}, 2, 7}, {{c, -4.1}, -5, -3} , {{d, -0.54}, -1, 1}]


pwd = "/home/jhell/research/results/exactSolns/compatScans/newMid/";
occMid = Table[{i, Flatten[Table[{Flatten[Import[pwd<>ToString[i]<>"/densVec"<>ToString[j]<>".dat", "Data"]], Abs[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[j+1]]]}, {j, 0, numEigs-1}], 1]}, {i, 0, numLambda-1}];
occFilteredMid = Select[occMid, ((Length[#[[2]][[1]]]>2) && (#[[2]][[2]]<threshold*Exp[(#[[1]]/numLambda)Log[lMax]+(1 - #[[1]]/numLambda)Log[lMin]]))&];
occsMid = Flatten[Table[Table[{Log[10, Exp[(occFilteredMid[[i]][[1]]/numLambda)Log[lMax]+(1 - occFilteredMid[[i]][[1]]/numLambda)Log[lMin]]], j, Abs[occFilteredMid[[i]][[2]][[1]][[j]]]}, {j, 1, bigL+4}], {i, 1, Length[occFilteredMid]}], 1];


occFilteredMid[[1]][[2]][[1]]


occsMid


ListDensityPlot[occsMid, PlotRange->{{-2, 2}, {3, 12}, {0.4, 1}}, InterpolationOrder->0, ColorFunction->(Blend[{{0, Purple}, {(0.5-0.4)/0.6, Blue},  {(0.7-0.4)/0.6, Green}, {(0.9-0.4)/0.6, Yellow}, {1, Red}}, #]&), FrameLabel->{{"Position", None}, {"\!\(\*SubscriptBox[\(Log\), \(10\)]\)[\[Lambda]]", None}}, RotateLabel->True, Frame->True, PlotLegends->Automatic]


N[occFilteredMid[[1]][[2]]]
