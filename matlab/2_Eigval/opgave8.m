clc;clear;
A =[ 3     6     0     0     0     0;
     6     3     1     0     0     0;
     0     1     3     2     0     0;
     0     0     2     3     3     0;
     0     0     0     3     3     4;
     0     0     0     0     4     3];
 
n = 100;
A = diag(randi(n,n,1));%randi(n)*eye(n)
offdiag = randi(n,n-1,1);
A = A + diag(offdiag,1) + diag(offdiag,-1);

 [E,Res,nbSteps]= bisection(A,-10000,10000,1e-14);
 
 eigA= eig(A);
 padconcatenation(E, eigA,2)
 
 %semilogy(1:nbSteps(size(E)),Res(size(E),:));
%  semilogy(1:nbSteps,Res);
%  axis tight
%  %title('Error in successive calculated eigenvalues and eigenvectors ||Tx - x\lambda||')
%  xlabel('iteration')
%  ylabel('error')