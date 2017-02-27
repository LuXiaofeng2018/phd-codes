function [x,y] = csbinproc(xp, yp, n)
% CSBINPROC Generate homogeneous 2-D Poisson process.
%
%   [X,Y] = CSBINPROC(XP,YP,N) This function generates a
%   homogeneous 2-D Poisson process. Conditional on the number
%   of data points N, this is uniformly distributed over the
%   study region. The vectors XP and YP correspond to the x and y
%   vertices of the study region. The vectors X and Y contain
%   the locations for the generated events.
%
%   EXAMPLE:
%   
%   xp = [0 1 1 0];  % vertices for region
%   yp = [0 0 1 1];
%   [X,Y] = csbinproc(xp,yp,100);
%   plot(X,Y,'.')
%
%   See also CSPOISSPROC, CSCLUSTPROC, CSINHIBPROC, CSSTRAUSPROC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


x = zeros(n,1);
y = zeros(n,1);
i = 1;
% find the maximum and the minimum for a 'box' around
% the region. Will generate uniform on this, and throw
% out those points that are not inside the region.
minx = min(xp);
maxx = max(xp);
miny = min(yp);
maxy = max(yp);
cx = maxx-minx;
cy = maxy - miny;
while i <= n
	xt = rand(1)*cx + minx;
	yt = rand(1)*cy + miny;
	k = inpolygon(xt, yt, xp, yp);
	if k == 1
		% it is in the region
		x(i) = xt;
		y(i) = yt;
		i = i+1;
	end
end

	