(* ::Package:: *)

dataLoc = "/home/jhell/research/results/thesisCorrectionData/concRepeats/";
sizes = {"L32", "L64", "L128"};
actualSizes = {32, 64, 128};
densities = {"low", "mid", "high"};
flowMeans = Table[Import[dataLoc<>sizes[[j]]<>"/"<>densities[[i]]<>"/flowMeans.dat", "Data"], {i, 1, 3}, {j, 1, 3}];
flowVars = Table[Import[dataLoc<>sizes[[j]]<>"/"<>densities[[i]]<>"/flowVars.dat", "Data"], {i, 1, 3}, {j, 1, 3}];


flowErrMeans = Table[{Log10[flowMeans[[i]][[j]][[k]][[1]]], Log10[flowMeans[[i]][[j]][[k]][[2]]*actualSizes[[j]]], Abs[1+Sqrt[flowVars[[i]][[j]][[k]][[2]]/10000]/(Abs[flowMeans[[i]][[j]][[k]][[2]]]*actualSizes[[j]])]}, {i, 1, 3}, {j, 1, 3}, {k, 1, Length[flowMeans[[i]][[j]]]}];


N[Log[10]]


J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));


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
Show[{ErrorListPlot[Table[flowErrMeans[[j]][[1]], {j, 1, 3}], PlotMarkers->fm["Circle", markerSize], PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24, Black]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}],
ImageSize->1024, PlotRange->{{-2, 1}, {-6, 0.5}}],
ErrorListPlot[Table[flowErrMeans[[j]][[2]], {j, 1, 3}],  PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotMarkers->fm["Square", markerSize]],
ErrorListPlot[Table[flowErrMeans[[j]][[3]], {j, 1, 3}],  PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}, PlotMarkers->fm["Triangle", markerSize]],
Plot[{Log10[J[0.3, 0.1, 1-10^l]], Log10[J[0.6, 0.4, 1-10^l]], Log10[J[0.9, 0.7, 1-10^l]]}, {l, -4, 4}, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}]},  
FrameLabel->{{Style["\!\(\*SubscriptBox[\(Log\), \(10\)]\) J\[Times]L", Black], None}, {Style["\!\(\*SubscriptBox[\(Log\), \(10\)]\) \[Lambda]", Black], None}}, RotateLabel->True, Frame->True]


errorplot//InputForm
