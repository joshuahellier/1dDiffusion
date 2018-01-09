(* ::Package:: *)

(* ::Input:: *)
(*J[b_, t_, z_]:= 1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));*)
(*loc="/home/jhell/research/results/dim2Runs/closeLook/";*)
(*temps = {"8x8/", "16x16/", "32x32/", "32x64/", "64x32/", "64x64/"};*)
(*means = Table[Import[loc<>temps[[index]]<>"densMeans.dat", "Data"], {index, 1, 6}];*)
(*errs = Table[Import[loc<>temps[[index]]<>"densErrs.dat", "Data"], {index, 1, 6}];*)
(*flow = Table[Import[loc<>temps[[index]]<>"rateMeans.dat", "Data"], {index, 1, 6}];*)
(*flowErr = Table[Import[loc<>temps[[index]]<>"rateErrs.dat", "Data"], {index, 1, 6}];*)
(*flowMeans = Table[Import[loc<>temps[[index]]<>"flowMeans.dat", "Data"], {index, 1, 6}];*)
(*flowVars = Table[Import[loc<>temps[[index]]<>"flowVars.dat", "Data"], {index, 1, 6}];*)
(*flowSkew = Table[Import[loc<>temps[[index]]<>"flowSkew.dat", "Data"], {index, 1, 6}];*)
(*flowKurt = Table[Import[loc<>temps[[index]]<>"flowKurt.dat", "Data"], {index, 1, 6}];*)


ListPlot[flowMeans, PlotLegends->True]
ListPlot[flowVars, PlotRange->All, PlotLegends->True]
ListPlot[flowSkew, PlotRange->{-5, 5}, PlotLegends->True]
ListPlot[flowKurt, PlotRange->{0, 10}, PlotLegends->True]
ListPlot[means, PlotRange->All, PlotLegends->True]
ListLogPlot[errs, PlotRange->All, PlotLegends->True]









