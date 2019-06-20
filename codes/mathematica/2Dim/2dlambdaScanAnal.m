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


Needs["PolygonPlotMarkers`"]
fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]


Show[{ListPlot[flow, PlotMarkers->fm["Circle", 4], ImageSize->1600, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@temps], PlotRange->{{0.1, 0.7}, {0, 0.2}}, FrameLabel->{{"J/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True, ImageSize->1024], 
Plot[J[0.25, 0.75, 1-l], {l, 0, 0.7}, PlotStyle->{Black, Dashed}]}]
