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

%gelijktijdige
[eGelijk,lambdaGelijk,resGelijk]=gelijktijdige_it_met_res(mat1,eye(n),maxit);

%raleigh
[lambdaRayEnkel,eRayEnkel,resRayEnkel]=rayleigh_met_res(mat1,rand(n,1),maxit);
lambdaRayEnkel
eigMat1

%hold on
figure(2)
semilogy(resRay,'r-d','LineWidth',5);
hold on
semilogy(1:size(resGelijk,2),resGelijk,'g--s','LineWidth',5);
hold on
semilogy(resRayEnkel(1:5),'m-.p','LineWidth',5);
Legend = legend( 'QR with rayleigh shift', 'Simultaneous iteration', 'Rayleigh iteration');
set(Legend,'FontSize',20);
X = xlabel('Aantal iteratiestappen');
set(X,'FontSize',20);
Y = ylabel('Residu');
set(Y,'FontSize',20);
set(gca,'fontsize',20);