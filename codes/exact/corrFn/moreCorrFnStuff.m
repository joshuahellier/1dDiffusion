(* ::Package:: *)

myList = Import["/home/jhell/research/PhDStuff/codes/exact/corrFnResults.m"];



fourAv[aList_] := Sum[Length[aList]/i Abs[aList[[i+1]]]^2, {i, 1, Length[aList]/2}]/Sum[Abs[aList[[i+1]]]^2, {i, 1, Length[aList]-1}];
newList = Transpose[myList[[11]][[2]]][[2]]
With[{newerList=newList},Manipulate[ListPlot[Abs[Fourier[newerList]^2], PlotRange->All], {b, -10, 10, 0.1}]]
Table[fourAv[Fourier[newList]], {b, 0, 10, 0.1}]








i = 2;
myList[[i]][[1]]
ListPlot[myList[[i]][[2]]/.b->Log[10], PlotRange->{-0.2, 1.2}]



