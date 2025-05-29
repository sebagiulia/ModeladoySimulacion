function dx=farmaco(x,t)
  ra=0.5;
  dx=-ra*x;
end

# Para correrlo:
#  [t,x]=feuler(@farmaco,1,0,10,0.1);
#  plot(t,x,t,exp(-0.5*t))