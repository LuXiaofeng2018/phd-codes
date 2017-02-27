% Example 9.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load snowfall
n=length(snowfall);
m=30;
h=14.6;
delta=h/m;

% Get the mesh.
t0 = 0;
tf = max(snowfall)+20;
nbin = ceil((tf-t0)/delta);
binedge = t0:delta:(t0+delta*nbin);

% Get the bin counts for the smaller binwidth delta.
vk = histc(snowfall,binedge);
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
stairs(binedge,[fhatk fhatk(end)])
axis square
title('ASH - Buffalo Snowfall Data')
xlabel('Snowfall (inches)')
