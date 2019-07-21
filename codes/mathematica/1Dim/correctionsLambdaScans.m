(* ::Package:: *)

dataLoc = "/home/jhell/research/results/thesisCorrectionData/concRepeats/";
sizes = {"L32", "L64", "L128"};
actualSizes = {32, 64, 128};
densities = {"low", "mid", "high"};
flowMeans = Table[Import[dataLoc<>sizes[[j]]<>"/"<>densities[[i]]<>"/flowMeans.dat", "Data"], {i, 1, 3}, {j, 1, 3}];
flowVars = Table[Import[dataLoc<>sizes[[j]]<>"/"<>densities[[i]]<>"/flowVars.dat", "Data"], {i, 1, 3}, {j, 1, 3}];


flowErrMeans = Table[{flowMeans[[i]][[j]][[k]][[1]], flowMeans[[i]][[j]][[k]][[2]], flowVars[[i]][[j]][[k]][[2]]}, {i, 1, 3}, {j, 1, 3}, {k, 1, Length[flowMeans[[i]][[j]]]}];


flowVars[[1]][[1]]


Needs["ErrorBarLogPlots`"];
Needs["PolygonPlotMarkers`"];
fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}];
markerSize = 7;
Show[Table[ErrorListLogLogPlot[Table[{#[[1]], #[[2]]*actualSizes[[i]], Sqrt[#[[3]]*actualSizes[[i]]/10000]}&/@flowErrMeans[[j]][[i]], {j, 1, 3}]], {i, 1, 3}]]


errorplot//InputForm
