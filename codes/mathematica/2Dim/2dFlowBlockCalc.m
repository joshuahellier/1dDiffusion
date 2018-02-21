(* ::Package:: *)

(* ::Input:: *)
(*A[\[Rho]_, z_]:= (1-z \[Rho])^2 (1+z \[Rho](5\[Rho]-6));*)


(* ::Input:: *)
(*J0[\[Rho]B_, \[Rho]T_, z_] := 1/6 (-6 \[Rho]B+24 z \[Rho]B^2-2 z (5+13 z) \[Rho]B^3+3 z^2 (5+3 z) \[Rho]B^4-6 z^3 \[Rho]B^5+\[Rho]T (6+z \[Rho]T (-24+\[Rho]T (10+z (26+3 \[Rho]T (-5+z (-3+2 \[Rho]T)))))));*)


(* ::Input:: *)
(*FullSimplify[J0[\[Rho]B, \[Rho]T, z]]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Manipulate[ContourPlot[J0[\[Rho]B, \[Rho]T, z], {\[Rho]B, 0, 1}, {\[Rho]T, 0, 1}, ColorFunction->"Rainbow", PlotPoints->100, PlotLegends->True ], {z, 0.5, 1, 0.025}]*)


(* ::Input:: *)
(**)


Integrate[A[\[Rho], z], \[Rho]]


Manipulate[Plot[\[Rho]-4 z \[Rho]^2+1/3 z (5+13 z) \[Rho]^3-1/2 z^2 (5+3 z) \[Rho]^4+z^3 \[Rho]^5, {\[Rho], \[Rho]B, \[Rho]T}], {z, 0, 1}, {\[Rho]B, 0, 1}, {\[Rho]T, 0, 1}]


Integrate[\[Rho]-4 z \[Rho]^2+1/3 z (5+13 z) \[Rho]^3-1/2 z^2 (5+3 z) \[Rho]^4+z^3 \[Rho]^5, {\[Rho], \[Rho]T, \[Rho]B}]


avDens[\[Rho]B_, \[Rho]T_, z_]:=(\[Rho]B^2/2-\[Rho]T^2/2-4 z (\[Rho]B^3/3-\[Rho]T^3/3)+1/3 z (5+13 z) (\[Rho]B^4/4-\[Rho]T^4/4)-1/2 z^2 (5+3 z) (\[Rho]B^5/5-\[Rho]T^5/5)+z^3 (\[Rho]B^6/6-\[Rho]T^6/6)-(\[Rho]B-\[Rho]T)(\[Rho]T-4 z \[Rho]T^2+1/3 z (5+13 z) \[Rho]T^3-1/2 z^2 (5+3 z) \[Rho]T^4+z^3 \[Rho]T^5))/((\[Rho]B-4 z \[Rho]B^2+1/3 z (5+13 z) \[Rho]B^3-1/2 z^2 (5+3 z) \[Rho]B^4+z^3 \[Rho]B^5)-(\[Rho]T-4 z \[Rho]T^2+1/3 z (5+13 z) \[Rho]T^3-1/2 z^2 (5+3 z) \[Rho]T^4+z^3 \[Rho]T^5))+\[Rho]T;


Manipulate[Plot[avDens[\[Rho]B, \[Rho]T, 1-l], {l, 0.01, 1}, PlotRange->{0, 1}], {\[Rho]B, 0, 1}, {\[Rho]T, 0, 1}]


FullSimplify[(\[Rho]B^2/2-\[Rho]T^2/2-4 z (\[Rho]B^3/3-\[Rho]T^3/3)+1/3 z (5+13 z) (\[Rho]B^4/4-\[Rho]T^4/4)-1/2 z^2 (5+3 z) (\[Rho]B^5/5-\[Rho]T^5/5)+z^3 (\[Rho]B^6/6-\[Rho]T^6/6)-(\[Rho]B-\[Rho]T)(\[Rho]T-4 z \[Rho]T^2+1/3 z (5+13 z) \[Rho]T^3-1/2 z^2 (5+3 z) \[Rho]T^4+z^3 \[Rho]T^5))/(1/6 (-6 \[Rho]B+24 z \[Rho]B^2-2 z (5+13 z) \[Rho]B^3+3 z^2 (5+3 z) \[Rho]B^4-6 z^3 \[Rho]B^5+\[Rho]T (6+z \[Rho]T (-24+\[Rho]T (10+z (26+3 \[Rho]T (-5+z (-3+2 \[Rho]T)))))))(\[Rho]B-\[Rho]T))]
