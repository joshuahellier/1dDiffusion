(* ::Package:: *)

(* ::Input:: *)
(*location = "/home/s1373240/research/results/batchJobs/concRuns/attempt2/";*)
(*rateMeans =Table[Import[location<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, 5}] ;*)
(*rateErrs = Table[Import[location<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, 5}] ;*)
(*densMeans = Table[Import[location<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, 5}] ;*)
(*densErrs = Table[Import[location<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, 5}] ;*)
(*altPlot= Table[Import[location<>ToString[index]<>"/altPlot.dat", "Data"], {index, 0, 5}] ;*)
(**)


(* ::Input:: *)
(*Manipulate[GraphicsGrid[{{ListDensityPlot[rateMeans[[index+1]], ColorFunction->"Rainbow",ColorFunctionScaling->True, PlotRange->{-0.002, 0.002}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[rateErrs[[index+1]], ColorFunction->"Rainbow",  PlotRange->{0, 100}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}, {ListDensityPlot[densMeans[[index+1]], ColorFunction->"Rainbow", PlotRange->{0, 1}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[densErrs[[index+1]], ColorFunction->"Rainbow", PlotRange->{0, 100}, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[altPlot[[index+1]], ColorFunction->"Rainbow",ColorFunctionScaling->True, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}}], {index, 0, 5, 1}]*)


(* ::Input:: *)
(*Manipulate[ListDensityPlot[altPlot[[index+1]], ColorFunction->"Rainbow",ColorFunctionScaling->True,InterpolationOrder->1, ImageSize->Medium, PlotLegends->True, PlotRange->All, PlotRange->{-0.002, 0.002}], {index, 0, 5, 1}]*)
