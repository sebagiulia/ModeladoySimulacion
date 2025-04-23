model discreteSEIR
  parameter Real N = 1e6;
  discrete Real S(start = N), I(start = 10), R(start = 0), E(start = 0);
  parameter Real alpha = 1, gamma = 0.5, mu = 0.5;
algorithm
  when sample(0, 1) then
    S := pre(S) - alpha * pre(S) * pre(I) / N;
    I := pre(I) + mu * pre(E) - gamma * pre(I);
    R := pre(R) + gamma * pre(I);
    E := pre(E) + alpha * pre(S) * pre(I) / N - mu * pre(E);
  end when;
end discreteSEIR;