x0 = [1e6;10;0;0]
[t, x] = dtsim(@discreteSEIR, x0, 0, 100) 
plot(t,x);