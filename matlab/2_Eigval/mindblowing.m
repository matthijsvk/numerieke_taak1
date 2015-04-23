m = 1000
A = sprand(m,m,0.1);
Lambda = eigs(A,m)

scatter(real(Lambda),imag(Lambda));