(* ::Package:: *)

(* ::Input:: *)
(*gapEnd = {0, 0, 0, 0, 1, 3, 6, 11, 20, 36, 64, 113, 199};*)


(* ::Input:: *)
(*gapTable = Table[{i, gapEnd[[i]]}, {i, 1, 13}];*)
(*gapDivided = Table[{i, gapEnd[[i]]/(2^(i))}, {i, 1, 13}]*)


(* ::Input:: *)
(*Manipulate[Show[{ListLogPlot[gapTable], LogPlot[2^( a(x+b)), {x, 5, 13}]}], {a, 0.4, 1}, {b, -10, 10}]*)


(* ::Input:: *)
(*ListPlot[gapDivided]*)


(* ::Input:: *)
(*ListLogLogPlot[gapTable, PlotRange->{{8, 13}, All}]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*0.788*3.1*)


fileLoc = Table[Sort[Flatten[Import["/home/jhell/research/results/exactSolns/sysSizeDep/normalFlow2/"<>ToString[i]<>"/eigenvalues.dat"]], Greater], {i, 1, 13}];


ListLogPlot[fileLoc]


newFileLoc = Table[Table[{j, -fileLoc[[i]][[j]]}, {j, 1, Length[fileLoc[[i]]]}], {i, 1, 13}];


ListLogLogPlot[newFileLoc, PlotRange->{{0, 256}, {10^-6, 100}}, Joined->True]


eigs1 = Flatten[Import["/home/jhell/research/results/exactSolns/sysSizeDep/normalFlow2/5/eigenvalues.dat", "Data"]];
eigs2 = Flatten[Import["/home/jhell/research/results/exactSolns/eigSpecScan/mid/boundMult1000/5/0/eigenvalues.dat", "Data"]];


Sort[eigs1, Greater]
Sort[eigs2, Greater]


Needs["PolygonPlotMarkers`"]
fm[name_, size_: 3] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 3] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]


a=0.838;
b=-3.85;
Show[{ListLogPlot[gapTable, PlotRange->{{4, 14}, {1, 400}}, PlotMarkers->fm["Cross", 4.0], PlotStyle->Black], LogPlot[2^( a(x+b)), {x, 4, 14}, PlotStyle->Black]}, FrameLabel->{{"Bandwidth", None}, {"L", None}}, FrameLabel->True, Frame->True, ImageSize->1024]
