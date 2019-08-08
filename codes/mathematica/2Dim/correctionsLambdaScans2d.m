(* ::Package:: *)

dataLoc1 = "/home/jhell/research/results/thesisCorrectionData/2Dim/";
dataLoc2 = "/home/jhell/research/results/dim2Runs/longerScans/";
sizes = {"L32", "L64"};
actualSizes = {32, 64};
numSites = {32*32, 64*64};
densities1 = {"low", "mid", "high"};
densities2 = {"low", "mid", "high"};
runLengths = {10000, 4096}
flowMeans1 = Table[Import[dataLoc1<>densities1[[i]]<>"/flowMeans.dat", "Data"], {i, 1, 3}];
flowVars1 = Table[Import[dataLoc1<>densities1[[i]]<>"/flowVars.dat", "Data"], {i, 1, 3}];
densMeans1 = Table[Import[dataLoc1<>densities1[[i]]<>"/densMeans.dat", "Data"], {i, 1, 3}];
densErrs1 = Table[Import[dataLoc1<>densities1[[i]]<>"/densErrs.dat", "Data"], {i, 1, 3}];
flowMeans2 = Table[Import[dataLoc2<>densities2[[i]]<>"/flowMeans.dat", "Data"], {i, 1, 3}];
flowVars2 = Table[Import[dataLoc2<>densities2[[i]]<>"/flowVars.dat", "Data"], {i, 1, 3}];
densMeans2 = Table[Import[dataLoc2<>densities2[[i]]<>"/densMeans.dat", "Data"], {i, 1, 3}];
densErrs2 = Table[Import[dataLoc2<>densities2[[i]]<>"/densErrs.dat", "Data"], {i, 1, 3}];
flowMeans = {flowMeans2, flowMeans1};
flowVars = {flowVars2, flowVars1};
densMeans = {densMeans2, densMeans1};
densErrs = {densErrs2, densErrs1};





flowErrMeans = Table[{Log10[flowMeans[[i]][[j]][[k]][[1]]], Log10[flowMeans[[i]][[j]][[k]][[2]]], Abs[Sqrt[flowVars[[i]][[j]][[k]][[2]]/runLengths[[i]]]/(Abs[flowMeans[[i]][[j]][[k]][[2]]]*Log[10])]}, {i, 1, 2}, {j, 1, 3}, {k, 1, Length[flowMeans[[i]][[j]]]}];


filteredFlowErrMeans = Table[Select[flowErrMeans[[i]][[j]], #[[3]]>0 And Im[#[[2]]]==0&], {i, 1, 2}, {j, 1, 3}];


decParams = {4, 2};


decFlowMeans = Table[filteredFlowErrMeans[[i]][[j]][[k*decParams[[i]]]], {i, 1, 2}, {j, 1, 3}, {k, 1, Floor[Length[filteredFlowErrMeans[[i]][[j]]]/decParams[[i]]]}];


N[Log[10]]


J[b_, t_, z_]:= -1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));


Needs["ErrorBarPlots`"];
Needs["PolygonPlotMarkers`"];
fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}];
markerSize = 5;
Show[{ErrorListPlot[Table[decFlowMeans[[1]][[j]], {j, 1, 3}], PlotMarkers->fm["Diamond", markerSize], PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24, Black]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}],
ImageSize->1024, PlotRange->{{-2, 1}, {-8, 2.3}}],
ErrorListPlot[Table[decFlowMeans[[2]][[j]], {j, 1, 3}],  PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotMarkers->fm["x", markerSize]],
Plot[{Log10[J[0.3, 0.1, 1-10^l]], Log10[J[0.6, 0.4, 1-10^l]], Log10[J[0.9, 0.7, 1-10^l]]}, {l, -2, 1}, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}]},  
FrameLabel->{{Style["\!\(\*SubscriptBox[\(Log\), \(10\)]\) J", Black], None}, {Style["\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", Black], None}}, RotateLabel->True, Frame->True]


densErrMeans = Table[{Log10[densMeans[[i]][[j]][[k]][[1]]], densMeans[[i]][[j]][[k]][[2]], Sqrt[densErrs[[i]][[j]][[k]][[2]]/(runLengths[[i]]*numSites[[i]])]}, {i, 1, 2}, {j, 1, 3}, {k, 1, Length[densMeans[[i]][[j]]]}];
filteredDensErrMeans = Table[Select[densErrMeans[[i]][[j]], #[[3]]>0 And Im[#[[2]]]==0&], {i, 1, 2}, {j, 1, 3}];
decParams = {2, 3};
decDensMeans = Table[filteredDensErrMeans[[i]][[j]][[k*decParams[[i]]]], {i, 1, 2}, {j, 1, 3}, {k, 1, Floor[Length[filteredDensErrMeans[[i]][[j]]]/decParams[[i]]]}];


markerSize = 6;
Show[{ErrorListPlot[Table[decDensMeans[[1]][[j]], {j, 1, 3}], PlotMarkers->fm["Diamond", markerSize], PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24, Black]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}],
ImageSize->1024, PlotRange->{{-1.5, 1}, {0.15, 1}}],
ErrorListPlot[Table[decDensMeans[[2]][[j]], {j, 1, 3}],  PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotMarkers->fm["x", markerSize]]},  
FrameLabel->{{Style["\[Rho]", Black], None}, {Style["\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", Black], None}}, RotateLabel->True, Frame->True]
