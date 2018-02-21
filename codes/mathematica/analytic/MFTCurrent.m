(* ::Package:: *)

(* ::Input:: *)
(*\[Rho] = f[x];*)
(*d\[Rho] = D[f[x], x];*)
(*d2\[Rho] = D[f[x], {x, 2}];*)
(*d\[Rho]dt = (2d2\[Rho]-2\[Rho] \[Zeta](4-3\[Rho])d2\[Rho] + \[Zeta](3\[Rho]-2)d\[Rho]^2);*)
(*FullSimplify[Integrate[d\[Rho]dt, x]]*)


(* ::Input:: *)
(*d2\[Rho]*)


(* ::Input:: *)
(*Times@@@{{x,y},{a,b}}*)


(* ::Input:: *)
(*?Tuples*)


(* ::Input:: *)
(*Times@@@Tuples[{f[x],f'[x],f''[x]},2]*)


(* ::Input:: *)
(*DeleteDuplicates[Times@@@Tuples[{f[x],f'[x],f''[x]},#]]&/@Range[3]//Flatten*)
(*J=(Array[c,Length[#]].#&)@((Join[#,\[Zeta]*#]&)@%)*)


(* ::Input:: *)
(*DeleteDuplicates[Times@@@Tuples[{f[x],f'[x],f''[x]},#]]&/@Range[5]//Flatten*)
(*J=(Array[c,Length[#]].#&)@%*)


(* ::Input:: *)
(*D[J,x]==FullSimplify[d\[Rho]dt]//.\[Zeta]->1/2*)
(*SolveAlways[%,{f[x],f'[x],f''[x],f'''[x]}]*)


(* ::Input:: *)
(*/@,@,@@,@@@*)


(* ::Input:: *)
(*D[J,x]-d\[Rho]dt//Expand*)


(* ::Input:: *)
(*?FoldList*)


(* ::Input:: *)
(*(0==#&)/@Fold[Flatten[Normal[CoefficientArrays[Expand[#1],#2]]]&,D[J,x]-d\[Rho]dt,{\[Zeta],f[x],f'[x],f''[x],f'''[x]}]//Solve*)


(* ::Input:: *)
(*%//Solve*)


(* ::Input:: *)
(*Array[c,10]*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*?SolveAlways*)


(* ::Input:: *)
(*f'[x]//FullForm*)


(* ::Input:: *)
(*D[f[x],x]*)
