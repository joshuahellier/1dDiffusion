(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-3;*)
(*lMax = 10^3;*)
(*numLambda = 2048;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*numEigs = 64;*)


(* ::Input:: *)
(*pwd = "/home/jhell/research/results/exactSolns/spectrumTop/b100/L5/";*)
(*eigs = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];*)
(*eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];*)
(*numSucc = Length[eigsFiltered];*)
(*eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];*)
(*linPlotEigTable = Table[Table[{Log10[eigsFiltered[[i]][[1]]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];*)
(*finEigsb100l5 = Flatten[eigTable, 1];*)


pwd = "/home/jhell/research/results/exactSolns/spectrumTop/b1000/L5/";
eigs = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFiltered];
eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFiltered[[i]][[1]]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];
finEigsb1000l5 = Flatten[eigTable, 1];


pwd = "/home/jhell/research/results/exactSolns/spectrumTop/b100/L10/";
eigs = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFiltered];
eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFiltered[[i]][[1]]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];
finEigsb100l10 = Flatten[eigTable, 1];


pwd = "/home/jhell/research/results/exactSolns/spectrumTop/b1000/L10/";
eigs = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];
eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];
numSucc = Length[eigsFiltered];
eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];
linPlotEigTable = Table[Table[{Log10[eigsFiltered[[i]][[1]]], Abs[eigsFiltered[[i]][[2]][[n]]]/eigsFiltered[[i]][[1]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];
finEigsb1000l10 = Flatten[eigTable, 1];


(* ::Input:: *)
(*Needs["PolygonPlotMarkers`"]*)
(*fm[name_, size_: 3] := *)
(* Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];*)
(*em[name_, size_: 3] := *)
(* Graphics[{Dynamic@*)
(*    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], *)
(*      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, *)
(*  AlignmentPoint -> {0, 0}]*)


SetOptions[ListLogLogPlot, BaseStyle -> FontSize -> 24];
SetOptions[SwatchLegend, BaseStyle -> FontSize -> 24];


(* ::Input:: *)
(*Show[ListLogLogPlot[{finEigsb100l5, finEigsb100l10, finEigsb1000l5, finEigsb1000l10}, PlotRange->{{1*10^-3, 1*10^3},Automatic}, PlotMarkers->fm["Circle", 1.0], Joined->False, PlotStyle->{Blue, Green, Black, Red}, ImageSize-> 2048, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"L=5, b=100", "L=10, b=100", "L=5, b=1000", "L=10, b=1000"}]], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)


Show[ListPlot[linPlotEigTable, PlotRange->{{-3.5, 3}, {0, 5}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Black}, ImageSize->400], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


Show[ListLogLogPlot[{finEigs100l10, finEigs1000l10}, PlotRange->{{1*10^-4, 1*10^4}, {5*10^-2, 1*10^2}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Red, Green}, ImageSize->1200, PlotLegends->SwatchLegend[Automatic, {"L=5, b=100", "L=5, b=1000"}]], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


Show[ListLogLogPlot[{finEigs100l5, finEigs100l10}, PlotRange->{{1*10^-4, 1*10^4}, {5*10^-2, 1*10^2}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Darker[Red], Lighter[Blue]}, ImageSize->600, PlotLegends->SwatchLegend[Automatic, {"L=5, b=100", "L=10, b=100"}]], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
