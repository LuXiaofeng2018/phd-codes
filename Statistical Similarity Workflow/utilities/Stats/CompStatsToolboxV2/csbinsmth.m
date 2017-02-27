function [ck,smth] = csbinsmth(x,y,K)

% CSBINSMTH Bin smoother
%
%	[CK,YHAT] = CSBINSMTH(X,Y,K) constructs a bin smoother for the predictor
%	values X and the response values Y. The smoothness of the resulting
%	nonparametric regression is governed by the number of regions or bins
%	K.
%
%	INPUTS:		X is a vector of predictor values
%				Y is a vector of response values
%				K is the number of bins
%
%   The ouput of this function is a vector YHAT of smoothed values over the
%   bins and the bins CK.
%
%   A plot of the data points and smooth is also produced by this function.
%
%   EXAMPLE:
%
%   load vineyard
%   y = totlugcount;
%   x = row;
%   [ck,yhat] = csbinsmth(x,y,10);
%
%   See also CSLOESS, CSLOCPOLY, CSLOCLIN, CSNARDWATS, CSLOESSR,
%   CSRMEANSMTH, CSSPLINESMTH, CSBINSMTH

%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

% To smooth using the bin smoother, one sets the number of bins first,
% and then chooses the cutoff points so each region has approximately the
% same number of data points. So, the number of bins is the smoothing
% parameter, but this gives rise to the span - the proportion of points in
% each neighborhood. 

% Set the number of bins and the number of 
% observations in each one.
n = length(x);
nk = ones(1,K)*floor(n/K);
rm = rem(n,K);
if rm ~= 0
    nk(1:rm) = nk(1:rm) + 1;
end
nk = cumsum(nk);

% Sort the data.
[xsort,inds] = sort(x);
ys = y(inds);
% Find the c_k and the value of the smooth in each.
ck = xsort(1);
ck(K+1) = xsort(end);
smth = zeros(1,K+1);
smth(1) = mean(ys(1:nk(1)));
for i = 1:(K-1)
    ck(i+1) = mean(xsort(nk(i):nk(i)+1));
    smth(i+1) = mean(ys(nk(i)+1:nk(i+1)));
end
smth(end) = smth(end-1);

plot(x,y,'o');
xlabel('X'),ylabel('Y')
hold on
stairs(ck,smth)
hold off

