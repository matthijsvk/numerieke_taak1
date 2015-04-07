clc;clear;
format short e

n = 500*3;
A = rand(n,n);
[Q,R] = qr(A);
k=10; %nb of rows to add

for i=1:k
    %add new inputs row to A
    d= rand(1,n);
    A= [A;d];

    %using givens updates
    starttime = cputime;
    [Q,R] = updateQRGivens(A,Q,R);
    updateGivensTime(i) = cputime - starttime;
%     
%     Qinsert = Q; Rinsert = R;
    
    %using new QR factorization
    starttime = cputime;
    [Q,R]=qr(A);
    newQRTime(i) = cputime - starttime;
    
%     durations = [updateGivensTime, newQRTime]
%     diffQs = [abs(Qinsert) - abs(Q)];
%     diffRs = [abs(Rinsert) - abs(R)];
end
% [Qinsert, Q];
% [Rinsert, R];
display('Done.')

updateGivensTime
newQRTime



