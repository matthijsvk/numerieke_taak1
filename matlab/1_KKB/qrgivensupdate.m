function [Q,R] = qrgivensupdate(A,Q,R) 
  [m,n] = size(A);
  [oldm,oldn]=size(Q)
  Q = [Q,zeros(oldm, m-oldm);zeros(m-oldm,oldn),eye(m - oldm)]   %Q = mxm
  R = A    %R= mxn

  for j = 1:n    %only update new rows
      j
    for i = m:-1:(j+1)
      G = [eye(m)];%,zeros(m,m - oldm)];
      [c,s] = givensrotation( R(i-1,j),R(i,j) );
      G([i-1, i],[i-1, i]) = [c -s; s c]
      R = G'*R
      Q = Q*G
    end
  end
end