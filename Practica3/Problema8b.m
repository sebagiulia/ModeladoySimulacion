function cond = Problema8b(h, b)
  A = [0 1; -1 -b];
  B = [0; 1];
  I = eye(2);
  
  Ad = I + h * A + 0.5 * (h * A)^2;
  cond = abs(eig(Ad));
end
