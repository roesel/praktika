% Uk�zka fitov�n� v MATLABu i se zji�t�n�m chyb parametr� fitu
% -------------------------------------------------------------------------
% Demonstrov�no na �loze 8 z letn�ho semestru. Vyk�i�n�kem (!) jsou 
% ozna�eny n�pady na zlep�en�. K�d je dost mo�n� p�kn� pras�cky naps�n.
% Data poskytla firma Vnuk & �vihra (skupina 4, Po-odp).
%                                                   
%                                               David Roesel, 30. 3. 2014
%                                 n�pady a p�ipom�nky na roesel@gmail.com

% na�teme nam��en� data
%           (!) cht�lo by to na��tat data z tex��ku m�sto matlab�ck�ho .mab
%           - u�et�ilo by to zna�n� �as a pr�ci
load('stojatavlna.mat');
x=data(:,1);
y=data(:,2);

% definujeme rozsah, na kter�m budeme vykreslovat v�slednou funkci
%           (!) mo�n� by �lo chyt�ejc generovat tenhle range? te� vezme
%           rozd�l mezi minimem a maximem a vyd�l� ho deseti tis�ci
xfunkce=[min(x):(max(x)-min(x))/10000:max(x)];

% ur��me po��te�n� parametry A, B
%           (!) �lo by je�t� vyrobit vektor s n�zvy prom�nn�ch, nap�:
%           ['sigma', 'rho'] 
%           a p�i printov�n� printovat:
%           nazvy(i) = hodnoty(i) +- chyby(i)
b = [4 0.0318328463774207];

% definujeme fitovac� funkci
% v tomto p��pad� 2.65*sin(A*x+B)+3
fnce = @(b,x)(2.65*sin(b(1)*x+b(2))+3);

% nech�me fitnout data
[hodnoty,R,J,CovB] = nlinfit(x,y,fnce,b);

% vytvo��me nov� graf a plotneme data + funkci s nov�mi parametry
figure(1);
clf;
plot(x,y,'+r',xfunkce, fnce(hodnoty,xfunkce), '-b')
hold on; 
grid off;
legend('Nam��en� hodnoty','Fit', 'Location', 'NorthEast');
xlabel('x [cm]');
ylabel('U [V]');
axis([ 0 13 0 7]);

% vypo��t�me chyby parametr� (odmocn�n�m diagon�ln�ch �len� kovaria�n�
% matice)
chyby=sqrt(diag(CovB));

% p�iprav�me si je do �et�zce
%               (!) tohle by �lo ur�it� d�t do hezk�ho for cyklu (viz vyse)
title = sprintf('y = 2.65*sin(A*x+B)+3\nA = (%.2f +- %.2f)\nB = (%.1f +- %.1f)', hodnoty(1), chyby(1), hodnoty(2), chyby(2));

% a tento text vytiskneme do grafu
%               (!) st�lo by za to d�vat relativn� pozici popisku, aby
%               nez�visel na tom, v jak�m rozsahu zrovna m�me hodnoty
text(0.4,6.2,title)

%title  % odkomentovat pokud chceme parametry do konzole






