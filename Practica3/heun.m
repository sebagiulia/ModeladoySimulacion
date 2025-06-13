function [t, x] = heun(f, x0, t0, tf, h)
  t = t0:h:tf;
  x = zeros(length(x0), length(t));
  x(:,1) = x0;
  for k = 1:length(t)-1
    K1 = f(x(:,k), t(k));
    K2 = f(x(:,k) + h * K1, t(k) + h);
    x(:,k+1) = x(:,k) + (h/2) * (K1 + K2);
  endfor
end