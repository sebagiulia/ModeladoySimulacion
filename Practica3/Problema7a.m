function [errorPP, errorM] = Problema7a(h)
  k = 1;
  m = 1;
  b = 1;
  A = [0 1; -k/m -b/m];
  B = [0;1];
  u = 1/m;
  tf = 20;
  x0 = [0;0];
  t = [0:h:tf];
  xa = ltiSolve(A,B,u,x0,t);
  [tfe,xfe]=beuler(@masares,x0,0,tf,h);
  errorPP = norm(xfe(:,2)-xa(:,2),1);
  errorM = norm(xfe - xa, 1);
  plot(t,xfe,t,xa);
end
