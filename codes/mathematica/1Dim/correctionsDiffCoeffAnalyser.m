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
bottomLambda = 1;
topLambda = numLambda;
plottingFns[r_]:= Table[{dCoeff[lambdas[[l]], r]}, {l, bottomLambda, topLambda}]
Show[{Plot[Evaluate[plottingFns[r]], {r, 0, 1}, ImageSize->1024, PlotRange->{0.001, 15}], 
ErrorListPlot[Table[diffCoeffData[[1]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Circle", markerSize], PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@Part[lambdas, bottomLambda;;topLambda]]],
ErrorListPlot[Table[diffCoeffData[[2]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Square", markerSize]], 
ErrorListPlot[Table[diffCoeffData[[3]][[i]], {i, bottomLambda, topLambda}], PlotMarkers->fm["Triangle", markerSize]]}, FrameLabel->{{"D(\[Rho])", None}, {"\[Rho]", None}}, RotateLabel->True, Frame->True]


plottingFns[r]


Plot[plottingFns[r], {r, 0, 1}, PlotStyle->None]
