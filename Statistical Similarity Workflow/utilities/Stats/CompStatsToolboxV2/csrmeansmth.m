function [smth] = csrmeansmth(x,y,N)

% CSRMEANSMTH    Running mean smooth
%
%	yhat = CSRMEANSMTH(X,Y,N) constructs a running mean smoother for the
%	predictor values X and the response values Y. The smoothness of the
%	resulting nonparametric regression is governed by the number of points
%	N. 
%
%   Note that this is a symmetric neighborhood, so the number of points in
%   the neighborhood is actually 2*N + 1.
%
%	INPUTS:		X is a vector of predictor values
%				Y is a vector of response values
%				N is the number of points
%
%   The ouput of this function is a vector YHAT of smoothed values at the
%   observed X values.
%
%   A plot of the data points and smooth is also produced by this function.
%
%   EXAMPLE:
%
%   load vineyard
%   y = totlugcount;
%   x = row;
%   yhat = csrmeansmth(x,y,3);
%
%   See also CSLOESS, CSLOCPOLY, CSLOCLIN, CSNARDWATS, CSLOESSR, CSBINSMTH,
%   CSSPLINESMTH

%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

n = length(x);

% Set the number of data points in each window.
% Use symmetric neighborhoods of size 2N+1.

smth = zeros(1,n);
smth(1) = mean(y(1:1+N));
smth(end) = mean(y(n-N:n));
for i = (N+1):(n-N)
    smth(i) = mean(y(i-N:i+N));
end
% Find the lower end of the smooth, 
% using as many to the left as possible.
for i = 2:N
    smth(i) = mean(y(1:i+N));
end
% Find the upper end of the smooth,
% using as many to the right as possible.
for i = (n-N+1):(n-1)
    smth(i) = mean(y(i-N:end));
end


figure
plot(x,y,'o',x,smth)
xlabel('X'),ylabel('Y')
