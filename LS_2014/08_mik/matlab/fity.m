% Ukázka fitování v MATLABu i se zjištìním chyb parametrù fitu
% -------------------------------------------------------------------------
% Demonstrováno na úloze 8 z letního semestru. Vykøièníkem (!) jsou 
% oznaèeny nápady na zlepšení. Kód je dost moná pìknì prasácky napsán.
% Data poskytla firma Vnuk & Švihra (skupina 4, Po-odp).
%                                                   
%                                               David Roesel, 30. 3. 2014
%                                 nápady a pøipomínky na roesel@gmail.com

% naèteme namìøená data
%           (!) chtìlo by to naèítat data z texáku místo matlabáckého .mab
%           - ušetøilo by to znaènì èas a práci
load('stojatavlna.mat');
x=data(:,1);
y=data(:,2);

% definujeme rozsah, na kterém budeme vykreslovat vıslednou funkci
%           (!) moná by šlo chytøejc generovat tenhle range? teï vezme
%           rozdíl mezi minimem a maximem a vydìlí ho deseti tisíci
xfunkce=[min(x):(max(x)-min(x))/10000:max(x)];

% urèíme poèáteèní parametry A, B
%           (!) šlo by ještì vyrobit vektor s názvy promìnnıch, napø:
%           ['sigma', 'rho'] 
%           a pøi printování printovat:
%           nazvy(i) = hodnoty(i) +- chyby(i)
b = [4 0.0318328463774207];

% definujeme fitovací funkci
% v tomto pøípadì 2.65*sin(A*x+B)+3
fnce = @(b,x)(2.65*sin(b(1)*x+b(2))+3);

% necháme fitnout data
[hodnoty,R,J,CovB] = nlinfit(x,y,fnce,b);

% vytvoøíme novı graf a plotneme data + funkci s novımi parametry
figure(1);
clf;
plot(x,y,'+r',xfunkce, fnce(hodnoty,xfunkce), '-b')
hold on; 
grid off;
legend('Namìøené hodnoty','Fit', 'Location', 'NorthEast');
xlabel('x [cm]');
ylabel('U [V]');
axis([ 0 13 0 7]);

% vypoèítáme chyby parametrù (odmocnìním diagonálních èlenù kovariaèní
% matice)
chyby=sqrt(diag(CovB));

% pøipravíme si je do øetìzce
%               (!) tohle by šlo urèitì dát do hezkého for cyklu (viz vyse)
title = sprintf('y = 2.65*sin(A*x+B)+3\nA = (%.2f +- %.2f)\nB = (%.1f +- %.1f)', hodnoty(1), chyby(1), hodnoty(2), chyby(2));

% a tento text vytiskneme do grafu
%               (!) stálo by za to dávat relativní pozici popisku, aby
%               nezávisel na tom, v jakém rozsahu zrovna máme hodnoty
text(0.4,6.2,title)

%title  % odkomentovat pokud chceme parametry do konzole






