(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-4;*)
(*lMax = 10^4;*)
(*numLambda = 2048;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*numEigs = 32;*)


(* ::Input:: *)
(*pwd = "/home/jhell/research/results/exactSolns/eigSpecScan/mid/boundMult100/5/";*)
(*eigsMid = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];*)
(*eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];*)
(*numSucc = Length[eigsFilteredMid];*)
(*eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];*)
(*linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];*)
(*finEigs100l5 = Flatten[eigTableMid, 1];*)


pwd = "/home/jhell/research/results/exactSolns/eigSpecScan/mid/boundMult100/10/";
eigsMid = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFilteredMid];
eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];
finEigs100l10 = Flatten[eigTableMid, 1];


pwd = "/home/jhell/research/results/exactSolns/eigSpecScan/mid/boundMult1000/5/";
eigsMid = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFilteredMid];
eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];
finEigs1000l5 = Flatten[eigTableMid, 1];



pwd = "/home/jhell/research/results/exactSolns/eigSpecScan/mid/boundMult1000/10/";
eigsMid = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFilteredMid];
eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];
finEigs1000l10 = Flatten[eigTableMid, 1];


(* ::Input:: *)
(*Needs["PolygonPlotMarkers`"]*)
(*fm[name_, size_: 3] := *)
(* Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];*)
(*em[name_, size_: 3] := *)
(* Graphics[{Dynamic@*)
(*    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], *)
(*      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, *)
(*  AlignmentPoint -> {0, 0}]*)


(* ::Input:: *)
(*Show[ListLogLogPlot[{finEigs100l5, finEigs100l10, finEigs1000l5, finEigs1000l10}, PlotRange->{{1*10^-4, 1*10^4}, {5*10^-2, 1*10^2}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Blue, Green, Red, Black}, ImageSize->400, PlotLegends->SwatchLegend[Automatic, {"L=5, b=100", "L=10, b=100", "L=5, b=1000", "L=10, b=1000"}]], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)


Show[ListPlot[linPlotEigTable, PlotRange->{{-3.5, 3}, {0, 5}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Black}, ImageSize->400], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


Show[ListLogLogPlot[{finEigs100l10, finEigs1000l10}, PlotRange->{{1*10^-4, 1*10^4}, {5*10^-2, 1*10^2}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Red, Green}, ImageSize->1200, PlotLegends->SwatchLegend[Automatic, {"L=5, b=100", "L=5, b=1000"}]], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
