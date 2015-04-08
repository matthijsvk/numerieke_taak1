function [ p,s ] = sturmSeq( A, shift )
%this method returns the sequence of det(A - xI) and the number of sign changes
%   A = tridiagonal matrix
%   lamb = guess eigen value (used in bisection method)
%   p = a pvector polynomials (p_1 to p_n)
%   s = the number of sign changes

n= size(A,1);
p = zeros(n,1);
s = 0; 

% p(-1) = 0 & p(0) = 1, but we can't use these indices in the matrix
p(1) = (A(1,1) - shift) * 1 - 0^2 * 0;  
if p(1) < 0
    s = 1; 
end
p(2) = (A(2,2) - shift)*p(1) - A(1,2)^2 * 1;
if p(2)*p(1) < 0
    s = s+1; 
end

% for the rest, we can just use the formula
for k = 3:n
    % A(k,k) = a_k ; A(k,k-1) = b_k-1  because b_k-1 is the entry on the
    % k-1'th column of row k, and a_k is the k-th entry on that row (b is
    % offdiagonal element, a is diagonal element)
    p(k) = (A(k,k) - shift)*p(k-1) - A(k-1,k)^2*p(k-2);     %formula (30.9)
    if p(k)*p(k-1) < 0 
        s = s+1;        % sign change means new eigenvalue found -> increment s (new eigval found in interval (-inf,shift)
    end
end