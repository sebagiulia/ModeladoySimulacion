x0 = [1e6-10, 10, 0,0,[10; zeros(11,1)]]
[t, x] = dtsim(@discreteSEIR2, x0, 0, 1000) 
plot(t,x(1:4,:));