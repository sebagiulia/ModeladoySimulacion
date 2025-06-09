k = 1;
m = 1;
b = 0; #10
A = [0 1; -k/m -b/m];
B = [0;1];
u = 1/m;
x0 = [0;0];
t = [0:0.1:10];
x = ltiSolve(A,B,u,x0,t);
plot(t,x);
