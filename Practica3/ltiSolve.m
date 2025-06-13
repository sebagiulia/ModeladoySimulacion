function x = ltiSolve(A, B, u, x0, t)
  x = zeros(length(x0), length(t));
  I = eye(length(x0));
  iA = inv(A);
  for k = 1:length(t)
    eAt = expm(A * t(k));
    x(:,k) = eAt * x0 + iA * (eAt - I) * B * u;
  end
end
