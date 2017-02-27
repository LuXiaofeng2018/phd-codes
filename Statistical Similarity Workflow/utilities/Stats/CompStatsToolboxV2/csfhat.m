function fhat = csfhat(X,x,m,bound)
% CSFHAT Estimate of the F function.
%
%   FHAT = CSFHAT(X,DOM,M,REGION)
%
%   This function returns an estimate of the F function, ignoring
%   edge effects. The input argument X contains the event locations.
%   DOM contains the domain over which to evaluate the FHAT function.
%   M specifies the number of random points in the region to sample.
%   REGION is the boundary of the study region.
%
%   See also CSGHAT, CSKHAT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

n = length(X(:,1));
nx = length(x);
fhat = zeros(1,nx);
mind = zeros(1,m);	% one for each point m
xt = [0 0; X];
% The F function is the nearest neighbor distances for 
% randomly selected points. Generate a point, find its
% closest event.
for i = 1:m
	% Generate a point in the region.
	[xt(1,1), xt(1,2)] = csbinproc(bound(:,1), bound(:,2), 1);
	% Find the distances to all events
	dist = pdist(xt);
	% The first n in dist are the distance between the point
	% (first row) and all the events. Find the smallest here.
	mind(i) = min(dist(1:n));
end

% Now get the values for fhat
for i = 1:nx
	ind = find(mind<=x(i));
	fhat(i) = length(ind);
end
fhat = fhat/m;