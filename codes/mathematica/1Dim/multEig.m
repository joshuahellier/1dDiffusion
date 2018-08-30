(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-4;*)
(*lMax = 10^4;*)
(*numLambda = 2048;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/bigEigSpecScan/2048/";*)
(*eigsMid = Table[{N[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], N[Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]]}, {i, 0, numLambda-1}];*)


(* ::Input:: *)
(*eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];*)


(* ::Input:: *)
(*numEigs = 1024;*)
(*numSucc = Length[eigsFilteredMid];*)
(*eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1,numSucc}], {n, 1, numEigs}];*)


(* ::Input:: *)
(*linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]/eigsFilteredMid[[i]][[1]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];*)


(* ::Input:: *)
(*flattenedEigs = Flatten[eigTableMid, 1]*)


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
(*Show[ListLogLogPlot[flattenedEigs, PlotRange->{{1*10^-2, 1*10^2}, {5*10^-2, 1*10^2}}, PlotMarkers->fm["Circle", 0.5], Joined->False, PlotStyle->{Black}, ImageSize->1200], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)


Show[ListPlot[linPlotEigTable, PlotRange->{{-3.5, 3}, {0, 5}}, PlotMarkers->fm["Circle", 0.3], Joined->False, PlotStyle->{Black}, ImageSize->400], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]
