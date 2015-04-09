% Dit bestand analyseert verschillen tussen QR methode zonder shift, met
% Rayleigh Shift en met Wilkinson shift.
clc;clear;close all

load mat1.txt;
mat1 = hess(mat1);
[n,m]=size(mat1);
eigMat1 = eig(mat1);
maxit = 20;


%QR zonder shift
[eZonder,resZonder]=qr_zonder(mat1);

%QR met Rayleigh quotiënt shift
[eRay,resRay]=qr_shiftrayleigh(mat1);
figure;
semilogy(resRay);

%gelijktijdige
[V,eGelijk,resGelijk]=gelijktijdige_it_met_res(mat1,eye(n),maxit);

%hold on
figure(2)
semilogy(1:30,resZonder(:,1:30),'-o');
hold on
semilogy(resRay,'r:d');
legend('qrZonder', 'qrRayleighShift', 'qrSimultaneous ')
xlabel('Aantal iteratiestappen');ylabel('Residu')
