% Example 6.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This shows the use of ISOMAP.
% Apply ISOMAP to the glass data.

% First load the data.
load glassdata
% Then get the interpoint distance matrix.
% We will use standardized Euclidean distance.
tmp = pdist(glassdata,'seuclidean');
% Now put it into a square matrix.
D = squareform(tmp);

% Now we do ISOMAP. Code is available
% from Tenenbaum, de Silva, and Langford (2000).
% We will define the neighborhood using the
% number of nearest neighbors, k = 5.
[Y,R,E] = isomap(D,'k',5);

% We need to extract the data from structure Y.
% Scree plot shows that a value of 3 is a good one.
X3 = Y.coords{3}';
% Plot the data in a scatterplot matrix.
plotmatrix(X3);
