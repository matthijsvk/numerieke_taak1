function [Q,R] = updateQRGivens(A,Q,R)    %new A, old Q, old R
    m = size(A,1);
    oldm = size(Q,1);
    for i=1:(m - oldm) % m - oldm rowupdates
        [Q,R] = qrinsert(Q,R,oldm+i,A(oldm+i,:),'row');
        %display('after insertion:');Q*R;
    end
end