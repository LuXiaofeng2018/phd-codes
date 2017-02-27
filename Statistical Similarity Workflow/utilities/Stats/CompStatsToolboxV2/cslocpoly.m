function yhat = cslocpoly(x,y,xo,deg,h)
% CSLOCPOLY     Local polynomial kernel estimator.
%
%   YHAT = CSLOCPOLY(X,Y,XO,DEG,H)
%
%   This performs nomparametric regression using the local
%   polynomial kernel estimator. The observed data are given
%   in X and Y. The domain over which to evaluate the function
%   is given in the vector XO. The degree of the local fit it
%   DEG, and the smoothing is governed by the bandwidth of 
%   the kernel, H.
%
%   EXAMPLE:
%   
%   load salmon
%   x = salmon(:,1);
%   y = salmon(:,2);
%   [xs,inds] = sort(x);
%   ys = y(inds);
%   yhat = cslocpoly(xs,ys,xs,1,75);
%   plot(xs,ys,'.',xs,yhat)
%
%   See also CSLOESS, CSLOCLIN, CSNARDWATS, CSBINSMTH, CSRMEANSMTH,
%   CSSPLINESMTH

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


% we will use the normal for the kernel and to get the weights
% This means that all points get weighted.
mystrg = '(2*pi*h^2)^(-1/2)*exp(-0.5*((x - mu)/h).^2)';
wfun = inline(mystrg);

n = length(x);
no = length(xo);
yhat = zeros(size(xo));
x = x(:);	% so it will be dimensionally compliant
y = y(:);

% get the fit at all points in xo
for i = 1:no
	% center the x values at xo
	xc = x - xo(i);
	w = wfun(h,xo(i),x);	
	% note that xo(i) is the mean, 
	% the kernel is evaluated at all points in x
	W = diag(w);
	A = vander(xc);
	A(:,1:(n-deg-1)) = [];
	V = A'*W*A;
	Y = A'*W*y;
	[Q,R] = qr(V,0); 
	p = R\(Q'*Y); 
	p = p';
	yhat(i) = p(end);
end
