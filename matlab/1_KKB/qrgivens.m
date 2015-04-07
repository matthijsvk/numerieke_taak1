% qrgivens.m
function [Q,R] = qrgivens(A)
  [m,n] = size(A);
  Q = eye(m);
  R = A;

  for j = 1:n
    for i = m-1:-1:(j)
      G = eye(m);
      [c,s] = givensrotation( R(i,j),R(i+1,j) );
      G([i, i+1],[i, i+1]) = [c s; -conj(s) c];
      R = G'*R;
      Q = Q*G;
    end
  end

end




