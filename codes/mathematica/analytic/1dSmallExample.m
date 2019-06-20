(* ::Package:: *)

(* ::Input:: *)
(*TRM[l_]:={{-l, 1, 0, 0, 0, 0, 0, 0}, {0, -2-l, 1, 0, 0, 0, 0, 0}, {0, 1, -2-l, 1, l, 0, 0, 0}, {0, 0, 0, -1-2l, 0, l, 0, 0}, {l, 0, 1, 0, -l, 1, 0, 0}, {0, l, 0, l, 0, -2-l, l, 0}, {0, 0, l, 0, 0, 1, -l, l}, {0, 0, 0, l, 0, 0, 0, -l}};*)


(* ::Input:: *)
(*TeXForm[MatrixForm[TRM[\[Lambda]]]]*)


(* ::Input:: *)
(*ones = {1, 1, 1, 1, 1, 1, 1, 1};*)


(* ::Input:: *)
(*Dot[ones, TRM[\[Lambda]]]*)


(* ::Input:: *)
(*Eigensystem[TRM[\[Lambda]]]*)


Eigenvalues[TRM[\[Lambda]]]


(* ::InheritFromParent:: *)
(**)


(* ::Input:: *)
(*Eigenvectors[TRM[\[Lambda]], 1]*)


(* ::InheritFromParent:: *)
(*TeXForm[FullSimplify[\[Lambda]^3 (3+\[Lambda]){-((-1-3 \[Lambda])/(\[Lambda]^3 (3+\[Lambda]))),-((-1-3 \[Lambda])/(\[Lambda]^2 (3+\[Lambda]))),-((-2-7 \[Lambda]-3 \[Lambda]^2)/(\[Lambda]^2 (3+\[Lambda]))),1,-((-1-4 \[Lambda]-2 \[Lambda]^2)/\[Lambda]^3),-((-1-2 \[Lambda])/\[Lambda]),-((-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)/(\[Lambda]^2 (3+\[Lambda]))),1}]]*)


(* ::Input:: *)
(*FullSimplify[Dot[TRM[\[Lambda]], {-((-1-3 \[Lambda])/(\[Lambda]^3 (3+\[Lambda]))),-((-1-3 \[Lambda])/(\[Lambda]^2 (3+\[Lambda]))),-((-2-7 \[Lambda]-3 \[Lambda]^2)/(\[Lambda]^2 (3+\[Lambda]))),1,-((-1-4 \[Lambda]-2 \[Lambda]^2)/\[Lambda]^3),-((-1-2 \[Lambda])/\[Lambda]),-((-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)/(\[Lambda]^2 (3+\[Lambda]))),1}]]*)


(* ::Input:: *)
(*FullSimplify[{-((-1-3 \[Lambda])/(\[Lambda]^3 (3+\[Lambda]))),-((-1-3 \[Lambda])/(\[Lambda]^2 (3+\[Lambda]))),-((-2-7 \[Lambda]-3 \[Lambda]^2)/(\[Lambda]^2 (3+\[Lambda]))),1,-((-1-4 \[Lambda]-2 \[Lambda]^2)/\[Lambda]^3),-((-1-2 \[Lambda])/\[Lambda]),-((-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)/(\[Lambda]^2 (3+\[Lambda]))),1}/( (4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))))/(\[Lambda]^3 (3+\[Lambda])))]*)


(* ::Input:: *)
(*LogLogPlot[{(1+3 \[Lambda])/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda] (1+3 \[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda] (2+\[Lambda]) (1+3 \[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda]^3 (3+\[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),((3+\[Lambda]) (1+2 \[Lambda] (2+\[Lambda])))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda]^2 (3+\[Lambda]) (1+2 \[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda] (5+\[Lambda] (14+\[Lambda] (8+\[Lambda]))))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))),(\[Lambda]^3 (3+\[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))))}, {\[Lambda], 0.01, 100}, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"000", "001", "010", "011", "100", "101", "110", "111"}], ImageSize->800, FrameLabel->{{"Probability", None}, {"\[Lambda]", None}}, Frame->True]*)


