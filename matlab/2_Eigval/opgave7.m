
clc;clear;close all

n= 5;


A = [2 4 0 0 0; 4 3 -3 0 0; 0 -3 5 -2 0; 0 0 -2 1 -2; 0 0 0 -2 -1];
A
A = hess(A);
figure;
for i = 1:n
    (eig(A(1:i,1:i)));
    if i == 1
        string1 = 'g--o';
        string2 = 'g-';
    elseif i == 2
        string1 = 'm--o';
        string2 = 'm-';
    elseif i == 3
        string1 = 'b--o';
        string2 = 'b-';
    elseif i == 4
        string1 = 'r--o';
        string2 = 'r-';
    elseif i == 5
        string1 = 'k--o';
        string2 = 'k-';
    end
    stem(eig(A(1:i,1:i)),(n-i+1)*ones(i,1),string1);
    hold on
    plot([-5:10],(n-i+1)*ones(16,1),string2);
    hold on
end


set(gca,'ytick',[])

title('Eigenwaarden van submatrices van A');
axis([-5 10 0 6])