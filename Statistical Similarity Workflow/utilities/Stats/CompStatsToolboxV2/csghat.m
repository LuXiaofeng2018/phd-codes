function ghat = csghat(X,w)
% CSGHAT Estimate of the G function.
%
%   GHAT = CSGHAT(X,W)
%
%   This returns an estimate of the G function withouth taking into
%   account any edge effects. The input argument X contains the event
%   locations. The input argument W is a vector representing the domain
%   over which to evaluate the function Ghat.
%
%   See also CSFHAT, CSKHAT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

n = length(X(:,1));
nw = length(w);
ghat = zeros(1,nw);
% The G function is the nearest neighbor distances for each event.
% Find the distances for all points.
dist = pdist(X);
% convert to a matrix and put large numbers on the diagonal.
D = diag(realmax*ones(1,n)) + squareform(dist);
% Find the smallest distances in each row or col.
mind = min(D);

% Now get the values for ghat
for i = 1:nw
	ind = find(mind<=w(i));
	ghat(i) = length(ind);
end
ghat = ghat/n;