(* ::Input:: *)
(*FullSimplify[Total[{-((-1-3 \[Lambda])/(\[Lambda]^3 (3+\[Lambda]))),-((-1-3 \[Lambda])/(\[Lambda]^2 (3+\[Lambda]))),-((-2-7 \[Lambda]-3 \[Lambda]^2)/(\[Lambda]^2 (3+\[Lambda]))),1,-((-1-4 \[Lambda]-2 \[Lambda]^2)/\[Lambda]^3),-((-1-2 \[Lambda])/\[Lambda]),-((-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)/(\[Lambda]^2 (3+\[Lambda]))),1}]]*)


(* ::Input:: *)
(*leftEntryRate[\[Lambda]_]:= \[Lambda]*((1+3 \[Lambda])/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))))+(\[Lambda] (1+3 \[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))))+(\[Lambda] (2+\[Lambda]) (1+3 \[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))))+(\[Lambda]^3 (3+\[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))));*)


(* ::Input:: *)
(*FullSimplify[ExpandAll[leftEntryRate[\[Lambda]]]]*)


(* ::Input:: *)
(*LogLogPlot[(\[Lambda] (1+\[Lambda])^2 (1+\[Lambda] (4+\[Lambda])))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))), {\[Lambda], 0.9, 1.1}]*)


(* ::Input:: *)
(*Plot[(\[Lambda] (1+\[Lambda])^2 (1+\[Lambda] (4+\[Lambda])))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))), {\[Lambda], 0, 10}]*)


(* ::Input:: *)
(*num = Expand[(1+\[Lambda])^2 (1+\[Lambda] (4+\[Lambda]))]*)


(* ::Input:: *)
(*denom = Expand[4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda])))]*)


(* ::Input:: *)
(*FullSimplify[Expand[4num - denom]]*)


(* ::Input:: *)
(*remainder[\[Lambda]_]:=(-(-1+\[Lambda]) \[Lambda]^2 (3+\[Lambda]))/(4+\[Lambda] (24+\[Lambda] (37+\[Lambda] (26+5 \[Lambda]))));*)


(* ::Input:: *)
(*Plot[remainder[\[Lambda]], {\[Lambda], 0, 10}]*)


TraditionalForm[RowReduce[TRM[1.45]]]


characteristicP = CharacteristicPolynomial[TRM[\[Lambda]], q];


Factor[characteristicP]


TeXForm[Collect[6 q^3+17 q^4+17 q^5+7 q^6+q^7+17 q^2 \[Lambda]+76 q^3 \[Lambda]+103 q^4 \[Lambda]+53 q^5 \[Lambda]+9 q^6 \[Lambda]+15 q \[Lambda]^2+126 q^2 \[Lambda]^2+247 q^3 \[Lambda]^2+165 q^4 \[Lambda]^2+34 q^5 \[Lambda]^2+4 \[Lambda]^3+91 q \[Lambda]^3+294 q^2 \[Lambda]^3+274 q^3 \[Lambda]^3+71 q^4 \[Lambda]^3+24 \[Lambda]^4+171 q \[Lambda]^4+256 q^2 \[Lambda]^4+89 q^3 \[Lambda]^4+37 \[Lambda]^5+127 q \[Lambda]^5+67 q^2 \[Lambda]^5+26 \[Lambda]^6+28 q \[Lambda]^6+5 \[Lambda]^7, q]]


FullSimplify[characteristicP]


