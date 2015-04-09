load mat1.txt
spy(mat1)

H = hess(mat1);
figure(2)
spy(H)