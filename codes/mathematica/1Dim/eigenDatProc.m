(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-6;*)
(*lMax = 10^6;*)
(*numLambda = 1024;*)
(*numEigs = 2;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/compatScans/newMid/";*)
(*eigsMid = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFilteredMid = Select[eigsMid,(Length[#[[2]]]>2)&];*)
(*eigTableMid = Table[Table[{eigsFilteredMid[[i]][[1]], Abs[eigsFilteredMid[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredMid]}], {n, 1, numEigs}];*)
(*upperEigsMid = Flatten[Table[eigTableMid[[i+1]], {i, 1, numEigs-1}], 1];*)
(*pwd = "/home/jhell/research/results/exactSolns/compatScans/low/";*)
(*eigsLow = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFilteredLow = Select[eigsLow,(Length[#[[2]]]>2)&];*)
(*eigTableLow = Table[Table[{eigsFilteredLow[[i]][[1]], Abs[eigsFilteredLow[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredLow]}], {n, 1, numEigs}];*)
(*upperEigsLow = Flatten[Table[eigTableLow[[i+1]], {i, 1, numEigs-1}], 1];*)
(*pwd = "/home/jhell/research/results/exactSolns/compatScans/high/";*)
(*eigsHigh = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFilteredHigh = Select[eigsHigh,(Length[#[[2]]]>2)&];*)
(*eigTableHigh = Table[Table[{eigsFilteredHigh[[i]][[1]], Abs[eigsFilteredHigh[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredHigh]}], {n, 1, numEigs}];*)
(*upperEigsHigh = Flatten[Table[eigTableHigh[[i+1]], {i, 1, numEigs-1}], 1];*)


eigsFilteredMid


eigsFilteredMid[[2]][[2]][[1]]


cutoff = 10^-6;
veryFilteredMid = {#[[1]], #[[1]]/Piecewise[{{-#[[2]][[1]], Abs[#[[2]][[1]]]>cutoff*#[[1]]}}, -#[[2]][[2]]]}&/@eigsFilteredMid;
veryFilteredLow = {#[[1]], #[[1]]/Piecewise[{{-#[[2]][[1]], Abs[#[[2]][[1]]]>cutoff*#[[1]]}}, -#[[2]][[2]]]}&/@eigsFilteredLow;
veryFilteredHigh = {#[[1]], #[[1]]/Piecewise[{{-#[[2]][[1]], Abs[#[[2]][[1]]]>cutoff*#[[1]]}}, -#[[2]][[2]]]}&/@eigsFilteredHigh;


Flatten[eigTableMid, 1]


Needs["PolygonPlotMarkers`"]
fm[name_, size_: 3] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 3] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]


Show[ListLogLogPlot[{veryFilteredLow, veryFilteredMid, veryFilteredHigh}, PlotRange->{{2*10^-3, 1*10^3}, {4*10^0, 4*10^1}}, PlotMarkers->fm["Circle", 3], Joined->False, PlotStyle->{{Darker[Blue], Opacity[0.7]}, {Darker[Green], Opacity[0.7]},
{Darker[Red], Opacity[0.7]}}, ImageSize->1200, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}]], FrameLabel->{{"\[Lambda]\[Times]Relaxation Time/s", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]


eigsRatio = Table[{eigTable[[1]][[i]][[1]], eigTable[[2]][[i]][[2]]/eigTable[[1]][[i]][[2]]}, {i, 1, Length[eigsFiltered]}];


ListLogLogPlot[eigsRatio, PlotRange->{10^9, 10^14}]


ListLogLogPlot[{eigTable[[1]], eigTable[[2]]}]


dens = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/densVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];
densFiltered = Select[dens, (Length[#[[2]][[1]]]>2)&];
densTable = Table[Flatten[Table[Table[{densFiltered[[i]][[1]], k, densFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+4}], {i, 1, Length[densFiltered]}], 1], {j, 1, numEigs}];
botDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[2]]}, {i, 1, Length[densFiltered]}];
topDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+3]]}, {i, 1, Length[densFiltered]}];
botDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[1]]}, {i, 1, Length[densFiltered]}];
topDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+4]]}, {i, 1, Length[densFiltered]}];


curs = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];
cursFiltered = Select[curs, (Length[#[[2]][[1]]]>2)&];
cursTable = Table[Flatten[Table[Table[{cursFiltered[[i]][[1]], k, cursFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+3}], {i, 1, Length[cursFiltered]}], 1], {j, 1, numEigs}];
midCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFiltered]}];
absMidCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFiltered]}];


relaxTime = {#[[1]], 1/#[[2]]}&/@eigTable[[2]];


ListLogLogPlot[eigTable, PlotRange->{10^-7, 10^4}, PlotLegends->True]
ListLogLogPlot[{eigTable[[1]], eigTable[[2]]}]


ListLogLogPlot[]


dens[[319]]
dens[[320]]


densFiltered[[1]]


densTable[[1]]


ListDensityPlot[densTable[[1]], InterpolationOrder->0, PlotRange->{0.25, 1.01}]


ListDensityPlot[cursTable[[1]], PlotRange->All, InterpolationOrder->0]


J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));
Manipulate[Show[{ListLogLogPlot[midCurs, PlotRange->{{10^-6, 10^6}, {10^-16, 10^(4)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.75, 0.25, 1-l]/10, {l, 10^-6, 10^6}, PlotRange->{10^-7, 10^4}, PlotStyle->{Black, Dashed}], LogLogPlot[{Exp[-a (Log[x] - b)], Exp[-c (Log[x] - d)]}, {x, 10^-6, 10^6}, PlotRange->{10^-16, 10^4}, PlotStyle->{{Red, Dotted}}]}], {{a, -1}, -3, 0}, {{b, 4.68}, 3, 7}, {{c, -4.1}, -5, -3} , {{d, -0.1}, -1, 1}]
ListLogLogPlot[absMidCurs]
ListLogLogPlot[botDensOut, PlotRange->{0.01, 1}]
ListLogLogPlot[botDensIn, PlotRange->{0.01, 1.0}]
ListLogLogPlot[topDensIn, PlotRange->{0.01, 1.0}]
ListLogLogPlot[topDensOut, PlotRange->{0.01, 1.0}]





midCurs[[64]]


Needs["PolygonPlotMarkers`"]
fm[name_, size_: 3] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 3] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]
Show[{ListLogLogPlot[relaxTime, PlotMarkers->em["Circle", 0], Joined->True , FrameLabel->{{"Relative Equilibration Time/s", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True]}]
