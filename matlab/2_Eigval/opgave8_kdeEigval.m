% Eigenvalue of tridiagonal matrix using the bisection method
clc;clear

% Construct tridiagonal matrix
n = 6;
A = randi(n)*eye(n);
offdiag = randi(n,n-1,1);
A = A + diag(offdiag,1) + diag(offdiag,-1)

eigA = eig(A)

% Choose an interval I=[a0,b0] that contains ?i.
% Therefore: w(b0) >= i and w(a0) < i.
% Evaluate the polynomial sequence for a=(a0+b0)/2 and
% count the signchanges in the sequence pi(a) ?w(a).
% I fw(a) >= i: Replace in interval I b0 by a
% Otherwise: Replace in interval I a0 by a.
% Bisection Algorithm:
% Generates converging sequence of smaller and smaller intervals that contain the eigenvalue ?i.

% bisection itself for locating k'th eigenvalue
k = 4    % find 4th eigenvalue
xl = 1; %   x lower
xu = 10; %   xupper
i = 1;
exactLambda = eigA(k)  % used for calculating the residue (A*x - lambda_i*x)
x= rand(n,1);             % this too
while xu-xl >= 1e-15
    xn = (xl+xu)*.5
    xp(i) = xn; % keep track of previous estimates for plotting
    i = i+1;
    [p,s] = sturmSeq(A,xn); % sturmSeq with shift xn, this returns the number of eigenvalues in (-inf, xn)
    %resid(i) = norm(A*x - xn*x);
    s %= n-s
    if s >= k   % you counted too much, so it's located in the first half of the interval
        xu = xn
    else           %not enough eigvalues found yet, search in second half of the interval
        xl = xn 
    end
end

xn
check = exactLambda*x - xn*x

% semilogy(resid)
% axis tight
% title('Error in successive calculated eigenvalues and eigenvectors ||Tx - x\lambda||')
% xlabel('iteration')
% ylabel('error')