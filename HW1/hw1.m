clear all;
close all;
%% data
ULLrms=400;
f1=50;
PM1=4700;
cosphiM1=0.85;
PM2=3500;
cosphiM2=0.82;
PMA=1700; %R
cosphiMA=0.71;
PR1=4300; %R-T
%% #1
IM1=PM1/(sqrt(3)*ULLrms*cosphiM1);
phiM1=acos(cosphiM1);
IM1R=sqrt(2)*IM1*(cos(-phiM1)+1i*sin(-phiM1));
IM1S=sqrt(2)*IM1*(cos(-phiM1-(2/3)*pi)+1i*sin(-phiM1-(2/3)*pi));
IM1T=sqrt(2)*IM1*(cos(-phiM1-(4/3)*pi)+1i*sin(-phiM1-(4/3)*pi));

IM2=PM2/(sqrt(3)*ULLrms*cosphiM2);
phiM2=acos(cosphiM2);
IM2R=sqrt(2)*IM2*(cos(-phiM2)+1i*sin(-phiM2));
IM2S=sqrt(2)*IM2*(cos(-phiM2-(2/3)*pi)+1i*sin(-phiM2-(2/3)*pi));
IM2T=sqrt(2)*IM2*(cos(-phiM2-(4/3)*pi)+1i*sin(-phiM2-(4/3)*pi));

IMA=PMA/((ULLrms/sqrt(3))*cosphiMA);
phiMA=acos(cosphiMA);
IMAc=sqrt(2)*IMA*(cos(-phiMA)+1i*sin(-phiMA));

IR1=PR1/ULLrms;
phiR1=-pi/6;
IR1c=sqrt(2)*IR1*(cos(phiR1)+1i*sin(phiR1));
%% #2
IRc=IM1R+IM2R+IR1c+IMAc
ISc=IM1S+IM2S
ITc=IM1T+IM2T-IR1c
INc=-IMAc

IR=abs(IRc);
IS=abs(ISc);
IT=abs(ITc);
IN=abs(INc);

phiR=atan2(imag(IRc),real(IRc));
phiS=atan2(imag(ISc),real(ISc));
phiT=atan2(imag(ITc),real(ITc));
phiN=atan2(imag(INc),real(INc));
phiRdeg=rad2deg(phiR);
phiSdeg=rad2deg(phiS);
phiTdeg=rad2deg(phiT);
phiNdeg=rad2deg(phiN);

UR=(sqrt(2)/sqrt(3))*ULLrms*(cos(0)+1i*sin(0));
US=(sqrt(2)/sqrt(3))*ULLrms*(cos(-(2/3)*pi)+1i*sin(-(2/3)*pi));
UT=(sqrt(2)/sqrt(3))*ULLrms*(cos(-(4/3)*pi)+1i*sin(-(4/3)*pi));
SR=0.5*UR*conj(IRc);
SS=0.5*US*conj(ISc);
ST=0.5*UT*conj(ITc);
%disp(sprintf('%.2f+j  %.2fi', real(ST), imag(ST)));
%% #3
figure(1);
hold on;
z = [UR IRc];
quiver(zeros(size(z)), zeros(size(z)), real(z), imag(z), 0, 'k', 'LineWidth', 1.5);
zz = [US ISc];
quiver(zeros(size(zz)), zeros(size(zz)), real(zz), imag(zz), 0, 'b', 'LineWidth', 1.5);
zzz = [UT ITc];
quiver(zeros(size(zzz)), zeros(size(zzz)), real(zzz), imag(zzz), 0, 'r', 'LineWidth', 1.5);

labels = {'UR', 'IR', 'US', 'IS', 'UT', 'IT'};
all_vectors = [z zz zzz]; % Combine all vectors

for k = 1:length(all_vectors)
    text(real(all_vectors(k)) * 1.05, imag(all_vectors(k)) * 1.05, labels{k}, ...
        'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
end

grid on;
xlabel('Real Part');
ylabel('Imaginary Part');
title('Phasor Diagram');
%% #4
Uc=ULLrms/sqrt(3);
CR=imag(SR)/(Uc^2*2*pi*f1); 
CS=imag(SS)/(Uc^2*2*pi*f1);
CT=imag(ST)/(Uc^2*2*pi*f1);