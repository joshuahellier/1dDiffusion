(* ::Package:: *)

A[r, z, n] = (1-z r)^(2(n-1)) (1+z r((2n+1)r-(2n+2)));
deriv[r, z, n] = FullSimplify[D[A[r, z, n], r]];


secBrack[r, z, n] = Collect[-2 n (-1+r)-r+(1+n (1+2 n) (-1+r)) r z, r];


secBrack[r, z, n]


a[n, z] = n (1+2 n)z;
b[n, z] = (-1-2 n+z-n (1+2 n) z);
c[n, z] = 2;


Evaluate[deriv[r, z, 1]]


botSol[n_, z_] := (-b[n, z]-Sqrt[b[n, z]^2-4 a[n, z] c[n, z]])/(2 a[n, z])


Manipulate[Plot[(-(-1-2 n+z-n (1+2 n) z)-Sqrt[(-1-2 n+z-n (1+2 n) z)^2-4 n (1+2 n)z 2])/(2n (1+2 n)z),  {z, -1, 1}, PlotRange->{0, 1}], {n, 2, 10, 1}]


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
