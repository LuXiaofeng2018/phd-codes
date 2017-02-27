% Example 15.13
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

delta = 0.1;
% Get the vertices for the regions.
rx = [0 2 2 0 0];
ry = [0 0 2 2 0];
n = 100;

X = zeros(n,2);
% Generate the first event.
X(1,:) = csbinproc(rx,ry,1);
i = 1;
% Generate the other events.
while i<n
		[sx,sy] = csbinproc(rx, ry, 1);
		xt = [sx sy ; X(1:i,:)];
		% Find the distance between the events
		dist = pdist(xt);
		% Find the distance between the candidate event
		% and the others that have been generated already.
		ind = find(dist(1:i) <= delta);
		if isempty(ind)
			% Then we keep the event.
			i = i+1;
			X(i,:) = [sx, sy];
		end
end
% Verify that all are no closer than the 
% inhibition distance.
dist = pdist(X);
delhat = min(dist);
