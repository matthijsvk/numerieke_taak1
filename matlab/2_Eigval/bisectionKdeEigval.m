% Eigenvalue of tridiagonal matrix using the bisection method
function [E,residue,i] = bisectionKdeEigval(A,k,tol,maxIter)
n = size(A,1);
% eigA = eig(A);

% bisection itself for locating k'th eigenvalue
xl = -max(max(A))^2; %   x lower
xu =  max(max(A))^2; %   xupper
i = 1;
% exactLambda = eigA(k);  % used for calculating the residue (A*x - lambda_i*x)
% x= rand(n,1);             % this too

E = zeros(1,1);
residue = zeros(1,1);

while xu-xl >= tol & i<maxIter
%     [xl,xu]
    xn = (xl+xu)*.5;
    i = i+1;
    [p,s] = sturmSeq(A,xn); % sturmSeq with shift xn, this returns the number of eigenvalues in (-inf, xn)
%     residue(i) = norm(exactLambda*x - xn*x);
    if s >= k   % you counted too much, so it's located in the first half of the interval
        xu = xn;
    else           %not enough eigvalues found yet, search in second half of the interval
        xl = xn;
    end
end
E = xn;
% exactLambda;