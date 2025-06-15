1
function dx = auxmasares(x, t)
  m = 1;
  k = 1;
  b = 0;
  F = 1;
  dx=[x(2);1/m*(-k*x(1)-b*x(2)+F)];
endfunction

x0 = [0; 0]
ti = 0
tf = 50
reltol = 1e-3
abstol = 1e-6
[t, y] = traprulevs(@auxmasares, x0, ti, tf, reltol, abstol)
subplot (2, 1, 1)
plot(t, y)
subplot (2, 1, 2)
plot(t(1:length(t)-1), diff(t))