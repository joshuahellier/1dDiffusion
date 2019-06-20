(* ::Package:: *)

(* ::Input:: *)
(*f[x_]:= Sqrt[2\[Pi] x] (x/E)^x;*)


(* ::Input:: *)
(*n = \[Rho] L;*)
(*Cm =(f[n]f[L-n-1])/(f[m L]f[n-m L]f[L-n-m L]f[m L-1]);*)


(* ::Input:: *)
(*FullSimplify[Cm]*)


firstApprox  = ((L m)^(-(1/2)-L m) (L m)^(1/2-L m) (L \[Rho])^(1/2+L \[Rho]) (L (-m+\[Rho]))^(-(1/2)+L (m-\[Rho])) (-L (-1+m+\[Rho]))^(-(1/2)+L (-1+m+\[Rho])) (L-L \[Rho])^(-(1/2)+L-L \[Rho]))/(2 \[Pi]);


FullSimplify[Refine[firstApprox, Assumptions->{L>0}]]


FullSimplify[(L^(-(1/2)+L (-1+\[Rho])) m^(-2 L m) (1-m-\[Rho])^(-(1/2)+L (-1+m+\[Rho])) \[Rho]^(1/2+L \[Rho]) (-m+\[Rho])^(-(1/2)+L (m-\[Rho])) (L-L \[Rho])^(-(1/2)+L-L \[Rho]))/(2 \[Pi])]


(* ::InheritFromParent:: *)
(*FullSimplify[(L^(-(1/2)+L (-1+\[Rho])) \[Lambda]^(-2 L m) (1-m-\[Rho])^(-(1/2)+L (-1+m+\[Rho])) \[Rho]^(1/2+L \[Rho]) (-m+\[Rho])^(-(1/2)+L (m-\[Rho])) (1-\[Rho])^(-(1/2)+L-L \[Rho]) L^(-(1/2)+L-L \[Rho]))/(2 \[Pi])]*)


(* ::InheritFromParent:: *)
(*(m^(-2 L m) (1-\[Rho])^(-(1/2)+L-L \[Rho]) (1-m-\[Rho])^(-(1/2)+L (-1+m+\[Rho])) \[Rho]^(1/2+L \[Rho]) (-m+\[Rho])^(-(1/2)+L (m-\[Rho])))/(2 L \[Pi])*)


TeXForm[(m^(-2 L m) (1-\[Rho])^(-(1/2)+L-L \[Rho]) (1-m-\[Rho])^(-(1/2)+L (-1+m+\[Rho])) \[Rho]^(1/2+L \[Rho]) (-m+\[Rho])^(-(1/2)+L (m-\[Rho])))/(2 L \[Pi])]



