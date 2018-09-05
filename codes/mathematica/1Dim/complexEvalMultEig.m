(* ::Package:: *)

(* ::Input:: *)
(*numL = 13;*)
(*minL = 1;*)
(*pwd = "/home/jhell/research/results/exactSolns/sysSizeDep/normalFlow2/";*)
(*eigsMid = Table[ Flatten[ToExpression[StringReplace[{"j"..->"I", "e"..->"*10^"}]/@Import[pwd<>ToString[i]<>"/fullEigenvalues.dat", "Data"]//."j"->"I"]], {i, minL, numL}];*)
(*eigsReal = Table[Sort[ Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]], Greater], {i, minL, numL}];*)
(**)


(* ::Input:: *)
(*eigsFilteredMid = Select[eigsMid,(Length[#]>2)&];*)


(* ::Input:: *)
(*numEigs = 4*32;*)
(*numSucc = Length[eigsMid];*)
(*eigTableMid = Table[Table[{Log10[-Re[eigsMid[[i]][[n]]]], Im[eigsMid[[i]][[n]]]} ,{i, 2,numSucc}], {n, 1, numEigs}];*)


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


eigsMid[[8]]
eigTableMid[[8]]


ListPlot[eigTableMid, PlotRange->All]


ListPlot[Log10[Abs[eigsReal]], PlotLegends->SwatchLegend[Automatic], PlotRange->{{190, 210}, {-10, 4}}, Joined->True]
