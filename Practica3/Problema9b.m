function cond = Problema9b(h, b)
  A = [0 1; -1 -b];
  B = [0; 1];
  I = eye(2);
 
  Ad = inverse(I - 0.5 * h * A) * (I + 0.5 * h * A) ;
  
  avd = eig(Ad);              % Autovalores del sistema discreto
  av = (avd - 1) / h;         % Estimación de autovalores continuos
  
  % Condición de estabilidad estimada
  %cond = ??;
end