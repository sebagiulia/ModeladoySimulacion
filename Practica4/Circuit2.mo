model Circuit2
  Real uL, iR1, iR2, phi(start=1), iL;
  parameter Real R1=1, R2=1, L=1;
equation
  uL - R1 * iR1 = 0;
  uL - R2 * iR2 = 0;
  der(phi) - uL = 0;
  phi - L - iL = 0;
  iL + iR1 + iR2 = 0;
end Circuit2;
