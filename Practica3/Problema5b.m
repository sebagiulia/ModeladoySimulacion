function e = Problema5b(h)
  [error, xa, xf] = Problema5a(h);
  e = norm(xf - xa, 1);
end
 
 