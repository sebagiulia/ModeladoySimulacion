A = [0 1; -1 -1]
B = [0; 1]
x0 = [0; 0]
u = 1
t = 0:0.1:10
x = ltiSolve(A,B,u,x0,t)
plot(t,x)