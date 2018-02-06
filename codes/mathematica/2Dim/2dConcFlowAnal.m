(* ::Package:: *)

(* ::Input:: *)
(*location = "/home/s1373240/research/results/dim2Runs/attempt1/";*)
(*numLambda = 12;*)
(*rateMeans8x8 =Table[Import[location<>"8x8/"<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, numLambda-1}] ;*)
(*rateErrs8x8 = Table[Import[location<>"8x8/"<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densMeans8x8 = Table[Import[location<>"8x8/"<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densErrs8x8 = Table[Import[location<>"8x8/"<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*rateMeans8x16 =Table[Import[location<>"8x16/"<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, numLambda-1}] ;*)
(*rateErrs8x16 = Table[Import[location<>"8x16/"<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densMeans8x16 = Table[Import[location<>"8x16/"<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densErrs8x16 = Table[Import[location<>"8x16/"<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*rateMeans16x8 =Table[Import[location<>"16x8/"<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, numLambda-1}] ;*)
(*rateErrs16x8 = Table[Import[location<>"16x8/"<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densMeans16x8 = Table[Import[location<>"16x8/"<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densErrs16x8 = Table[Import[location<>"16x8/"<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*rateMeans16x16 =Table[Import[location<>"16x16/"<>ToString[index]<>"/rateMeans.dat", "Data"],{index, 0, numLambda-1}] ;*)
(*rateErrs16x16 = Table[Import[location<>"16x16/"<>ToString[index]<>"/rateErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densMeans16x16 = Table[Import[location<>"16x16/"<>ToString[index]<>"/densMeans.dat", "Data"], {index, 0, numLambda-1}] ;*)
(*densErrs16x16 = Table[Import[location<>"16x16/"<>ToString[index]<>"/densErrs.dat", "Data"], {index, 0, numLambda-1}] ;*)


(* ::Input:: *)
(*Manipulate[GraphicsGrid[ {{ListDensityPlot[rateMeans8x8[[index+1]], ColorFunction->"Rainbow",  PlotRange->All, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[rateMeans8x16[[index+1]], ColorFunction->"Rainbow",  PlotRange->All, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}, {ListDensityPlot[rateMeans16x8[[index+1]], ColorFunction->"Rainbow",  PlotRange->All, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True], ListDensityPlot[rateMeans16x16[[index+1]], ColorFunction->"Rainbow",  PlotRange->All, InterpolationOrder->0, ImageSize->Medium, PlotLegends->True]}}], {index, 0, numLambda-1,1}]*)
(*Manipulate[GraphicsGrid[{{ListDensityPlot[rateErrs8x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[rateErrs8x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]},{ListDensityPlot[rateErrs16x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[rateErrs16x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]}}],{index,0,numLambda-1,1}]*)
(*Manipulate[GraphicsGrid[{{ListDensityPlot[densMeans8x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[densMeans8x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]},{ListDensityPlot[densMeans16x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[densMeans16x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]}}],{index,0,numLambda-1,1}]*)
(*Manipulate[GraphicsGrid[{{ListDensityPlot[densErrs8x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[densErrs8x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]},{ListDensityPlot[densErrs16x8[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True],ListDensityPlot[densErrs16x16[[index+1]],ColorFunction->"Rainbow",PlotRange->Automatic,InterpolationOrder->0,ImageSize->Medium,PlotLegends->True]}}],{index,0,numLambda-1,1}]*)



