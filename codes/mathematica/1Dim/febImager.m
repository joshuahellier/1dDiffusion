(* ::Package:: *)

(* ::Input:: *)
(*loc = "/home/jhell/research/results/feb2018ImageRecast/1/";*)
(*loc2 = "/home/jhell/research/results/feb2018ImageRecast/2/";*)
(*loc3 = "/home/jhell/research/results/feb2018ImageRecast/4/";*)
(*loc4 = "/home/jhell/research/results/feb2018ImageRecast/3/";*)
(*loc5 = "/home/jhell/research/results/feb2018ImageRecast/5/";*)
(*loc6 = "/home/jhell/research/results/feb2018ImageRecast/6/";*)
(*data1 = Import[loc<>"0/typeStats.dat", "Data"];*)
(*data2 = Import[loc<>"1/typeStats.dat", "Data"];*)
(*data3 = Import[loc<>"2/typeStats.dat", "Data"];*)
(*data4 = Import[loc<>"3/typeStats.dat", "Data"];*)
(*beta1 = Import[loc2<>"0/typeStats.dat", "Data"];*)
(*beta2 = Import[loc2<>"1/typeStats.dat", "Data"];*)
(*beta3 = Import[loc2<>"2/typeStats.dat", "Data"];*)
(*beta4 = Import[loc2<>"3/typeStats.dat", "Data"];*)
(*delta1 = Import[loc3<>"0/typeStats.dat", "Data"];*)
(*delta2 = Import[loc3<>"1/typeStats.dat", "Data"];*)
(*delta3 = Import[loc3<>"2/typeStats.dat", "Data"];*)
(*delta4 = Import[loc3<>"3/typeStats.dat", "Data"];*)
(*alpha1 = Import[loc4<>"0/typeStats.dat", "Data"];*)
(*alpha2 = Import[loc4<>"1/typeStats.dat", "Data"];*)
(*alpha3 = Import[loc4<>"2/typeStats.dat", "Data"];*)
(*alpha4 = Import[loc4<>"3/typeStats.dat", "Data"];*)
(*gamma1 = Import[loc5<>"0/typeStats.dat", "Data"];*)
(*gamma2 = Import[loc5<>"1/typeStats.dat", "Data"];*)
(*gamma3 = Import[loc5<>"2/typeStats.dat", "Data"];*)
(*gamma4 = Import[loc5<>"3/typeStats.dat", "Data"];*)
(*sigma1 = Import[loc6<>"0/typeStats.dat", "Data"];*)
(*sigma2 = Import[loc6<>"1/typeStats.dat", "Data"];*)
(*sigma3 = Import[loc6<>"2/typeStats.dat", "Data"];*)
(*sigma4 = Import[loc6<>"3/typeStats.dat", "Data"];*)


