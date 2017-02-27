function [fhat,h] = cskern1d(x,data,h)
% CSKERN1D  Univariate kernel density estimator.
%
%   [FHAT,h] = CSKERN1D(X,DATA,H)
%
%   This function returns the univariate kernel density
%   estimate using the observations in DATA. The domain values
%   over which to evaluate the density are given in X.
%
%   The smoothing parameter is given by the optional window
%   width H. The default value is obtained from the Normal
%   Reference Rule.
%
%   The window width H is returned by the function, so one can
%   adjust the value.
%
%   The normal kernel is used.
%
%   EXAMPLE:
%
%   load snowfall
%   x = linspace(10, 150);
%   [fhat,h] = cskern1d(x,snowfall,4);
%   
%
%   See also CSHISTDEN, CSFREQPOLY, CSASH

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

n = length(data);
fhat = zeros(size(x));

if nargin ==2
    h = 1.06*n^(-1/5);
end
for i=1:n
   % get each kernel function evaluated at x
			% centered 		at data
   f=exp(-(1/(2*h^2))*(x-data(i)).^2)/sqrt(2*pi)/h;
   fhat = fhat+f/(n);
end

plot(x,fhat)
