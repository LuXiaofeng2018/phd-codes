% Example 11.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Let's make up a data set - 2-D.
x = [1 1; 1 2; 2 1; -1 -1; -1 -2];
plot(x(:,1),x(:,2),'kx') % plots the points.
axis([-3 3 -3 3])
text(x(:,1)+.1,x(:,2)+.1,'1|2|3|4|5');

% Find the Euclidean distance using pdist.
% Convert to matrix form for easier reading.
ye = pdist(x,'euclid');
ye_mat = squareform(ye);

% Contrast with city block metric.
ycb = pdist(x,'cityblock');
ycb_mat = squareform(ycb);

