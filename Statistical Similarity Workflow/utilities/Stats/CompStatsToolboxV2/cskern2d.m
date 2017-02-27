function [X,Y,Z,H]=cskern2d(data,gridx,gridy,h)
% CSKERN2D	Bivariate product kernel density estimate.
%
%	[X,Y,Z,H] = CSKERN2D(DATA,GRIDX,GRIDY,H)
%
%	This returns an estimate using the product kernel method.
%	This does the bivariate case only, since the main purpose
%	of it is to plot using MATLAB functions MESH or SURF.
%	DATA is an n x d matrix of observations.
%	GRIDX and GRIDY are the grid sizes.
%	H is an optional 2-element vector of window widths. The
%	default value for H is the value obtained from the Normal Reference Rule.
%
%   EXAMPLE:
%
%   X = randn(100,2);
%   [x,y,z,h] = cskern2d(X,0.3,0.3);
%   surf(x,y,z)
%
%	See also CSKERNMD

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

% use Scott's rule to get the h widths
[n,p] = size(data);
if nargin == 3
	% Get the window widths using Normal Reference Rule.
	s = cov(data);
	hx = s(1,1)*n^(-1/6);
	hy = s(2,2)*n^(-1/6);
else
	hx = h(1);
	hy = h(2);
end

% Get the ranges for x and y
minx=min(data(:,1));
maxx=max(data(:,1));
miny=min(data(:,2));
maxy=max(data(:,2));
[X,Y]=meshgrid((minx-2*hx):gridx:(maxx+2*hx),(miny-2*hy):gridy:(maxy+2*hy));
x=X(:);   %put into col vectors
y=Y(:);
z=zeros(size(x));	%these will be max values & color

for i=1:length(x)	% note that const done at end
	xloc=x(i)*ones(n,1);
	yloc=y(i)*ones(n,1);
	argx=((xloc-data(:,1))/hx).^2;
	argy=((yloc-data(:,2))/hy).^2;
	z(i)=(sum(exp(-.5*(argx+argy))))/(n*hx*hy*2*pi);
end

[mm,nn]=size(X);
Z=reshape(z,mm,nn);

H = [hx, hy];
