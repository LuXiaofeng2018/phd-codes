% Example 11.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% Return to the results of Example 11.4.

load insect
% We will look only at the first
% two dimensions in this example.
X = insect(:,1:2);
d = pdist(X);
% Get the linkage.
zc = linkage(d,'complete');

% Plot the raw fusion levels, rather
% than the standardized version of
% Equation 11.16.
nc = 10;
Zf = flipud(zc);
plot(1:10,Zf(1:10,3),'o-')
xlabel('Number of Clusters')
ylabel('Raw Fusion Levels')


