(* ::Package:: *)

(* ::Input:: *)
(*loc = "/home/jhell/research/results/feb2018ImageRecast/";*)
(*indices = {4, 2, 3, 1};*)
(*otherIndices = {0, 1, 3};*)


(* ::Input:: *)
(*temporalData = Table[Import[loc<>ToString[indices[[i]]]<>"/"<>ToString[otherIndices[[j]]]<>"/typeStats.dat", "Data"], {i, 1, 4}, {j, 1, 3}]*)


(* ::Input:: *)
(*ls = {"0p05", "0p15", "0p35"};*)
(*Ts = {"1p32", "1p0", "8p0", "32p0"};*)
(**)


(* ::Input:: *)
(*Table[Export["/home/jhell/research/writingsPhD/actualThesis/numerics/images/stickyParticleFlows/flowImpL"<>ls[[j]]<>"T"<>Ts[[i]]<>".png",  ArrayPlot[(1-#)&/@temporalData[[i]][[j]], PlotRange->{0, 1}, ImageSize->{1024, 1024}, Frame->None]], {i, 1, 4}, {j, 1, 3}]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Log[\[Lambda]]*)


(* ::Input:: *)
(*entries = Table[" & \includegraphics[width=0.6\linewidth]{numerics/images/stickyParticleFlows/flowImpL"<>ls[[j]]<>"T"<>Ts[[i]]<>".png}", {i, 1, 4}, {j, 1, 3}]*)


StringJoin[Table[StringJoin[entries[[j]]]<>" \\\\ ", {j, 1, 4}]]
