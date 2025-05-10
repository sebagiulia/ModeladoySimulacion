x0 = [1e6, 10, 0]
[t, x] = dtsim(@discreteSIR, x0, 0, 100) 
plot(t,x);