Total[\[Lambda]^3 (3+\[Lambda]){-((-1-3 \[Lambda])/(\[Lambda]^3 (3+\[Lambda]))),-((-1-3 \[Lambda])/(\[Lambda]^2 (3+\[Lambda]))),-((-2-7 \[Lambda]-3 \[Lambda]^2)/(\[Lambda]^2 (3+\[Lambda]))),1,-((-1-4 \[Lambda]-2 \[Lambda]^2)/\[Lambda]^3),-((-1-2 \[Lambda])/\[Lambda]),-((-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)/(\[Lambda]^2 (3+\[Lambda]))),1}]


(* ::InheritFromParent:: *)
(*TeXForm[FullSimplify[1+3 \[Lambda]-(-1-3 \[Lambda]) \[Lambda]-(-1-2 \[Lambda]) \[Lambda]^2 (3+\[Lambda])+2 \[Lambda]^3 (3+\[Lambda])-\[Lambda] (-2-7 \[Lambda]-3 \[Lambda]^2)-(3+\[Lambda]) (-1-4 \[Lambda]-2 \[Lambda]^2)-\[Lambda] (-5-14 \[Lambda]-8 \[Lambda]^2-\[Lambda]^3)]]*)


myEigReal[\[Lambda]_] := -Re[#]&/@{0,Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,1],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5 26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,2],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,3],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,4],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,5],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,6],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,7]};


myEigIm[\[Lambda]_] := Abs[Im[#]]&/@{0,Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,1],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5 26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,2],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,3],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,4],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,5],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,6],Root[4 \[Lambda]^3+24 \[Lambda]^4+37 \[Lambda]^5+26 \[Lambda]^6+5 \[Lambda]^7+(15 \[Lambda]^2+91 \[Lambda]^3+171 \[Lambda]^4+127 \[Lambda]^5+28 \[Lambda]^6) #1+(17 \[Lambda]+126 \[Lambda]^2+294 \[Lambda]^3+256 \[Lambda]^4+67 \[Lambda]^5) #1^2+(6+76 \[Lambda]+247 \[Lambda]^2+274 \[Lambda]^3+89 \[Lambda]^4) #1^3+(17+103 \[Lambda]+165 \[Lambda]^2+71 \[Lambda]^3) #1^4+(17+53 \[Lambda]+34 \[Lambda]^2) #1^5+(7+9 \[Lambda]) #1^6+#1^7&,7]}


Needs["PolygonPlotMarkers`"]


fm[name_, size_: 2] := 
 Graphics[{EdgeForm[], PolygonMarker[name, Offset[size]]}, AlignmentPoint -> {0, 0}];
em[name_, size_: 2] := 
 Graphics[{Dynamic@
    EdgeForm@Directive[CurrentValue["Color"], JoinForm["Round"], AbsoluteThickness[1], 
      Opacity[1]], FaceForm[White], PolygonMarker[name, Offset[size]]}, 
  AlignmentPoint -> {0, 0}]


LogLogPlot[myEigReal[\[Lambda]], {\[Lambda], 0.01, 100}, PlotStyle->Black, PlotLegends->SwatchLegend[Automatic, Style[#, FontSize->24]&/@{"000", "001", "010", "011", "100", "101", "110", "111"}], ImageSize->800, FrameLabel->{{"Probability", None}, {"\[Lambda]", None}}, Frame->True]


myEig[0.1]


numEigs = Table[{N[10^((4i)/1000-2)], Eigenvalues[TRM[N[10^((4i)/1000-2)]]]}, {i, 1000}];
numEigsReal = Flatten[Table[{numEigs[[i]][[1]], -Re[numEigs[[i]][[2]][[j]]]}, {i, 1, 1000}, {j, 2, 8}], 1]


ListLogLogPlot[numEigsReal, PlotRange->{5*10^-3, 100}, PlotMarkers->em["Circle", 0.1], PlotStyle->Black, ImageSize->800, FrameLabel->{{"Eigenvalue/\!\(\*SuperscriptBox[SubscriptBox[\(\[Tau]\), \(0\)], \(-1\)]\) (Negative Real Part)", None}, {"\[Lambda]", None}}, Frame->True]
