% Example 15.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load bodmin
% Loads data in x and y and boundary in bodpoly.
% Get the Ghat function first and plot.
X = [x,y];
w = 0:.1:10;
n = length(x);
nw = length(w);
ghat = zeros(1,nw);
% The G function is the nearest neighbor 
% distances for each event.
% Find the distances for all points.
dist = pdist(X);
% Convert to a matrix and put large 
% numbers on the diagonal.
D = diag(realmax*ones(1,n)) + squareform(dist);
% Find the smallest distances in each row or col.
mind = min(D);
% Now get the values for ghat.
for i = 1:nw
			ind = find(mind<=w(i));
			ghat(i) = length(ind);
end
ghat = ghat/n;
% Plot the Ghat as a function of w. Shows evidence
% of clustering.
figure,plot(w,ghat,'k')
axis([0 10 0 1.1])
xlabel('Event-Event Distances - w'),ylabel('Ghat')


xx = w;	
m = 75;
nx = length(xx);
fhat = zeros(1,nx);
mind = zeros(1,m);							% one for each point m
xt = [0 0; X];
% The F function is the nearest neighbor distances for 
% randomly selected points. Generate a point, find its
% closest event.
for i = 1:m
			% Generate a point in the region.
			[xt(1,1), xt(1,2)] = csbinproc(bodpoly(:,1),...
				bodpoly(:,2), 1);
			% Find the distances to all events
			dist = pdist(xt);
			% The first n in dist are the distance 
			% between the point(first row) and all the events. 
			% Find the smallest here.
			mind(i) = min(dist(1:n));
end

% Now get the values for fhat
for i = 1:nx
			ind = find(mind<=xx(i));
			fhat(i) = length(ind);
end
fhat = fhat/m;

