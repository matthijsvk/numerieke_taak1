function [Q,R] = updateQRGivens(A,Q,R)    %new A, old Q, old R
    m = size(A,1);
    oldm = size(Q,1);
    for i=1:(m - oldm) % m - oldm rowupdates
        [Q,R] = qrinsert(Q,R,oldm+i,A(oldm+i,:),'row');
        %display('after insertion:');Q*R;
    end
end

% function [Q,R] = qrgivensupdate(A,Q,R) 
%   [m,n] = size(A);
%   [oldm,oldn]=size(Q)
%   Q = [Q,zeros(oldm, m-oldm);zeros(m-oldm,oldn),eye(m - oldm)]   %Q = mxm
%   R = A    %R= mxn
% 
%   for j = 1:n    %update all columns
%       j
%     for i = m:-1:(j+1)
%       G = [eye(m)];%,zeros(m,m - oldm)];
%       [c,s] = givensrotation( R(i-1,j),R(i,j) );
%       G([i-1, i],[i-1, i]) = [c -s; s c]
%       R = G'*R
%       Q = Q*G
%     end
%   end
% end