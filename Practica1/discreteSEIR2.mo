model discreteSEIR2
  parameter Real N = 1e6;
  discrete Real S(start = N), I(start = 10), R(start = 0), E(start = 0), NEaux;
  discrete Real NE[12](start=cat(1, {10.0}, fill(0.0, 11)));
  
  parameter Real alpha = 1, gamma = 0.5, mu = 0.5;
  parameter Integer Ti = 3, Tr = 12; 
  parameter Real R0 = 1.5;

algorithm
  when sample(0, 1) then
    NEaux := (R0 / (Tr - Ti)) * (pre(S) * pre(I) / N);

    S := pre(S) - NEaux;
    E := pre(E) + NEaux - pre(NE[Ti]);
    I := pre(I) + pre(NE[Ti]) - pre(NE[Tr]);
    R := pre(R) + pre(NE[Tr]);

    NE := cat(1, {NEaux}, pre(NE[1:11]));
  end when;
end discreteSEIR2;