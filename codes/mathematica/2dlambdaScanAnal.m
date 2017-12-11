(* ::Package:: *)

(* ::Input:: *)
(*J[b_, t_, z_]:= 1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));*)
(*loc="/home/s1373240/research/results/dim2Runs/lambdaScan1/";*)
(*means1 = Import[loc<>"densMeans.dat", "Data"];*)
(*errs1 = Import[loc<>"densErrs.dat", "Data"];*)
(*flow1 = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErr1 = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeans1 = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVars1 = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkew1 = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurt1 = Import[loc<>"flowKurt.dat", "Data"];*)


Show[{ListPlot[flowMeans1], Plot[J[0.25, 0.75, 1-l], {l, 0, 1.2}]}]
ListPlot[flowVars1, PlotRange->All]
ListPlot[flowSkew1, PlotRange->All]
ListPlot[flowKurt1, PlotRange->All]
ListPlot[means1, PlotRange->All]
ListPlot[errs1, PlotRange->All]



