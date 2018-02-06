(* ::Package:: *)

(* ::Input:: *)
(*location = "/home/jhell/research/results/batchJobs/mainRuns/attempt6b2/";*)
(*flowData =Table[Import[location<>"overallData/overallData"<>ToString[index]<>".dat", "Data"],{index,0, 11}];*)
(*concData =Table[Import[location<>"grandConcData/grandConcData"<>ToString[index]<>".dat", "Data"],{index,0, 11}];*)
(*lambdaTable  = Table[(1.2-0.05)/11 index+0.05, {index, 0, 11}];*)
(*finalData = Table[{Table[lambdaTable[[index]], {innerdex, 1, 24}], flowData[[index]]\[Transpose][[2]], flowData[[index]]\[Transpose][[3]]}\[Transpose],{index, 1, 12}];*)


(* ::Input:: *)
(*f[x_] := 0;*)
(*set1 = Transpose[concData[[1]]];*)
(*set8 = Transpose[concData[[8]]];*)
(*set8[[1]]-set1[[1]];*)
(*reassData = Transpose[{set1[[1]], set1[[1]], Array[f, Length[set1[[1]]]]}];*)
(*oldFragment = Table[concData[[index]], {index, 1, 7}];*)
(*series8 = {Transpose[{set8[[1]], set8[[1]], Array[f, Length[set8[[1]]]]}]};*)
(*newPadding = Table[reassData, {index, 9, 12}];*)
(*newConcData = Join[oldFragment, series8, newPadding];*)


(* ::Input:: *)
(*contourData = Flatten[Table[{newConcData[[index]]\[Transpose][[1]], Table[lambdaTable[[index]], {j, 1, Length[newConcData[[index]]\[Transpose][[2]]]}], flowData[[index]]\[Transpose][[2]]}\[Transpose],{index, 1, 12}], 1];*)
(*contourErr = Flatten[Table[{newConcData[[index]]\[Transpose][[1]], Table[lambdaTable[[index]], {j, 1, Length[newConcData[[index]]\[Transpose][[2]]]}], flowData[[index]]\[Transpose][[3]]}\[Transpose],{index, 1, 12}], 1];*)
(*densData = Flatten[Table[{newConcData[[index]]\[Transpose][[1]], Table[lambdaTable[[index]], {j, 1, Length[newConcData[[index]]\[Transpose][[2]]]}], newConcData[[index]]\[Transpose][[2]]}\[Transpose],{index, 1, 12}], 1];*)
(*densErr = Flatten[Table[{newConcData[[index]]\[Transpose][[1]], Table[lambdaTable[[index]], {j, 1, Length[newConcData[[index]]\[Transpose][[2]]]}], newConcData[[index]]\[Transpose][[3]]}\[Transpose],{index, 1, 12}], 1];*)


(* ::Input:: *)
(*ContourPlot[1+(1-\[Lambda]) \[Rho] (-4+3 \[Rho]), {\[Rho], 0, 1}, {\[Lambda], 0, 1.2}, PlotRange->{0, 1.25}, Contours->20, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, FrameLabel->{{"\[Lambda]", "D"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "MFT Prediction of Diffusion Coefficient"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black]]*)
(*ListContourPlot[contourData, PlotRange->{{ 0, 1}, { 0, 1.2},{0, 1.25}}, Contours->20, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, FrameLabel->{{"\[Lambda]", "D"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "Numerical Simulation of Diffusion Coefficient"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black], InterpolationOrder->1]*)
(*ListContourPlot[contourErr, PlotRange->{{ 0, 1}, { 0, 1.2},Automatic}, Contours->20, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, FrameLabel->{{"\[Lambda]", "Std. Error in D"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "Error in Diffusion Coefficient"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black], InterpolationOrder->1]*)
(*ListContourPlot[densData, PlotRange->{{ 0, 1}, { 0, 1.2},Automatic}, Contours->20, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, FrameLabel->{{"\[Lambda]", "\[LeftAngleBracket]\[Rho]\[RightAngleBracket]"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "Observed System-Averaged Density"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black], InterpolationOrder->1]*)
(*ListContourPlot[densErr, PlotRange->{{ 0, 1}, { 0, 1.2},Automatic}, Contours->20, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, FrameLabel->{{"\[Lambda]", "\[LeftAngleBracket]\[Rho]\[RightAngleBracket]"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "Observed System-Averaged Density"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black], InterpolationOrder->1]*)


ListDensityPlot[densErr, PlotRange->{{ 0, 1}, { 0, 1.2},Automatic}, ColorFunction->"Rainbow", PlotLegends->Automatic, ImageSize->320, PlotLegends->False, 
FrameLabel->{{"\[Lambda]", "\[LeftAngleBracket]\[Rho]\[RightAngleBracket]"}, {"\!\(\*SubscriptBox[\(\[Rho]\), \(M\)]\)", "Observed System-Averaged Density"}}, RotateLabel->True, Frame->True, LabelStyle->Directive[Black], InterpolationOrder->0]
