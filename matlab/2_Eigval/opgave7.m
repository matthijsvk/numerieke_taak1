
clc;clear;close all

n= 5;


A = [2 4 0 0 0; 4 3 -3 0 0; 0 -3 5 -2 0; 0 0 -2 1 -2; 0 0 0 -2 -1];
A
A = hess(A);
figure;
for i = 1:n
    ax =scatter(eig(A(1:i,1:i)),i*ones(i,1));
    hold on
end
plot(2);
title('Eigenwaarden van submatrices van A');
axis([-5 10 0 6])