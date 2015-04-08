A =[ 3     6     0     0     0     0;
     6     3     1     0     0     0;
     0     1     3     2     0     0;
     0     0     2     3     3     0;
     0     0     0     3     3     4;
     0     0     0     0     4     3];
 
 [E,Res,nbSteps]= bisection(A,-100,100,1e-15);
 
 E
 eig(A)
 Res;
 nbSteps(size(E,1));
 
 %semilogy(1:nbSteps(size(E)),Res(size(E),:));
 semilogy(1:nbSteps,Res);
 axis tight
 title('Error in successive calculated eigenvalues and eigenvectors ||Tx - x\lambda||')
 xlabel('iteration')
 ylabel('error')