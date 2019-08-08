(* ::Package:: *)

location = "/home/jhell/research/results/thesisCorrectionData/diffCoeff/";
Ls = {"L32", "L64", "L128"};
minLambda = -2;
maxLambda = 1;
numLambda = 12;
numDensities = 24;
lambdas = Table[N[10^(minLambda*(1-l/(numLambda-1))+maxLambda*l/(numLambda-1)), 3], {l, 0, numLambda-1}];
diffCoeffData = Table[Import[location<>Ls[[i]]<>"/"<>ToString[j]<>"/overallData.dat", "Data"], {i, 1, 3}, {j, 0, numLambda-1}];
dCoeff[l_, r_] := 1+(1-l) r (-4+3 r);


currData =Select[Import[dataPlace<>"currSet.dat", "Data"],( Length[#]>1)&];
dataPlace = "/home/jhell/research/results/exactSolns/densityLambdaRuns/secondAttempt/";


lambdas


desiredLambdas = {0.00964388379154, 0.0199164806383, 0.0343109759068, 0.0647177815941, 0.122071469661, 0.230252696218, 0.434305446332, 0.819192234495, 1.54517039269, 2.9145192568, 5.4974018001, 10.3692663829};


Length[desiredLambdas]


Length[lambdas]


matLambdas = DeleteDuplicates[Table[currData[[i]][[1]], {i, 1, Length[currData]}]]


selectedData = Table[{#[[2]], 5*Abs[#[[3]]]}&/@Select[currData, Abs[#[[1]]-desiredLambdas[[i]]]<10^-4&], {i, 1, Length[desiredLambdas]}];


ListPlot[Table[10*selectedData[[i]], {i, 1, numLambda}]]


Needs["ErrorBarPlots`"]
(*Needs["ErrorBarLogPlots`"]*)
Needs["PolygonPlotMarkers`"]
fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}];
markerSize = 7;
bottomLambda = 3;
topLambda = numLambda;
plottingFns[r_]:= Table[{dCoeff[lambdas[[l]], r]}, {l, bottomLambda, topLambda}]
Show[{Plot[Evaluate[plottingFns[r]], {r, 0, 1}, ImageSize->1024, PlotRange->{0.001, 10}],
ListPlot[Table[selectedData[[i]], {i, bottomLambda, topLambda}]],
ErrorListPlot[Table[diffCoeffData[[1]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Circle", markerSize], PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@Part[lambdas, bottomLambda;;topLambda]]],
ErrorListPlot[Table[diffCoeffData[[2]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Square", markerSize]], 
ErrorListPlot[Table[diffCoeffData[[3]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Triangle", markerSize]]}, FrameLabel->{{"D(\[Rho])", None}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]


plottingFns[r]


Plot[plottingFns[r], {r, 0, 1}, PlotStyle->None]
