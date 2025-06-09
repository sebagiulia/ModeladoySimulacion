function dx=masares(x,t)
  k=1;
  m=1;
  b=1;
  F=1;
  dx=[x(2);1/m*(-k*x(1)-b*x(2)+F)];
end

#Todas estas versiones son iguales porque el sistema es estacionario:
# masares([0.5;1.5])
# masares([0.5;1.5], 1)
# masares([0.5;1.5], 10)