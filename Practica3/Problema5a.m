function [error, xa, xfe] = Problema5a(h)
  k = 1;
  m = 1;
  b = 1;
  A = [0 1; -k/m -b/m];
  B = [0;1];
  u = 1/m;
  tf = 10;
  x0 = [0;0];
  t = [0:h:tf];
  xa = ltiSolve(A,B,u,x0,t);
  [tfe,xfe]=feuler(@masares,x0,0,tf,h);
  plot(t,xa,tfe,xfe)
  error = norm(xfe(:,2)-xa(:,2),1);
end
