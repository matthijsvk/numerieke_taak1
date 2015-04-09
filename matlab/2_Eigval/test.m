clc;clear;
n = 10;
A = diag(randi(10,n,1));%diag(randi(n,n,1));%randi(n)*eye(n)
offdiag = 10*ones(n-1,1);%randi(5,n-1,1)
A = A + diag(offdiag,1) + diag(offdiag,-1);

[E,residue,nbSteps] = bisectionKdeEigval(A,4,1e-14,100)

