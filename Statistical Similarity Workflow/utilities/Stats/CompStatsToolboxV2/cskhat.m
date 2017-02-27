function khat = cskhat(x, bound, d)
% CSKHAT Estimate of the K function.
%
%   KHAT = CSKHAT(X,REGION,D)
%   This returns an estimate of the K function. X is a matrix containing
%   the event locations. REGION is a two column matrix of vertices, where
%   the first column coresponds to the x locations and the second to the
%   y locations. D is a vector of distances over which to evaluate the
%   estimate of the K function. 
%
%   See also CSFHAT, CSGHAT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


% function cskhat
% x is the matrix of data: n x 2
% bound is the boundary. It is a two column
% matrix where the first col is the x vertices
% and the second is the y vertices to the boundary.
% d is a vector of distances at which
% to evaluate the estimate of the K function

warning off
% Get some of the constants
n = length(x(:,1));
r = polyarea(bound(:,1),bound(:,2));
maxd = max(d);

% find the distances between all of 
dist = zeros(n*(n-1)/2,1);
wght = zeros(n*(n-1)/2,1);
khat = zeros(size(d));

%[dist,wght] = kwts(x,bound,maxd);

% Find the distances and
% Find all of the weights for those d_ij
% that are less than the maximum in d
for i = 1:(n-1)
	for j = (i+1):n
		% find the distance
		dist((i-1)*(n-i/2)+j-i) = sqrt(sum((x(i,:)-x(j,:)).^2));
		% Find the weight only if the distance is less
		% than the maximum distance in d over which we
		% are estimating the K function.
		if dist((i-1)*(n-i/2)+j-i) <= maxd 
			% Find the points of a circle centered at event i
			% and going through event j.
			[xcir, ycir] = circle(x(i,1),x(i,2),dist((i-1)*(n-i/2)+j-i));
			% Find the points of the circle that are within the region
			ind = find(inpolygon(xcir, ycir, bound(:,1),bound(:,2)));
			% The proportion of the circle that is inside is given by
			wght((i-1)*(n-i/2)+j-i) = length(ind)/length(xcir);
		end
	end
end
% Get a distance matrix.
dist = dist(:)';
wght = wght(:)';
D = squareform(dist);
D = D(:);
W = 1./squareform(wght);
W = W(:);
% Find the K function for each value in d
for k = 1:length(d)
	% find the distances 
	ind = find(D <= d(k) & D > 0);
	% Add up the corresponding weights.
	khat(k) = sum(W(ind));
end
khat = khat*r/(n^2);
warning on
			
			
		
% It will give the points on a circle given
% center and the radius.
% function = circle(xc,yc,r)
function [x,y] = circle(xc,yc,r)

t=0:.25:2*pi;
x=xc+r*cos(t);
y=yc+r*sin(t);

