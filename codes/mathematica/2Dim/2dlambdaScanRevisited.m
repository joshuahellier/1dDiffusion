(* ::Package:: *)

(* ::Input:: *)
(*J[b_, t_, z_]:= -1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));*)
(*loc="/home/jhell/research/results/dim2Runs/longEqCloseLook/";*)
(*sizes1 = {"8x8/", "16x16/", "16x64/", "32x32/", "32x64/", "64x32/", "64x16/" ,"64x64/"};*)
(*aspRat1 = {1, 1, 1/4, 1, 1/2, 2, 4, 1};*)
(*densAdj = {((8)*(8+4))/(8*8), ((16)*(16+4))/(16*16), ((16)*(64+4))/(16*64), ((32)*(32+4))/(32*32), ((32)*(64+4))/(32*64), ((64)*(32+4))/(64*32), ((64)*(16+4))/(64*16), ((64)*(64+4))/(64*64)}*)
(*fns[l_] := Table[aspRat1[[index]] J[0.75, 0.25, 1-l], {index, 1, 8}]; *)
(*max = 8;*)
(*means1 = Table[{#[[1]], #[[2]]*densAdj[[index]]}&/@Import[loc<>sizes1[[index]]<>"densMeans.dat", "Data"], {index, 1, max}];*)
(*errs1 = Table[Import[loc<>sizes1[[index]]<>"densErrs.dat", "Data"], {index, 1, max}];*)
(*flow1 = Table[Import[loc<>sizes1[[index]]<>"rateMeans.dat", "Data"], {index, 1, max}];*)
(*flowErr1 = Table[Import[loc<>sizes1[[index]]<>"rateErrs.dat", "Data"], {index, 1, max}];*)
(*flowMeans1 = Table[{#[[1]], #[[2]]/aspRat1[[index]]}&/@Import[loc<>sizes1[[index]]<>"flowMeans.dat", "Data"], {index, 1, max}];*)
(*flowVars1 = Table[{#[[1]], #[[2]]/(aspRat1[[index]]*aspRat1[[index]])}&/@Import[loc<>sizes1[[index]]<>"flowVars.dat", "Data"], {index, 1, max}];*)
(*flowSkew1 = Table[Import[loc<>sizes1[[index]]<>"flowSkew.dat", "Data"], {index, 1, max}];*)
(*flowKurt1 = Table[Import[loc<>sizes1[[index]]<>"flowKurt.dat", "Data"], {index, 1, max}];*)


Show[{ListPlot[flowMeans1, PlotLegends->SwatchLegend[sizes1],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]], Plot[J[0.75, 0.25, 1-l], {l, 0, 0.75}]}]
ListLogPlot[flowErr1, PlotLegends->SwatchLegend[sizes1],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]]
ListLogPlot[{flowErr1[[1]], flowErr1[[4]], flowErr1[[7]]}, PlotLegends->SwatchLegend[sizes1],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]]
ListLogPlot[flowVars1, PlotLegends->SwatchLegend[sizes1], ImageSize->{1024, 768}]
ListPlot[flowSkew1, PlotRange->{-5, 5} , PlotLegends->SwatchLegend[sizes1], ImageSize->{1024, 768}]
ListPlot[flowKurt1, PlotRange->{0, 10}, PlotLegends->SwatchLegend[sizes1], ImageSize->{1024, 768}]
ListPlot[means1 , PlotLegends->SwatchLegend[sizes1], ImageSize->{1024, 768}]
ListLogPlot[errs1 , PlotLegends->SwatchLegend[sizes1], ImageSize->{1024, 768}]

















J[b_, t_, z_]:= -1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));
loc="/home/jhell/research/results/dim2Runs/closeLook/";
temps = {"8x8/", "16x16/", "32x32/", "32x64/", "64x32/", "64x64/"};
temps2 = {1, 1, 1, 1/2, 2, 1};
fns[l_] := Table[temps2[[index]] J[0.75, 0.25, 1-l], {index, 1, 6}]; 
max = 6;
means = Table[Import[loc<>temps[[index]]<>"densMeans.dat", "Data"], {index, 1, max}];
errs = Table[Import[loc<>temps[[index]]<>"densErrs.dat", "Data"], {index, 1, max}];
flow = Table[Import[loc<>temps[[index]]<>"rateMeans.dat", "Data"], {index, 1, max}];
flowErr = Table[Import[loc<>temps[[index]]<>"rateErrs.dat", "Data"], {index, 1, max}];
flowMeans = Table[{#[[1]], #[[2]]/temps2[[index]]}&/@Import[loc<>temps[[index]]<>"flowMeans.dat", "Data"], {index, 1, max}];
flowVars = Table[{#[[1]], #[[2]]/temps2[[index]]}&/@Import[loc<>temps[[index]]<>"flowVars.dat", "Data"], {index, 1, max}];
flowSkew = Table[Import[loc<>temps[[index]]<>"flowSkew.dat", "Data"], {index, 1, max}];
flowKurt = Table[Import[loc<>temps[[index]]<>"flowKurt.dat", "Data"], {index, 1, max}];


Needs["PlotLegends`"]
Show[{ListPlot[flowMeans, PlotLegends->SwatchLegend[temps],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]], Plot[J[0.75, 0.25, 1-l], {l, 0, 0.75}]}]
ListLogPlot[flowErr, PlotLegends->SwatchLegend[temps],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]]
ListLogPlot[{}, PlotLegends->SwatchLegend[temps],  ImageSize->{1024, 768}, PlotStyle->PointSize[Medium]]
ListLogPlot[flowVars, PlotLegends->SwatchLegend[temps], ImageSize->{1024, 768}]
(*ListPlot[flowSkew, PlotRange->{-5, 5} , PlotLegends\[Rule]SwatchLegend[temps], ImageSize->{1024, 768}]
ListPlot[flowKurt, PlotRange->{0, 10}, PlotLegends\[Rule]SwatchLegend[temps], ImageSize->{1024, 768}]*)
ListPlot[means , PlotLegends->SwatchLegend[temps], ImageSize->{1024, 768}]
ListLogPlot[errs , PlotLegends->SwatchLegend[temps], ImageSize->{1024, 768}]



