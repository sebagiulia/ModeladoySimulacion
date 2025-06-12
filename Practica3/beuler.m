function [t,x]=beuler(f, x0, t0, tf, h)
  t=[t0:h:tf];
  x=zeros(length(x0), length(t));
  x(:,1)=x0; # En la primera columna ponemos x0
  for k=1:length(t)-1
    F = @(z) z - x(:,k) - h * f(z, t(k+1));
    x(:,k+1)=fsolve(F, x(:,k));
  endfor
end
