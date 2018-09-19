(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-3*)
(*lMax = 10^3;*)
(*numLambda = 2048;*)
(*numEigs = 1;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/compScanRepeats/newMid/";*)
(*dataMid = Table[{Log10[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], Flatten[Import[pwd<>ToString[i]<>"/minProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/oneProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/maxProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/groundEntropy.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/currVec0.dat", "Data"]][[5]]}, {i, 0, numLambda-1}];*)
(*dataFiltered = Select[dataMid,( Abs[#[[5]]]<10^-8)&];*)
(*minProdMid = {#[[1]], #[[2]]}&/@dataFiltered;*)
(*oneProdMid = {#[[1]], #[[3]]}&/@dataFiltered;*)
(*maxProdMid = {#[[1]], #[[4]]}&/@dataFiltered;*)
(*eigsMid = {#[[1]], #[[5]]}&/@dataFiltered;*)
(*entropyMid = {#[[1]], #[[6]]}&/@dataFiltered;*)
(*currentMid = {#[[1]], #[[7]]}&/@dataFiltered;*)
(*dataMid = {};*)


pwd = "/home/jhell/research/results/exactSolns/compScanRepeats/low/";
dataMid = Table[{Log10[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], Flatten[Import[pwd<>ToString[i]<>"/minProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/oneProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/maxProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/groundEntropy.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/currVec0.dat", "Data"]][[5]]}, {i, 0, numLambda-1}];
dataFiltered = Select[dataMid,( Abs[#[[5]]]<10^-8)&];
minProdLow = {#[[1]], #[[2]]}&/@dataFiltered;
oneProdLow = {#[[1]], #[[3]]}&/@dataFiltered;
maxProdLow = {#[[1]], #[[4]]}&/@dataFiltered;
eigsLow = {#[[1]], #[[5]]}&/@dataFiltered;
entropyLow = {#[[1]], #[[6]]}&/@dataFiltered;
currentLow = {#[[1]], #[[7]]}&/@dataFiltered;
dataLow = {};


pwd = "/home/jhell/research/results/exactSolns/compScanRepeats/high/";
dataMid = Table[{Log10[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], Flatten[Import[pwd<>ToString[i]<>"/minProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/oneProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/maxProd.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/groundEntropy.dat", "Data"]][[1]], Flatten[Import[pwd<>ToString[i]<>"/currVec0.dat", "Data"]][[5]]}, {i, 0, numLambda-1}];
dataFiltered = Select[dataMid,( Abs[#[[5]]]<10^-8)&];
minProdHigh = {#[[1]], #[[2]]}&/@dataFiltered;
oneProdHigh = {#[[1]], #[[3]]}&/@dataFiltered;
maxProdHigh = {#[[1]], #[[4]]}&/@dataFiltered;
eigsHigh = {#[[1]], #[[5]]}&/@dataFiltered;
entropyHigh = {#[[1]], #[[6]]}&/@dataFiltered;
currentHigh = {#[[1]], #[[7]]}&/@dataFiltered;
dataHigh = {};


(* ::Input:: *)
(**)


Show[{ListLogPlot[{minProdLow, oneProdLow, maxProdLow, entropyLow}, PlotRange->{10^-6, 1}]}]
 ListLogPlot[currentHigh, PlotRange->All]


squareSum = Table[{minProdLow[[i]][[1]], oneProdLow[[i]][[2]]+maxProdLow[[i]][[2]]}, {i, 1, Length[minProdLow]}];
ListPlot[squareSum]


Show[{ListLogPlot[{minProdLow, oneProdLow, maxProdLow, entropyLow}, PlotRange->{10^-8, 1}, PlotLegends->SwatchLegend[{"1/25", "1", "25", "entropy"}]], ListLogPlot[ currentLow, PlotStyle->{Black}, PlotRange->All]}]
ListLogPlot[currentLow, PlotStyle->{Black}, PlotRange->All]
Show[{ListLogPlot[{minProdMid, oneProdMid, maxProdMid, entropyMid}, PlotRange->{10^-8, 1}, PlotLegends->SwatchLegend[{"1/25", "1", "25", "entropy"}]], ListLogPlot[ currentMid, PlotStyle->{Black}, PlotRange->All]}]
Show[{ListLogPlot[{minProdHigh, oneProdHigh, maxProdHigh, entropyHigh}, PlotRange->{10^-8, 1}, PlotLegends->SwatchLegend[{"1/25", "1", "25", "entropy"}]], ListLogPlot[ currentHigh, PlotStyle->{Black}, PlotRange->All]}]


{#[[1]], Log10 #[[2]]}&/@currentLow


Show[{ListPlot[{minProdHigh, oneProdHigh, maxProdHigh, entropyHigh}, PlotRange->All]}]
 ListLogPlot[currentHigh, PlotRange->All]


dataMid[[509]][[5]][[1]]


(* ::Input:: *)
(*entsProperlyFilteredMid = {#[[1]], #[[2]][[1]][[1]]}&/@entsFilteredMid;*)
(*entTableMid = Table[Table[{entsFilteredMid[[i]][[1]], Abs[entsFilteredMid[[i]][[2]][[n]]]} ,{i, 1, Length[entsFilteredMid]}], {n, 1, numEigs}];*)


(* ::Input:: *)
(*pwd = "/home/jhell/research/results/exactSolns/compScanRepeats/low/";*)
(*entsLow = Table[{Log10[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], Import[pwd<>ToString[i]<>"/groundEntropy.dat", "Data"]}, {i, 0, numLambda-1}];*)
(*entsFilteredLow = Select[entsLow,(Length[#[[2]]]>0)&];*)
(*entsProperlyFilteredLow = {#[[1]], #[[2]][[1]][[1]]}&/@entsFilteredLow;*)
(*entTableLow = Table[Table[{entsFilteredLow[[i]][[1]], Abs[entsFilteredLow[[i]][[2]][[n]]]} ,{i, 1, Length[entsFilteredLow]}], {n, 1, numEigs}];*)


pwd = "/home/jhell/research/results/exactSolns/compScanRepeats/high/";
entsHigh = Table[{Log10[Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]]], Import[pwd<>ToString[i]<>"/groundEntropy.dat", "Data"]}, {i, 0, numLambda-1}];
entsFilteredHigh = Select[entsHigh,(Length[#[[2]]]>0)&];
entsProperlyFilteredHigh = {#[[1]], #[[2]][[1]][[1]]}&/@entsFilteredHigh;
entTableHigh = Table[Table[{entsFilteredHigh[[i]][[1]], Abs[entsFilteredHigh[[i]][[2]][[n]]]} ,{i, 1, Length[entsFilteredHigh]}], {n, 1, numEigs}];


(* ::Input:: *)
(*eigsFilteredLow = Select[eigsLow,(Length[#[[2]]]>2)&];*)
(*eigTableLow = Table[Table[{eigsFilteredLow[[i]][[1]], Abs[eigsFilteredLow[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredLow]}], {n, 1, numEigs}];*)
(*upperEigsLow = Flatten[Table[eigTableLow[[i+1]], {i, 1, numEigs-1}], 1];*)
(*pwd = "/home/jhell/research/results/exactSolns/compatScans/high/";*)
(*eigsHigh = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFilteredHigh = Select[eigsHigh,(Length[#[[2]]]>2)&];*)
(*eigTableHigh = Table[Table[{eigsFilteredHigh[[i]][[1]], Abs[eigsFilteredHigh[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFilteredHigh]}], {n, 1, numEigs}];*)
(*upperEigsHigh = Flatten[Table[eigTableHigh[[i+1]], {i, 1, numEigs-1}], 1];*)


entsMid


ListLogLogPlot[entsMid]


entsProperlyFilteredMid


ListPlot[{entsProperlyFilteredMid, entsProperlyFilteredLow, entsProperlyFilteredHigh}, PlotRange->{{-3, 3}, All}]
