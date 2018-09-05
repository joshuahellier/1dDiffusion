(* ::Package:: *)

(* ::Input:: *)
(*gapEnd = {0, 0, 0, 0, 3, 5, 8, 13, 22, 38, 66, 115, 201};*)


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
