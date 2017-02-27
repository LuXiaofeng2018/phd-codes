% Example 15.14
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

delta = 0.1;
% Get the vertices for the regions.
rx = [0 1 1 0 0];
ry = [0 0 2 2 0];
% Set number of data points.
n = 100;
% Set the inhibition parameter.
c = 0.5;
X = zeros(n,2);
% Generate the first point.
X(1,:) = csbinproc(rx,ry,1);

i = 1;
while i<n
		[sx,sy] = csbinproc(rx, ry, 1);
		xt = [sx sy ; X(1:i,:)];
		% Find the distance between the events.
		dist = pdist(xt);
		% Find the distance between the candidate event
		% and the others that have been generated already.
		ind = find(dist(1:i) <= delta);
		m = length(ind);
		if m == 0
			% Then ok to keep the point - nothing is close.
			i = i+1;
			X(i,:) = [sx, sy];
		elseif rand(1) <= c^m
			% The ok to keep the point.
			i = i+1;
			X(i,:) = [sx, sy];
		end
end
