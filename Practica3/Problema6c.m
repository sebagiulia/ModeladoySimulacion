function cond = Problema6c(h,b)
  A = [0 1; -1 -b];
  B = [0; 1];
  I = [1 0; 0 1];
  Ad = I + h * A;
  avd = eig(Ad);
  av = (avd - 1) / h;
  cond = abs(av * h + 1);
 end
