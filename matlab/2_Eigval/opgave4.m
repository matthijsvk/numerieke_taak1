% Dit bestand analyseert verschillen tussen QR methode zonder shift, met
% Rayleigh Shift en met Wilkinson shift.
clc;clear;close all;format short e

load mat1.txt;
mat1 = hess(mat1);
[n,m]=size(mat1);
eigMat1 = eig(mat1);

% Eerst plotten we berekeningen voor het vinden 1 eigenwaarde
%QR zonder shift
[eZonder,resZonder]=qr_zonder(mat1)

%QR met Rqyleigh quotiënt shift
[eRay,resRay]=qr_shiftrayleigh(mat1)

%QR met Wilkinson shift
[eWilk,resWilk]=qr_shiftwilkinson(mat1)

%hold on
figure  %plot tot iteratie 30
semilogy(1:30,resZonder(:,1:30),'-o', 1:size(resRay,2),resRay,'r:d', 1:size(resWilk,2),resWilk,'g--s');
legend('qrZonder', 'qrRayleighShift', 'qrWilkinsonShift')
xlabel('Aantal iteratiestappen');
ylabel('Residu');

% Nu berekenen we alle eigenwaardes volgens de verschillende methodes. Ze
% volgen allemaal dezelfde strategie, alleen zijn de mu's anders (0 bij
% Zonder, A(i,i) bij Rayleigh en nog anders bij Wilkinson
% Without Shift
A = hess(mat1);
Res = [];
E = [];
it = 1;
for i = n:-1:2
    while abs(A(i,i-1))>1.e-13   
        [q,r]=qr(A(1:i,1:i));
        A(1:i,1:i) = r*q;
        Res(:,it)=abs(diag(A,-1));
        it = it +1;
    end
    E = [E A(i,i)];
end
EZonder = [E A(1,1)];
ResZonder = Res;
itZonder = it;

% Rayleigh Shift
A = hess(mat1);
Res = [];
E = [];
it = 1;
for i = n:-1:2
    while abs(A(i,i-1))>1.e-13                  
        mu = A(i,i);
        [q,r]=qr(A(1:i,1:i) - mu*eye(i));
        A(1:i,1:i) = r*q + mu*eye(i);
        Res(:,it)=abs(diag(A,-1));
        it = it +1;
    end
    E = [E A(i,i)];
end
ERay = [E A(1,1)];
ResRay = Res;
itRay = it;

% Wilkinson Shift
A = hess(mat1);
Res = [];
E = [];
it = 1;
for i = n:-1:2
    while abs(A(i,i-1))>1.e-13   
        delta = (A(i-1,i-1)-A(i,i))/2;
        if(delta==0)
            signdelta = 1;
        else
            signdelta = sign(delta);
        end
        mu = A(i,i)-signdelta*A(i,i-1)^2/(abs(delta)+sqrt(delta^2+A(i,i-1)^2));
        [q,r]=qr(A(1:i,1:i) - mu*eye(i));
        A(1:i,1:i) = r*q + mu*eye(i);
        Res(:,it)=abs(diag(A,-1));
        it = it +1;
    end
    E = [E A(i,i)];
end
EWilk = [E A(1,1)];
ResWilk = Res;
itWilk = it;

% Resultaten
sort([EZonder',ERay',EWilk',eigMat1])
AantalStappen_Zonder_Ray_Wilk = [itZonder,itRay,itWilk]