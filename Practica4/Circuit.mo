model Circuit
  Real uR, uC, uS, uL, iR, iC, iS, iL, q, phi;
  parameter Real C=1, R=1, L=1;
equation
 0 = uR - R * iR;
 0 = der(q) - iC;
 0 = q - C * uC;
 0 = der(phi) - uL;
 0 = phi - L * iL;
 0 = uS - sin(time);
 0 = uL + uR + uC - uS;
 0 = iL - iR;
 0 = iC - iL;
 0 = iS - iR;
end Circuit;
