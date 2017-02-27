function [fhat,bin] = cshistden(x,N)
% CSHISTDEN     Univariate density histogram.
%
%   [FHAT,BIN] = CSHISTDEN(DATA,N)
%
%   This function will plot the univariate density histogram for the
%   data given in X. N represents the number of bins. The default
%   value for N is 10.
% 
%
%   See also CSHERN1D, CSASH, CSFREQPLOY

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


if nargin == 1
    N = 10;
end

n = length(x);
[nu,bin] = hist(x,N);
% get widths of bins
h = bin(2)-bin(1);
fhat = nu/(n*h);
% plot as density histogram
bar(bin,nu/(n*h),1)
