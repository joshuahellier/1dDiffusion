(* ::Package:: *)

(* ::Input:: *)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/lowDens/";*)
(*meansl = Import[loc<>"densMeans.dat", "Data"];*)
(*errsl = Import[loc<>"densErrs.dat", "Data"];*)
(*flowl = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrl = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansl = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsl = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewl = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtl = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/midDens/";*)
(*meansm = Import[loc<>"densMeans.dat", "Data"];*)
(*errsm = Import[loc<>"densErrs.dat", "Data"];*)
(*flowm = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrm = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansm = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsm = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewm = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtm = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/wideScan/highDens/";*)
(*meansh = Import[loc<>"densMeans.dat", "Data"];*)
(*errsh = Import[loc<>"densErrs.dat", "Data"];*)
(*flowh = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrh = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansh = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsh = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewh = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurth = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/narrowScan/lowDens/";*)
(*meanslRep = Import[loc<>"densMeans.dat", "Data"];*)
(*errslRep = Import[loc<>"densErrs.dat", "Data"];*)
(*flowlRep = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrlRep = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeanslRep = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarslRep = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewlRep = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtlRep = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/narrowScan/midDens/";*)
(*meansmRep = Import[loc<>"densMeans.dat", "Data"];*)
(*errsmRep = Import[loc<>"densErrs.dat", "Data"];*)
(*flowmRep = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrmRep = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeansmRep = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarsmRep = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewmRep = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurtmRep = Import[loc<>"flowKurt.dat", "Data"];*)
(*loc="/home/jhell/research/results/dim2Runs/narrowScan/highDens/";*)
(*meanshRep = Import[loc<>"densMeans.dat", "Data"];*)
(*errshRep = Import[loc<>"densErrs.dat", "Data"];*)
(*flowhRep = Import[loc<>"rateMeans.dat", "Data"];*)
(*flowErrhRep = Import[loc<>"rateErrs.dat", "Data"];*)
(*flowMeanshRep = Import[loc<>"flowMeans.dat", "Data"];*)
(*flowVarshRep = Import[loc<>"flowVars.dat", "Data"];*)
(*flowSkewhRep = Import[loc<>"flowSkew.dat", "Data"];*)
(*flowKurthRep = Import[loc<>"flowKurt.dat", "Data"];*)


ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh, flowMeanslRep}, PlotRange->{{10^-6, 10^6}, Automatic}]
ListLogPlot[{{#[[1]], Abs[#[[2]]]}&/@flowMeansl, {#[[1]], Abs[#[[2]]]}&/@flowMeanslRep}, PlotRange->{{0.01, 0.75}, {10^-6, 10^-1}}]
ListLogLogPlot[{flowVarsl, flowVarsm, flowVarsh, flowVarslRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{flowSkewl, flowSkewm, flowSkewh, flowSkewlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListPlot[{flowSkewl, flowSkewm, flowSkewh, flowSkewlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{flowKurtl, flowKurtm, flowKurth, flowKurtlRep}, PlotRange->{{0.01, 10}, Automatic}]
ListLogLogPlot[{meansl, meansm, meansh, meanslRep}, PlotRange->{{0.01, 10^4}, Automatic}]
ListLogLogPlot[{errsl, errsm, errsh, errslRep}, PlotRange->{{0.01, 10}, Automatic}]
ListPlot[{errsl, errsm, errsh, errslRep}, PlotRange->{{0.01, 0.6}, Automatic}]





fullFlowsl =Table[{flowMeansl[[i]][[1]], flowMeansl[[i]][[2]], Sqrt[flowVarsl[[i]][[2]]/256]}, {i, 1, Length[flowMeansl]}];
fullFlowslRep =Table[{flowMeanslRep[[i]][[1]], flowMeanslRep[[i]][[2]], Sqrt[flowVarslRep[[i]][[2]]/256]}, {i, 1, Length[flowMeanslRep]}];
fullFlowsm =Table[{flowMeansm[[i]][[1]], flowMeansm[[i]][[2]], Sqrt[flowVarsm[[i]][[2]]/256]}, {i, 1, Length[flowMeansm]}];
fullFlowsh =Table[{flowMeansh[[i]][[1]], flowMeansh[[i]][[2]], Sqrt[flowVarsh[[i]][[2]]/256]}, {i, 1, Length[flowMeansh]}];
fullFlowsmRep =Table[{flowMeansmRep[[i]][[1]], flowMeansmRep[[i]][[2]], Sqrt[flowVarsmRep[[i]][[2]]/256]}, {i, 1, Length[flowMeansmRep]}];
fullFlowshRep =Table[{flowMeanshRep[[i]][[1]], flowMeanshRep[[i]][[2]], Sqrt[flowVarshRep[[i]][[2]]/256]}, {i, 1, Length[flowMeanshRep]}];
Needs["ErrorBarPlots`"]
Needs["ErrorBarLogPlots`"]
ErrorListLogLogPlot[{fullFlowsl}, PlotRange->{10^-9, 10^12}]
ErrorListLogLogPlot[{fullFlowsl, fullFlowsm, fullFlowsh}, PlotRange->{{10^-2, 0.6}, {10^-6, 10^-1}}]





current[r0_, rL_, z_] := r0-4 r0^2 z+r0^5 z^3-1/2 r0^4 z^2 (5+3 z)+1/3 r0^3 z (5+13 z) - (rL-4 rL^2 z+rL^5 z^3-1/2 rL^4 z^2 (5+3 z)+1/3 rL^3 z (5+13 z));


Show[{LogLogPlot[{current[0.3, 0.1, 1-l], current[0.6, 0.4, 1-l], current[0.9, 0.7, 1-l]}, {l, 10^-2, 10^3}], ErrorListLogLogPlot[{fullFlowsl, fullFlowsm, fullFlowsh}, PlotRange->{{10^-2, 0.6}, {10^-6, 10^-1}}]}]
Show[{LogLogPlot[{current[0.3, 0.1, 1-l], current[0.6, 0.4, 1-l], current[0.9, 0.7, 1-l]}, {l, 10^-2, 0.5}, PlotRange->{10^-8, 10^-1}], ErrorListLogLogPlot[{fullFlowslRep, fullFlowsmRep, fullFlowshRep}, PlotRange->{{10^-2, 0.6}, {10^-8, 10^-1}}]}]
Show[{Plot[{current[0.3, 0.1, 1-l], current[0.6, 0.4, 1-l], current[0.9, 0.7, 1-l]}, {l, 10^-2, 10^3}], ErrorListPlot[{fullFlowsl, fullFlowsm, fullFlowsh}, PlotRange->{{10^-2, 0.6}, {10^-6, 10^-1}}]}]
Show[{Plot[{current[0.3, 0.1, 1-l], current[0.6, 0.4, 1-l], current[0.9, 0.7, 1-l]}, {l, 10^-2, 0.5}, PlotRange->{-0.05, 10^-1}], ErrorListPlot[{fullFlowslRep, fullFlowsmRep, fullFlowshRep}, PlotRange->{{0.2, 0.6}, {-0.05, 10^-1}}]}]





loc="/home/jhell/research/results/dim2Runs/longerScans/low/";
meansLongl = Import[loc<>"densMeans.dat", "Data"];
errsLongl = Import[loc<>"densErrs.dat", "Data"];
flowLongl = Import[loc<>"rateMeans.dat", "Data"];
flowErrLongl = Import[loc<>"rateErrs.dat", "Data"];
flowMeansLongl = Import[loc<>"flowMeans.dat", "Data"];
flowVarsLongl = Import[loc<>"flowVars.dat", "Data"];
flowSkewLongl = Import[loc<>"flowSkew.dat", "Data"];
flowKurtLongl = Import[loc<>"flowKurt.dat", "Data"];
loc="/home/jhell/research/results/dim2Runs/longerScans/mid/";
meansLongm = Import[loc<>"densMeans.dat", "Data"];
errsLongm = Import[loc<>"densErrs.dat", "Data"];
flowLongm = Import[loc<>"rateMeans.dat", "Data"];
flowErrLongm = Import[loc<>"rateErrs.dat", "Data"];
flowMeansLongm = Import[loc<>"flowMeans.dat", "Data"];
flowVarsLongm = Import[loc<>"flowVars.dat", "Data"];
flowSkewLongm = Import[loc<>"flowSkew.dat", "Data"];
flowKurtLongm = Import[loc<>"flowKurt.dat", "Data"];
loc="/home/jhell/research/results/dim2Runs/longerScans/high/";
meansLongh = Import[loc<>"densMeans.dat", "Data"];
errsLongh = Import[loc<>"densErrs.dat", "Data"];
flowLongh = Import[loc<>"rateMeans.dat", "Data"];
flowErrLongh = Import[loc<>"rateErrs.dat", "Data"];
flowMeansLongh = Import[loc<>"flowMeans.dat", "Data"];
flowVarsLongh = Import[loc<>"flowVars.dat", "Data"];
flowSkewLongh = Import[loc<>"flowSkew.dat", "Data"];
flowKurtLongh = Import[loc<>"flowKurt.dat", "Data"];


ListLogLogPlot[{{#[[1]], Abs[#[[2]]]}&/@flowMeansLongl, {#[[1]], Abs[#[[2]]]}&/@flowMeansLongm, {#[[1]], Abs[#[[2]]]}&/@flowMeansLongh}, PlotRange->{{10^-2, 10^0}, All}]
ListLogLogPlot[{flowMeansLongl, flowMeansLongm, flowMeansLongh}, PlotRange->{{10^-2, 10^0}, All}]
ListPlot[{flowMeansLongl, flowMeansLongm, flowMeansLongh}, PlotRange->{{10^-2, 10^0}, All}]
ListLogLogPlot[{flowVarsLongl, flowVarsLongm, flowVarsLongh}, PlotRange->{{0.01, 1}, Automatic}]
ListLogLogPlot[{flowSkewLongl, flowSkewLongm, flowSkewLongh}, PlotRange->{{0.01, 1}, Automatic}]
ListPlot[{flowSkewLongl, flowSkewLongm, flowSkewLongh}, PlotRange->{{0.01, 1}, Automatic}]
ListLogLogPlot[{flowKurtLongl, flowKurtLongm, flowKurtLongh}, PlotRange->{{0.01, 1}, Automatic}]
ListLogLogPlot[{meansLongl, meansLongm, meansLongh}, PlotRange->{{0.01, 10^0}, Automatic}]
ListLogLogPlot[{errsLongl, errsLongm, errsLongh}, PlotRange->{{0.01, 1}, Automatic}]
ListPlot[{errsLongl, errsLongm, errsLongh}, PlotRange->{{0.01, 0.6}, All}]





flowMeansShiftl[l_] := {#[[1]]-l, Abs[#[[2]]]}&/@flowMeansl;
flowMeansShiftm[l_] := {#[[1]]-l, Abs[#[[2]]]}&/@flowMeansm;
flowMeansShifth[l_] := {#[[1]]-l, Abs[#[[2]]]}&/@flowMeansh;


Manipulate[With[{l = la}, flowMeansShiftl[l]], {{la, 0}, 0, 1, 0.01}]


Manipulate[Show[{ListLogLogPlot[With[{l=l}, flowMeansShiftm[l]], PlotRange->{{10^-3, 10^4}, {10^-7, 10^8}}], LogLogPlot[Exp[b] x^a,{x, 10^-3, 10^6}]}], {l, 0, 0.3, 0.01}, {{a, 1}, 0, 3}, {{b, 0}, -2, 2}]


ListLogLogPlot[{flowMeansl, flowMeansm, flowMeansh, flowMeanslRep}, PlotRange->{{10^-6, 10^6}, Automatic}]


N[2/Log[1+Sqrt[2]]]


Needs["PolygonPlotMarkers`"]
fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]
J[b_, t_, z_]:= 1/6 (-6 b+24 b^2 z-6 b^5 z^3+3 b^4 z^2 (5+3 z)-2 b^3 z (5+13 z)+t (6+t z (-24+t (10+z (26+3 t (-5+(-3+2 t) z))))));


Show[{ListLogLogPlot[{flowLongl, flowLongm, flowLongh}, PlotMarkers->fm["Circle", 4], ImageSize->1600, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], PlotRange->{{0.01, 10}, {10^-9, 500}}, FrameLabel->{{"J/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}],
LogLogPlot[{J[0.1, 0.3, 1-l], J[0.4, 0.6, 1-l], J[0.7, 0.9, 1-l]}, {l, 0.05, 10}, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}]}]
ListLogLogPlot[{flowVarsLongl, flowVarsLongm, flowVarsLongh}, PlotMarkers->fm["Circle", 4], ImageSize->1600, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], PlotRange->{{0.01, 10}, Automatic}, FrameLabel->{{"Var[J]/\!\(\*SuperscriptBox[\(s\), \(-2\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}]
ListLogLogPlot[{meansLongl, meansLongm, meansLongh}, PlotMarkers->fm["Circle", 4], ImageSize->1600, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"(0.3, 0.1)", "(0.6, 0.4)", "(0.9, 0.7)"}], PlotRange->{{0.01, 100}, {10^-6, 1000}}, FrameLabel->{{"Particle Density", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024, PlotStyle->{Darker[Red], Darker[Blue], Darker[Green]}]






