function [fhat,binedge] = csash(x,h,m)
% CSASH     Univariate averaged shifted histogram.
%
%   [FHAT,BINEDGE] = CSASH(X,H,M)
%
%   This function constructs the probability density estimate from
%   the averaged shifted histogram method.
%   X is the vector of data. H is the window width. M is the number
%   of shifted histograms.
%
%   EXAMPLE:
%   
%   load snowfall
%   [fhat, binedge] = csash(snowfall,14.6,30);
%
%   See also CSHISTDEN, CSFREQPOLY, CSKERN1D

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

delta=h/m;
n = length(x);

% Get the mesh.
t0 = 0;
tf = max(x)+20;
nbin = ceil((tf-t0)/delta);
binedge = t0:delta:(t0+delta*nbin);

% Get the bin counts for the smaller binwidth delta.
vk = histc(x,binedge);
% Put into a vector with m-1 zero bins on either end.
fhat = [zeros(1,m-1),vk,zeros(1,m-1)];

% Get the weight vector.
% Create an inline function for the kernel.
kern = inline('(15/16)*(1-x.^2).^2');
ind = (1-m):(m-1);
% Get the denominator. 
den = sum(kern(ind/m));
% Create the weight vector.
wm = m*(kern(ind/m))/den;

% Get the bin heights over smaller bins.
fhatk=zeros(1,nbin);
for k=1:nbin
   ind=k:(2*m+k-2);
   fhatk(k)=sum(wm.*fhat(ind));
end
fhatk = fhatk/(n*h);
bc = t0+((1:k)-0.5)*delta;

% To use the stairs plot, we need to use the 
% bin edges.
fhat = [fhatk fhatk(end)];
stairs(binedge,[fhatk fhatk(end)])
