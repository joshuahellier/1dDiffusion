(* ::Package:: *)

(* ::Input:: *)
(*lMin = 10^-6;*)
(*lMax = 10^6;*)
(*numLambda = 256;*)
(*numEigs = 12;*)
(*lDiff = (lMax - lMin)/numLambda;*)
(*bigL = 10;*)
(*pwd = "/home/jhell/research/results/exactSolns/thirdScan/";*)
(*eigs = Table[{Exp[(i/numLambda)Log[lMax]+(1 - i/numLambda)Log[lMin]], Flatten[Import[pwd<>ToString[i]<>"/eigenvalues.dat", "Data"]]}, {i, 0, numLambda-1}];*)
(*eigsFiltered = Select[eigs,(Length[#[[2]]]>2)&];*)
(*eigTable = Table[Table[{eigsFiltered[[i]][[1]], Abs[eigsFiltered[[i]][[2]][[n]]]} ,{i, 1, Length[eigsFiltered]}], {n, 1, numEigs}];*)


eigsRatio = Table[{eigTable[[1]][[i]][[1]], eigTable[[2]][[i]][[2]]/eigTable[[1]][[i]][[2]]}, {i, 1, Length[eigsFiltered]}];


ListLogLogPlot[eigsRatio, PlotRange->{10^9, 10^14}]


dens = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/densVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];
densFiltered = Select[dens, (Length[#[[2]][[1]]]>2)&];
densTable = Table[Flatten[Table[Table[{densFiltered[[i]][[1]], k, densFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+4}], {i, 1, Length[densFiltered]}], 1], {j, 1, numEigs}];
botDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[2]]}, {i, 1, Length[densFiltered]}];
topDensIn = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+3]]}, {i, 1, Length[densFiltered]}];
botDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[1]]}, {i, 1, Length[densFiltered]}];
topDensOut = Table[{Exp[(densFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - densFiltered[[i]][[1]]/numLambda)Log[lMin]], densFiltered[[i]][[2]][[1]][[bigL+4]]}, {i, 1, Length[densFiltered]}];


curs = Table[{i, Table[Flatten[Import[pwd<>ToString[i]<>"/currVec"<>ToString[j]<>".dat", "Data"]], {j, 0, numEigs-1}]}, {i, 0, numLambda-1}];
cursFiltered = Select[curs, (Length[#[[2]][[1]]]>2)&];
cursTable = Table[Flatten[Table[Table[{cursFiltered[[i]][[1]], k, cursFiltered[[i]][[2]][[j]][[k]]}, {k, 1, bigL+3}], {i, 1, Length[cursFiltered]}], 1], {j, 1, numEigs}];
midCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]}, {i, 1, Length[cursFiltered]}];
absMidCurs = Table[{Exp[(cursFiltered[[i]][[1]]/numLambda)Log[lMax]+(1 - cursFiltered[[i]][[1]]/numLambda)Log[lMin]], Abs[cursFiltered[[i]][[2]][[1]][[Floor[(bigL+3)/2]]]]}, {i, 1, Length[cursFiltered]}];


ListLogLogPlot[eigTable, PlotRange->{10^-6, 10^6}, PlotLegends->True]
ListLogLogPlot[{eigTable[[1]], eigTable[[2]]}]


ListLogLogPlot[]


dens[[319]]
dens[[320]]


densFiltered[[1]]


densTable[[1]]


ListDensityPlot[densTable[[1]], InterpolationOrder->0, PlotRange->All]


ListDensityPlot[cursTable[[1]], PlotRange->All, InterpolationOrder->0]


J[b_, t_, z_]:= ((b-t) + z(b^3-t^3+2t^2-2b^2));
Manipulate[Show[{ListLogLogPlot[midCurs, PlotRange->{{10^-6, 10^6}, {10^-14, 10^(2)}}, FrameLabel->{{"Flow Rate/\!\(\*SuperscriptBox[\(s\), \(-1\)]\)", None}, {"\[Lambda]", None}}, RotateLabel->True, Frame->True], LogLogPlot[J[0.6, 0.4, 1-l]/10, {l, 10^-6, 10^6}, PlotRange->{10^-7, 10^2}, PlotStyle->{Black, Dashed}], LogLogPlot[{Exp[-a (Log[x] - b)], Exp[-c (Log[x] - d)]}, {x, 10^-6, 10^6}, PlotRange->{10^-14, 10^2}, PlotStyle->{{Red, Dotted}}]}], {{a, -1}, -3, 0}, {{b, 4.68}, 3, 7}, {{c, -4.1}, -5, -3} , {{d, -0.1}, -1, 1}]
ListLogLogPlot[absMidCurs]
ListLogLogPlot[botDensOut, PlotRange->{0.5, 0.7}]
ListLogLogPlot[botDensIn, PlotRange->{0.5, 0.7}]
ListLogLogPlot[topDensIn, PlotRange->{0.3, 0.5}]
ListLogLogPlot[topDensOut, PlotRange->{0.3, 0.5}]





midCurs[[64]]
