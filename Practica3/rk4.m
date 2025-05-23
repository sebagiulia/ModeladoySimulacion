function [t,x]=rk4(f, x0, t0, tf, h)
  t=[x0:h:tf];
  x=zeros(length(x0), length(t));
  x(:,1)=x0; # En la primera columna ponemos x0
  for k=1:length(t)-1
    k1=f(x(:,k), t(k));
    k2=f(x(:,k)+h/2*k1, t(k)+h/2);
    k3=f(x(:,k)+h/2*k2, t(k)+h/2);
    k4=f(x(:,k)+h*k3, t(k)+h);
    x(:,k+1)=x(:,k) + h/4*(k1 + k2 + k3 + k4);
  endfor
end
