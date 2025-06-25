function cond = Problema9b(h, b)
   A = [0 1; -1 -b];
  B = [0; 1];
  I = [1 0; 0 1];
 
  Ad = inverse(I - 0.5 * h * A) * (I + 0.5 * h * A) ;
  cond = abs(eig(Ad));
end