function cond = Problema8b(h, b)
  A = [0 1; -1 -b];
  B = [0; 1];
  I = eye(2);
  
  % Método de Heun discreto: Ad ≈ I + h*A + (h*A)^2/2
  Ad = I + h * A + 0.5 * (h * A)^2;
  
  avd = eig(Ad);              % Autovalores del sistema discreto
  av = (avd - 1) / h;         % Estimación de autovalores continuos
  
  % Condición de estabilidad estimada: |1 + λh + (λ²h²)/2|
  cond = abs(1 + av * h + 0.5 * (av.^2) * h^2);
end
