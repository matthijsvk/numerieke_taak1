clc;clear; format SHORTE
A =[ 3     6     0     ;
     6     3     1     ;
     0     1     3     ];
     
 eig(A)
n = 300;
A = diag(randi(10,n,1));%diag(randi(n,n,1));%randi(n)*eye(n)
offdiag = ones(n-1,1);%randi(5,n-1,1);
A = A + diag(offdiag,1) + diag(offdiag,-1);

 [E,Res,nbSteps]= bisection(A,-10,10,1e-13);
 
 eigA= eig(A);
 padconcatenation(E, eigA,2)
 
 %semilogy(1:nbSteps(size(E)),Res(size(E),:));
%  semilogy(1:nbSteps,Res);
%  axis tight
%  %title('Error in successive calculated eigenvalues and eigenvectors ||Tx - x\lambda||')
%  xlabel('iteration')
%  ylabel('error')