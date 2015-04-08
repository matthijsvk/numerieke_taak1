% Eigenvalue of tridiagonal matrix using the bisection method
clc;clear

% Construct tridiagonal matrix
n = 6;
A = randi(n)*eye(n);
offdiag = randi(n,n-1,1);
A = A + diag(offdiag,1) + diag(offdiag,-1)
eigA = eig(A);
% Choose an interval I=[a0,b0] that contains Lambda_i.
% Therefore: p(b0) >= i and p(a0) < i.
% Evaluate the polynomial sequence for a=(a0+b0)/2 and
% count the signchanges in the sequence pi(a) ?w(a).
% I fw(a) >= i: Replace in interval I b0 by a
% Otherwise: Replace in interval I a0 by a.
% Bisection Algorithm:
% Generates converging sequence of smaller and smaller intervals that contain the eigenvalue i.

a0 = 0;
b0 = 5;
[a0,b0]

[p,sBeforeA0] = sturmSeq(A,a0); %number of eigvals before the interval, so first eigval in interval has index sBeforeA0 + 1
[p,sBeforeB0] = sturmSeq(A,b0);
nbEigInterval = sBeforeB0 - sBeforeA0
eigInterval = zeros(nbEigInterval,1);

for k=sBeforeA0+1:sBeforeB0
    % bisection itself for locating k'th eigenvalue
    xl = a0; %   x lower bound
    xu = b0; %   x upper bound
    i = 1;
    exactLambda = eigA(k);  % used for calculating the residue (A*x - lambda_i*x)
    x= rand(n,1);             % this too
    while xu-xl >= 1e-15
        xn = (xl+xu)*.5;
        xp(i) = xn; % keep track of previous estimates for plotting
        i = i+1;
        [p,s] = sturmSeq(A,xn); % sturmSeq with shift xn, this returns the number of eigenvalues in (-inf, xn)
        residu(i) = norm(exactLambda*x - xn*x);
        s; %= n-s
        if s >= k   % you counted too much, so it's located in the first half of the interval
            xu = xn;
        else           %not enough eigvalues found yet, search in second half of the interval
            xl = xn;
        end
    end
    residu
    disp('exact,    calculated');[exactLambda, xn]
    check = exactLambda*x - xn*x;
    disp(' ')
    
    eigInterval(k - sBeforeA0) = xn;    %save calculated eigenvalue
    
    semilogy(residu)
    axis tight
    title('Error in successive calculated eigenvalues and eigenvectors ||Tx - x\lambda||')
    xlabel('iteration')
    ylabel('error')
end

eigA
eigInterval

