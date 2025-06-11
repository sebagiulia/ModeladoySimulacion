function e = Problema5b(h)
  [error, xa, xf] = Problema5a(h);
  e = norm(xa-xf, 1);
end
 
 