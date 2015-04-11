% Dit bestand analyseert de convergentie van de arnoldi methode
clc;clear;close all
m =1000;
maxit = 100;

A = sprand(m,m,0.01);
condest(A);
Lambda = eigs(A,m);
b = rand(m,1);
res = rand(1,1);

Q(:,1) = b/norm(b);
for n=1:maxit
    n
  v = A*Q(:,n);
  for j = 1:n
    H(j,n) = Q(:,j)'*v;
    v = v - H(j,n)*Q(:,j);
  end
  H(n+1,n) = norm(v);
  if H(n+1,n) <= 0, 
      break;
  end
  Q(:,n+1) = v/H(n+1,n);
  %cond(H)
  ritz = eigs(H(1:size(H,1)-1,:),size(H,2));
  mins = [];
  mins50 = [];
  currentMin= 0;
  for i = 1:size(Lambda,1)
    if Lambda(i) ~= 0
    differences = abs(real(ritz)) - ones(size(ritz,1),1)*abs(real(Lambda(i)));
    currentMin = min(abs(differences))/abs(real(Lambda(i)));
    mins = [mins currentMin];
    end
    if i < 21
    mins50 = [mins50 currentMin];
    end
  end
  res(n) = mean(mins);
  res50(n) = mean(mins50);
      %res(n) = norm(abs(real(ritz(1:size(Lambda,1))))-abs(real(Lambda)))/norm(abs(real(Lambda)));
end;

mins
Lambda
semilogy(res,'g')
hold on
semilogy(res50,'r');
Legend = legend( 'Alle eigenwaarden', '20 grootste eigenwaarden');


[H, Q] = arnoldi(A, b, maxit);
LambdaArnoldi = eigs(H(1:size(H,1)-1,:),size(H,2));
X = xlabel('Aantal iteratiestappen');
Y = ylabel('Gemiddelde fout');
title('Gemiddelde relatieve fout tussen eigenwaarde en dichtstbijzijnde ritz waarde')

