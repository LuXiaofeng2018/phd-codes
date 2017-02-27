function [x,y] = csinhibproc(xp,yp,delta,n)
% CSINHIBPROC Generates an inhibition spatial process.
%
%   [X,Y] = CSINHIBPROC(XP,YP,DELTA,N)
%
%   This function returns X and Y locations that follow
%   an inhibition process. XP and YP are the vertices of
%   the boundary region. DELTA is the inhibition distance.
%   N is the number of points to generate.
%
%   See also CSPOISSPROC, CSBINPROC, CSCLUSTPROC, CSSTRAUSPROC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

if delta <= 0
    error('Delta must be positive.')
end


X = zeros(n,2);
% Generate the first point
X(1,:) = csbinproc(xp,yp,1);

i = 1;
while i<n
	[sx,sy] = csbinproc(xp, yp, 1);
	xt = [sx sy ; X(1:i,:)];
	% Find the distance between the events
	dist = pdist(xt);
	% Find the distance between the candidate event
	% and the others that have been generated already.
	ind = find(dist(1:i) <= delta);
	if isempty(ind)
		% Then ok to keep the point
		i = i+1;
		X(i,:) = [sx, sy];
	end
end

x = X(:,1);
y = X(:,2);