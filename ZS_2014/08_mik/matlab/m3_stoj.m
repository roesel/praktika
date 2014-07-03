%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( u, uu );

% Set up fittype and options.
ft = fittype( 'amplitude*cos(omega*x+phi)+delta', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [1 -Inf -Inf -Inf];
opts.StartPoint = [1.7 1.8 0.41 1.5];
opts.Upper = [1.7 Inf Inf Inf];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'uu vs. u', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel( 'x [cm]' );
ylabel( 'U [V]' );
grid on


