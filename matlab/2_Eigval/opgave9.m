clc;clear;

tests = [10, 50,100,500]'
indexTests = 1;
durations = zeros(size(tests,1),2);
while indexTests<= size(tests,1)
    
    display('next test is with matrices of size')
    n = tests(indexTests)
    % make tridiagonal, symmetric matrix
    A = diag(randn(n,1));%diag(randi(n,n,1));%randi(n)*eye(n)
    offdiag = randi(5,n-1,1);%randi(5)*ones(n-1,1);
    Abegin = A + diag(offdiag,1) + diag(offdiag,-1);
    eigA = eig(Abegin);
    
    number = 7; %the number of eigenvalues to get
    
    
    % get 'number' random eigenvalues with Rayleigh Shift
    startTime = cputime;
    
    A = Abegin;%this does the same as opgave 4
    Res = [];
    E = [];
    it = 1;
    for i = size(A,1):-1:2
        while abs(A(i,i-1))>1.e-13
            mu = A(i,i);
            [q,r]=qr(A(1:i,1:i) - mu*eye(i));
            A(1:i,1:i) = r*q + mu*eye(i);
            Res(:,it)=abs(diag(A,-1));
            it = it +1;
        end
        E = [E A(i,i)];
%         Q = [Q q(:,i)];
    end
    ERay = sort([E A(1,1)]);ERay=ERay';
    ResRay = Res;
    itRay = it;
    
    durationRayleigh = cputime - startTime;
    if durationRayleigh == 0
        durationRayleigh= 0.0625;
    end
    
    
    
    % get 'number' eigenvalues with Bisect method
    startTime = cputime;
    
    A = Abegin;
    Ebisect = zeros(number,1);          %eigenvalues
    Qbisect = zeros(number,size(A,1));   %eigenvectors
    for i=1:number
        [E,residue,nbSteps] = bisectionKdeEigval(A,i,1e-14,1000);
        Ebisect(i)= E;
        % also get the eigenvectors with inverse iteration
        [lambda, v] = inviter(A, E, rand(size(A,1),1), 10);
        Qbisect(i,:) = v';
    end
    
    durationBisect= cputime - startTime;
    if durationBisect == 0
        durationBisect = 0.0625;
    end
    
    display('   eig    Rayleigh    Bisect');
    Eigen = padconcatenation(ERay(1:number), eigA(1:7),2);
    Eigen = padconcatenation(Eigen, Ebisect,2)
    
    durations(indexTests,:) = [durationRayleigh , durationBisect];
    indexTests = indexTests + 1;
end

durations

figure(1)
plot(tests, durations)
title('linear plot, QR method vs Bisection method')
legend('QR method (Rayleigh shifts)', 'Bisection method');
xlabel('size of matrix')
ylabel('calculation time')

figure(2)
semilogy(tests, durations)
title('log plot, QR method vs Bisection method')
legend('QR method (Rayleigh shifts)', 'Bisection method');
xlabel('size of matrix')
ylabel('calculation time')

