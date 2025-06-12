function cond = Problema7b(h,b)
  A = [0 1; -1 -b];
  B = [0; 1];
  I = [1 0; 0 1];
  Ad = inverse(I + h * A);
  avd = eig(Ad);
  av = (avd - 1) / h;
  cond = abs(1/(1-av*h));
 end