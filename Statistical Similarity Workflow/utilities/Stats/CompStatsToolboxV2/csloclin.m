function yhatlin = csloclin(x,y,h)
% CSLOCLIN  Local linear kernel estimator.
%
%   YHAT = CSLOCLIN(X,Y,H)
%   Performs nonparametric regression using the local linear
%   kernel estimator. The observed data are contained in X and Y.
%   The smoothing parameter is given by the kernel bandwidth H.
%   YHAT contains the values of the smooth for each value in X.
%
%   EXAMPLE:
%   
%   load salmon
%   x = salmon(:,1);
%   y = salmon(:,2);
%   [xs,inds] = sort(x);
%   ys = y(inds);
%   yhat = csloclin(xs,ys,50);
%   plot(xs,ys,'.',xs,yhat)
%
%   See also CSLOESS, CSLOCPOLY, CSNARDWATS, CSLOESSR, CSBINSMTH,
%   CSRMEANSMTH, CSSPLINESMTH

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


deg = 1;
% Set up inline function to get the weights.
mystrg = '(2*pi*h^2)^(-1/2)*exp(-0.5*((x - mu)/h).^2)';
wfun = inline(mystrg);
% Set up space to store the estimates.
yhatlin = zeros(size(x));
n = length(x);
% Find smooth at each value in x.
for i = 1:n
		w = wfun(h,x(i),x);
		xc = x-x(i);
		s2 = sum(xc.^2.*w)/n;
        s1 = sum(xc.*w)/n;
		s0 = sum(w)/n;
		yhatlin(i) = sum(((s2-s1*xc).*w.*y)/(s2*s0-s1^2))/n;
end