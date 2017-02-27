function csplotuni(pies,mus,vars,xleft,xright,npts)  
% CSPLOTUNI     Plot the density from a univariate finite mixture.
%
%   CSPLOTUNI(WTS,MUS,VARS,XMIN,XMAX,NPTS)
%   This function plots the function corresponding to a univariate
%   finite mixture.
%
%   INPUTS: WTS: Vector of weights for each component density
%           MUS: Vector of means for each density
%           VARS: Vector of variances for each density
%           XMIN,XMAX: Lower and upper end points of the domain over which to plot
%           NPTS: Number of points in the domain to plot
%
%

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


nterms = length(pies);
t=xleft:(xright-xleft)/npts:xright;
y=zeros(size(t));
for i=1:nterms
	y=y+pies(i)*exp(-.5*(t-mus(i)).^2/vars(i))/((2*pi*vars(i))^.5);
end
plot(t,y)
