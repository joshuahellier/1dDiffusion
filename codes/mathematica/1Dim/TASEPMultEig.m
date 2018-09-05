(* ::Package:: *)

(* ::Input:: *)
(*minDiff = 10^-3;*)
(*maxVal = 1.5;*)
(*numLambda = 2048;*)
(*lDiff = (maxVal - 2*minDiff)/(numLambda-1);*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/TASEP/largeReInitialCut/";*)
(*j=I;*)
(*eigsMid = Table[{N[lDiff*i+minDiff], Flatten[ToExpression[StringReplace[{"j"..->"I", "e"..->"*10^"}]/@Import[pwd<>ToString[i]<>"/fullEigenvalues.dat", "Data"]//."j"->"I"]]}, {i, 0, numLambda-1}];*)


(* ::Input:: *)
(*eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];*)


eigsFilteredMid


importExample = Import[pwd<>ToString[0]<>"/fullEigenvalues.dat", "Data"]


StringReplace["j"..->"I"]/@importExample


(* ::Input:: *)
(*numEigs = 8;*)
(*numSucc = Length[eigsFilteredMid];*)
(*eigTableMid = Table[Table[{Re[eigsFilteredMid[[i]][[2]][[n]]], Im[eigsFilteredMid[[i]][[2]][[n]]]} ,{i, 1,numSucc}], {n, 1, numEigs}];*)


eigTableMid


(* ::Input:: *)
(*linPlotEigTable = Table[Table[{Log10[eigsFilteredMid[[i]][[1]]], Abs[eigsFilteredMid[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];*)


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
(*Show[ListLogLogPlot[flattenedEigs, PlotRange->{{1*10^-2, 1*10^2}, Automatic}, PlotMarkers->fm["Circle", 0.5], Joined->False, PlotStyle->{Black}, ImageSize->1200], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]*)


Show[ListPlot[flattenedEigs, PlotRange->{{0, 1.5}, {-1.5, -0.4}}, PlotMarkers->fm["Circle", 0.5], Joined->False, PlotStyle->{Black}, ImageSize->400], FrameLabel->{{"Eigenvalue/ \[Lambda]", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


ListPlot[eigTableMid, PlotRange->All]
