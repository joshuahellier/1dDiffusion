(* ::Package:: *)

myList = Import["/home/jhell/research/PhDStuff/codes/exact/corrFnResults.m"];



b= -Log[l];
f[x_]:=x^2;
lengthInfo = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; {l, xi/.fit["BestFitParameters"], fit["ParameterErrors"][[2]]}, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]}];
backInfo = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; {l, A/.fit["BestFitParameters"], fit["ParameterErrors"][[1]]}, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]}];
info3d = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; {myList[[densIndex]][[1]], l, Log[xi/.fit["BestFitParameters"]]}, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
errorInfo = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; {myList[[densIndex]][[1]], l, Abs[fit["ParameterErrors"][[2]]]/Abs[xi/.fit["BestFitParameters"]]}, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
quality = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; {myList[[densIndex]][[1]], l, Sqrt[Total[f/@fit["FitResiduals"]]]/Length[fit["FitResiduals"]]}, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
fitFns = Table[With[{newList=myList[[densIndex]][[2]]}, Table[fit=NonlinearModelFit[newList,  (1-A)Exp[- Abs[x]/xi] +A, {{A, 0}, {xi, 1}}, x]; fit, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
data = Table[With[{newList=myList[[densIndex]][[2]]}, Table[newList, {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
fourierData = Table[With[{newList=myList[[densIndex]][[2]]}, Table[Abs[Fourier[Table[newList[[lowIndex]][[2]], {lowIndex, 1, Length[newList]}]]], {l, 0.01, 1, 0.01}]],{densIndex, 1, Length[myList]-1}];
Needs["ErrorBarPlots`"];
Needs["ErrorBarPlots`"];
newInfo = Flatten[info3d, 1];
newErrorInfo = Flatten[errorInfo, 1];
newQualityInfo = Flatten[quality, 1];
ListContourPlot[newInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}, {0, 4}}]
ListContourPlot[newErrorInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}, {0, 0.1}}]
ListContourPlot[newQualityInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}}]
(*Manipulate[ErrorListPlot[{lengthInfo[[densIndex]], backInfo[[densIndex]]}, PlotRange\[Rule]{{0, 1}, {0, 2}}],{densIndex, 1, Length[myList]-1, 1}]*)





Export["corrLength.pdf", ListContourPlot[newInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}, {-3, 3}}, ImageSize->Large, Contours->20]]
Export["relErr.pdf", ListContourPlot[newErrorInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}, {0, 0.1}}, ImageSize->Large, Contours->20]]
Export["avRes.pdf", ListContourPlot[newQualityInfo, ColorFunction->"Rainbow", InterpolationOrder->1, PlotLegends->Automatic, PlotRange->{{0, 1}, {0, 1}}, ImageSize->Large, Contours->20]]


With[{newList=myList},Table[newList[[densIndex]], {l, 0.01, 1, 0.01}, {densIndex, 1, Length[newList]-1, 1}]];


Manipulate[Show[{Plot[fitFns[[densIndex]][[lIndex]][x], {x, -12, 12}, PlotRange->{{-12, 12}, {0, 1}}], ListPlot[data[[densIndex]][[lIndex]]]}], {densIndex, 1, Length[myList]-1, 1}, {lIndex, 1, 99, 1}]


Manipulate[ListPlot[fourierData[[densIndex]][[lIndex]], PlotRange->{0,1}],{densIndex, 1, Length[myList]-1, 1}, {lIndex, 1, 99, 1}] 
