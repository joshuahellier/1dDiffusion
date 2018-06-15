(* ::Package:: *)

A[r_, z_, n_] := (1-z r)^(2(n-1)) (1+z r((2n+1)r-(2n+2)));
deriv[r, z, n] = FullSimplify[D[A[r, z, n], r]];
Manipulate[Plot[A[r, z, n], {r, -1, 3}, PlotRange->{-1, 10}], {z, -1, 1}, {n, 1, 4, 1}]
ContourPlot[A[r, 1-l, 2], {r, 0, 1}, {l, 0, 1}, PlotRange->{0, 1}]
A[r, z, 1]


Collect[FullSimplify[D[A[r, z, n], r]], r]
secBrack[r, z, n] = Collect[-2 n (-1+r)-r+(1+n (1+2 n) (-1+r)) r z, r];


secBrack[r, z, n]


z = 1-l;
a = n (1+2 n)z;
b = (-1-2 n+z-n (1+2 n) z);
c = 2;
FullSimplify[b^2 - 4 a c]
Collect[b^2 - 4 a c, l]
FullSimplify[-b]
FullSimplify[4 n^2-8 n (1+2 n)+4 n^2 (1+2 n)+n^2 (1+2 n)^2]
FullSimplify[(4 n+10 n (1+2 n)-4 n^2 (1+2 n)-2 n^2 (1+2 n)^2)]
FullSimplify[ (1-2 n (1+2 n)+n^2 (1+2 n)^2)]
Collect[2 a, l]


Evaluate[deriv[r, z, 1]]


botSol[n_, z_] := (-b[n, z]-Sqrt[b[n, z]^2-4 a[n, z] c[n, z]])/(2 a[n, z])


Manipulate[LogLogPlot[(-(-1-2 n+(1-z)-n (1+2 n) (1-z))-Sqrt[(-1-2 n+(1-z)-n (1+2 n) (1-z))^2-4 n (1+2 n)(1-z) 2])/(2n (1+2 n)(1-z)),  {z, 0.01, 1000}, PlotRange->{0, 1}], {n, 1, 4, 1}]


deriv[r, z, n]


FullSimplify[(-(-1-2 n+z-n (1+2 n) z)-Sqrt[(-1-2 n+z-n (1+2 n) z)^2-4 n (1+2 n)z 2])/(2n (1+2 n)z)]


Collect[-8 n (1+2 n) z+(1-z+n (2+z+2 n z))^2, z]


(* ::InheritFromParent:: *)
(**)


c = 1+4 n+4 n^2;
b = (-2-2 n+8 n^2+8 n^3-8 n (1+2 n));
a = (1-2 n-3 n^2+4 n^3+4 n^4);



h = -b/(2a);
k = c - b^2/(4a);
FullSimplify[h]
FullSimplify[k]


FullSimplify[a (z-h)^2+k - (-8 n (1+2 n) z+(1-z+n (2+z+2 n z))^2)]


FullSimplify[(-1-2 n+z-n (1+2 n) z)^2-4 n (1+2 n)z 2]


FullSimplify[-(-1-2 n+z-n (1+2 n) z)]


b^2 - 4 a c


Limit[(-(-1-2 n+(1-z)-n (1+2 n) (1-z))-Sqrt[(-1-2 n+(1-z)-n (1+2 n) (1-z))^2-4 n (1+2 n)(1-z) 2])/(2n (1+2 n)(1-z)), z-> Infinity]


1-28/64


zc = (4(2n+1))/(4n^2+8n+4);
FullSimplify[Replace[(-(-1-2 n+z-n (1+2 n) z)-Sqrt[(-1-2 n+z-n (1+2 n) z)^2-4 n (1+2 n)z 2])/(2n (1+2 n)z), z->zc, Infinity]]


Replace[4/(-3+6 n+3/(1+n)+Sqrt[(n (1+2 n)^2 (-8+9 n))/(1+n)^2]), n->2, Infinity]


FullSimplify[4/(63/4+(7 Sqrt[57])/4)]


N[Sqrt[5]]


N[4/(10+(10 Sqrt[5])/3)]


N[3/7]


Plot[4/(-3+6 n+3/(1+n)+Sqrt[(n (1+2 n)^2 (-8+9 n))/(1+n)^2]), {n, 1, 4}]


Manipulate[Plot[{-2 z (1-r z)^(-3+2 n) (-2 n (-1+r)-r+(1+n (1+2 n) (-1+r)) r z), - (-2 n (-1+r)-r+(1+n (1+2 n) (-1+r)) r z)}, {r, 0, 1}, PlotRange->{-2, 2}], {n, 1, 3, 1}, {z, -1, 1}]


 Solve[(-2 n (-1+r)-r+(1+n (1+2 n) (-1+r)) r z)==0, r]


Manipulate[Plot[(1+2 n-z+n z+2 n^2 z-Sqrt[(-1-2 n+z-n z-2 n^2 z)^2-8 n (n z+2 n^2 z)])/(2 (n z+2 n^2 z)), {z, -1, 1}], {n, 1, 3, 1}]


Replace[(1+2 n-z+n z+2 n^2 z-Sqrt[(-1-2 n+z-n z-2 n^2 z)^2-8 n (n z+2 n^2 z)])/(2 (n z+2 n^2 z)), z->(4(2n+1))/(4n^2+8n+4), Infinity]


FullSimplify[(1+2 n-(4 (1+2 n))/(4+8 n+4 n^2)+(4 n (1+2 n))/(4+8 n+4 n^2)+(8 n^2 (1+2 n))/(4+8 n+4 n^2)-Sqrt[(-1-2 n+(4 (1+2 n))/(4+8 n+4 n^2)-(4 n (1+2 n))/(4+8 n+4 n^2)-(8 n^2 (1+2 n))/(4+8 n+4 n^2))^2-8 n ((4 n (1+2 n))/(4+8 n+4 n^2)+(8 n^2 (1+2 n))/(4+8 n+4 n^2))])/(2 ((4 n (1+2 n))/(4+8 n+4 n^2)+(8 n^2 (1+2 n))/(4+8 n+4 n^2)))]


(* ::InheritFromParent:: *)
(*Plot[4/(6-3/(1+n)+Sqrt[(n^2 (1+2 n)^2)/(1+n)^2]/n), {n, 1, 4}]*)
