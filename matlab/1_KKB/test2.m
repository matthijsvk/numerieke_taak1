clc;clear

n = 2;
A = rand(n,n)
[Qold,Rold] = qr(A);
Q=Qold;R=Rold;
u= randn(2,1); v=randn(n,1);%u=randn(randi(n),1)
d= u*v';
AD = [A; d]

for i=1:size(u)
    [Q,R] = qrinsert(Q,R,n+i,d(i,:),'row');
    display('after insertion:');Q*R;
end

%display('Results: ')
Qinsert=Q;  Rinsert=R;
% [Q1,R1]=qr(AD);[Q1,R1];
% Q*R-Q1*R1;

[Qupdate,Rupdate]=qrgivensupdate(AD,Qold,Rold);
Qupdate
Rupdate
Qupdate*Rupdate
Qinsert
Rinsert
Qinsert*Rinsert
[Q,R]=qr(AD)
Q*R

