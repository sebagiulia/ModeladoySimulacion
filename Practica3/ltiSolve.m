# A = [0 1; -1 -1];
# B = [0;1];
# u = 1;
# x0 = [0;0];
function x=ltiSolve(A,B,u,x0,t)
  x = zeros(length(x0),length(t));
  x(:,1)=x0;
  I=eye(length(x0));
  iA=inv(A);
  for k=1:length(t)-1  
    eAt=expm(A*t(k));
    x(:,k+1)=eAt*x0+iA*(eAt-I)*B*u;
  endfor
end