(* ::Input:: *)
(*GraphicsGrid[{{ArrayPlot[(1-#)&/@delta1, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@beta1, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@gamma1, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha1, PlotRange->{0, 1}, ImageSize->{512, 512}],ArrayPlot[(1-#)&/@sigma1, PlotRange->{0, 1}, ImageSize->{512, 512}],   ArrayPlot[(1-#)&/@data1, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]*)
(*GraphicsGrid[{{ArrayPlot[(1-#)&/@delta2, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@beta2, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@gamma2, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha2, PlotRange->{0, 1}, ImageSize->{512, 512}],ArrayPlot[(1-#)&/@sigma2, PlotRange->{0, 1}, ImageSize->{512, 512}],   ArrayPlot[(1-#)&/@data2, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]*)
(*GraphicsGrid[{{ArrayPlot[(1-#)&/@delta3, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@beta3, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@gamma3, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha3, PlotRange->{0, 1}, ImageSize->{512, 512}],ArrayPlot[(1-#)&/@sigma3, PlotRange->{0, 1}, ImageSize->{512, 512}],   ArrayPlot[(1-#)&/@data3, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]*)
(*GraphicsGrid[{{ArrayPlot[(1-#)&/@delta4, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@beta4, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@gamma4, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha4, PlotRange->{0, 1}, ImageSize->{512, 512}],ArrayPlot[(1-#)&/@sigma4, PlotRange->{0, 1}, ImageSize->{512, 512}],   ArrayPlot[(1-#)&/@data4, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]*)


loc7 = "/home/jhell/research/results/feb2018ImageRecast/7/";
zeta1 = Import[loc7<>"0/typeStats.dat", "Data"];
zeta2 = Import[loc7<>"1/typeStats.dat", "Data"];
zeta3 = Import[loc7<>"2/typeStats.dat", "Data"];
zeta4 = Import[loc7<>"3/typeStats.dat", "Data"];
loc8 = "/home/jhell/research/results/feb2018ImageRecast/8/";
pi1 = Import[loc8<>"0/typeStats.dat", "Data"];
pi2 = Import[loc8<>"1/typeStats.dat", "Data"];
pi3 = Import[loc8<>"2/typeStats.dat", "Data"];
pi4 = Import[loc8<>"3/typeStats.dat", "Data"];


GraphicsGrid[{{ArrayPlot[(1-#)&/@zeta1, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha1, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@pi1, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]
GraphicsGrid[{{ArrayPlot[(1-#)&/@zeta2, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha2, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@pi2, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]
GraphicsGrid[{{ArrayPlot[(1-#)&/@zeta3, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha3, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@pi3, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]
GraphicsGrid[{{ArrayPlot[(1-#)&/@zeta4, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@alpha4, PlotRange->{0, 1}, ImageSize->{512, 512}], ArrayPlot[(1-#)&/@pi4, PlotRange->{0, 1}, ImageSize->{512, 512}]}}]


ArrayPlot[(1-#)&/@delta2, PlotRange->{0, 1}, ImageSize->{512, 512}, Frame->False]
ArrayPlot[(1-#)&/@beta2, PlotRange->{0, 1}, ImageSize->{512, 512}, Frame->False]
ArrayPlot[(1-#)&/@alpha2, PlotRange->{0, 1}, ImageSize->{512, 512}, Frame->False]
ArrayPlot[(1-#)&/@data2, PlotRange->{0, 1}, ImageSize->{512, 512}, Frame->False]


FTdatDelta = Fourier[delta2];
FTdatBeta = Fourier[beta2];
FTdatAlpha = Fourier[alpha2];
FTdatData = Fourier[data2];
stripBetaDat = FTdatData[[1]];
ListPlot[Abs[#]^2&/@stripBetaDat]


ListDensityPlot[Abs[#]^2&/@FTdatDelta, ImageSize->{512, 512}, Frame->False, InterpolationOrder->0, ColorFunction->"GrayTones"]
ListDensityPlot[Abs[#]^2&/@FTdatBeta, ImageSize->{512, 512}, Frame->False, InterpolationOrder->0, ColorFunction->"GrayTones"]
ListDensityPlot[Abs[#]^2&/@FTdatAlpha, ImageSize->{512, 512}, Frame->False, InterpolationOrder->0, ColorFunction->"GrayTones"]
ListDensityPlot[Abs[#]^2&/@FTdatData, ImageSize->{512, 512}, Frame->False, InterpolationOrder->0, ColorFunction->"GrayTones"]


FTdatDelta


FTBeta1 = Fourier[beta1];
FTBeta2 = Fourier[beta2];
FTBeta3 = Fourier[beta3];
FTBeta4 = Fourier[beta4];


MatrixPlot[Abs[#]^2&/@FTBeta1, ColorFunction->"GrayTones"]
MatrixPlot[Abs[#]^2&/@FTBeta2, ColorFunction->"GrayTones"]
MatrixPlot[Abs[#]^2&/@FTBeta3, ColorFunction->"GrayTones"]
MatrixPlot[Abs[#]^2&/@FTBeta4, ColorFunction->"GrayTones"]


FT1Delta = Fourier[delta1];
FT1Beta = Fourier[beta1];
FT1Alpha = Fourier[alpha1];
FT1Data = Fourier[data1];


ListContourPlot[Abs[#]^2&/@FT1Delta, ColorFunction->"GrayTones", Contours->20, InterpolationOrder->0]
ListContourPlot[Abs[#]^2&/@FT1Beta, ColorFunction->"GrayTones", Contours->20, InterpolationOrder->0]
MatrixPlot[Abs[#]^2&/@FT1Beta, ColorFunction->"GrayTones"]
MatrixPlot[Abs[#]^2&/@FT1Alpha, ColorFunction->"GrayTones"]
MatrixPlot[Abs[#]^2&/@FT1Data, ColorFunction->"GrayTones"]





loc9 = "/home/jhell/research/results/feb2018ImageRecast/velocities/0/";
phi1 = Import[loc9<>"0/typeStats.dat", "Data"];
phi2 = Import[loc9<>"1/typeStats.dat", "Data"];
phi3 = Import[loc9<>"2/typeStats.dat", "Data"];


ArrayPlot[(1-#)&/@phi1, PlotRange->{0, 1}, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@phi2, PlotRange->{0, 1}, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@phi3, PlotRange->{0, 1}, ImageSize->{512, 512}]


loc10 = "/home/jhell/research/results/feb2018ImageRecast/velocities/1/";
xi1 = Import[loc10<>"0/typeStats.dat", "Data"];
xi2 = Import[loc10<>"1/typeStats.dat", "Data"];
xi3 = Import[loc10<>"2/typeStats.dat", "Data"];


ArrayPlot[(1-#)&/@xi1, PlotRange->{0, 1}, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@xi2, PlotRange->{0, 1}, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@xi3, PlotRange->{0, 1}, ImageSize->{512, 512}]


loc11 = "/home/jhell/research/results/feb2018ImageRecast/velocities/2/";
pi1 = Import[loc11<>"0/typeStats.dat", "Data"];
pi2 = Import[loc11<>"1/typeStats.dat", "Data"];
pi3 = Import[loc11<>"2/typeStats.dat", "Data"];


ArrayPlot[(1-#)&/@pi1, ImageSize->{300, 512}]
ArrayPlot[(1-#)&/@pi2, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@pi3, ImageSize->{512, 512}]


ftPi1 = Fourier[pi1];
ftPi2 = Fourier[pi2];
ftPi3 = Fourier[pi3];


ArrayPlot[Abs[#]^2&/@ftPi1, ImageSize->{512, 512}]
ListDensityPlot[Abs[#]^2&/@ftPi1, PlotRange->Automatic, ImageSize->{512, 512}, PlotLegends->True]
ArrayPlot[Abs[#]^2&/@ftPi2, PlotRange->{0, 1}, ImageSize->{512, 512}]
ArrayPlot[Abs[#]^2&/@ftPi3, PlotRange->{0, 1}, ImageSize->{512, 512}]





loc12 = "/home/jhell/research/results/feb2018ImageRecast/imageCheck/0/";
theta1 = Import[loc12<>"0/typeStats.dat", "Data"];
theta2 = Import[loc12<>"0/straightTypes.dat", "Data"];
theta3 = Import[loc12<>"1/typeStats.dat", "Data"];
theta4 = Import[loc12<>"1/straightTypes.dat", "Data"];
refinedTheta1 = Partition[Transpose[(1-#)&/@theta1], 1];
refinedTheta2 = Partition[Transpose[(1-#)&/@theta2], 1];
refinedTheta3 = Partition[Transpose[(1-#)&/@theta3], 1];
refinedTheta4 = Partition[Transpose[(1-#)&/@theta4], 1];


ArrayPlot[(1-#)&/@theta1, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@theta2, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@theta3, ImageSize->{512, 512}]
ArrayPlot[(1-#)&/@theta4, ImageSize->{512, 512}]


Manipulate[ArrayPlot[refinedTheta4[[timeIndex]], PlotRange->{0, 1}], {timeIndex, 1, 512, 1}]


loc13 = "/home/jhell/research/results/feb2018ImageRecast/fastFlow/0/";
peta1 = Import[loc13<>"1/typeStats.dat", "Data"];
peta2 = Import[loc13<>"1/straightTypes.dat", "Data"];


ArrayPlot[peta1, ImageSize->{512, 512}]
ArrayPlot[peta2, ImageSize->{512, 512}]
refinedPeta1 = Partition[(1-#)&/@peta1, 1];
refinedPeta2 = Partition[Transpose[(1-#)&/@peta2], 1];
Manipulate[ArrayPlot[refinedPeta2[[timeIndex]], PlotRange->{0, 1}], {timeIndex, 1, 512, 1}]





 ArrayPlot[(1-#)&/@alpha1, PlotRange->{0, 1}, ImageSize->{1028, 1024}, Frame->None]
 ArrayPlot[(1-#)&/@alpha2, PlotRange->{0, 1}, ImageSize->{1028, 1024}, Frame->None]
 ArrayPlot[(1-#)&/@alpha3, PlotRange->{0, 1}, ImageSize->{1028, 1024}, Frame->None]
 ArrayPlot[(1-#)&/@alpha4, PlotRange->{0, 1}, ImageSize->{1028, 1024}, Frame->None]



