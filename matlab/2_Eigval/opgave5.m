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

%QR met Rayleigh quoti�nt shift
[eRay,resRay]=qr_shiftrayleigh(mat1);

%gelijktijdige
[eGelijk,lambdaGelijk,resGelijk]=gelijktijdige_it_met_res(mat1,eye(n),maxit);

%raleigh
[lambdaRayEnkel,eRayEnkel,resRayEnkel]=rayleigh_met_res(mat1,rand(n,1),maxit);
lambdaRayEnkel
eigMat1

%hold on
figure(2)
semilogy(resRay,'r-d');
hold on
semilogy(1:size(resGelijk,2),resGelijk,'g--s');
hold on
semilogy(resRayEnkel(1:5),'b-.o');
Legend = legend( 'QR with rayleigh shift', 'Simultaneous iteration', 'Rayleigh iteration');
X = xlabel('Aantal iteratiestappen');
Y = ylabel('Residu');