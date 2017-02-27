% Example 12.3 Spline Regression. 
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% First generate some data [Marsh and Cormier, 2002 page 12].
% Months 0 through 12: 55 - 1.4x + err
% Months 13 through 24: 15 + 1.8x + err
% Months 25 through 36: 101 - 1.7x + err
% Months 37 through 48: -24 + 1.7*x + err

x1 = linspace(0,12,15);
y1 = 55 - 1.4*x1 + randn(size(x1));
x2 = linspace(13,24,20);
y2 = 15 + 1.8*x2 + randn(size(x2));
x3 = linspace(25,36,20);
y3 = 101 - 1.7*x3 + randn(size(x3));
x4 = linspace(37,48,15);
y4 = -24 + 1.7*x4 + randn(size(x4));
x = [x1, x2, x3, x4];
y = [y1, y2, y3, y4];

plot(x,y,'.')

% Get the values of the dummy variables
D1 = ones(size(x));
ind = find(x<=12);
D1(ind) = 0;
D2 = ones(size(x));
ind = find(x <= 24);
D2(ind) = 0;
D3 = ones(size(x));
ind = find(x <= 36);
D3(ind) = 0;

% Next get the X matrix.
coL1 = D1.*(x-12);
coL2 = D2.*(x-24);
coL3 = D3.*(x-36);
n = length(x);
X = [ones(n,1),x(:),coL1(:),coL2(:),coL3(:)];

beta = X\y(:);

% Get the estimates of the lines over the intervals.
% Note that the MATLAB convention for polyval is to
% represent the polynomial as coefficients in 
% descending order of the powers.
% Polynomial for interval 1.
p1 = [beta(2), beta(1)];
% P0lynmial for interval 2.
p2 = [beta(2) + beta(3), beta(1)-12*beta(3)];
% Polynomial for interval 3.
p3 = [beta(2)+beta(3)+beta(4), ...
    beta(1)-12*beta(3)-24*beta(4)];
% Polynomial for interval 4.
p4 = [beta(2)+beta(3)+beta(4)+beta(5), ...
    beta(1)-12*beta(3)-24*beta(4)-36*beta(5)];

% Get x, y values using the estimated polynomials
% to plot construct the plot.
y1hat = polyval(p1,x1);
y2hat = polyval(p2,x2);
y3hat = polyval(p3,x3);
y4hat = polyval(p4,x4);
yhat = [y1hat(:);y2hat(:);y3hat(:);y4hat(:)];
plot(x,y,'.',x,yhat)

xlabel('X'),ylabel('Y')
title('Simulated Data with Spline Regression Fit')

% Note that we checked this with the spfit.m function with knots at 0,12,24,36,48. 
% The results match. 
