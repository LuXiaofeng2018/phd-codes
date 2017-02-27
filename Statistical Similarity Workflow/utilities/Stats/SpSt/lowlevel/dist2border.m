function d = dist2border(X, map)
% d = dist2border(X, map, mode)
%
%   Input:  X       Datapoints. Rows are observations, columns are
%                   variables.
%
%           map     hyper[quader] map, given by minimum and maximum value in each
%                   dimension. 
%                   A map from -1 to 1 in 3 dimensions would be given by        
%                   map = [-1 -1 -1 1;1 1 1];
%
%   Output: d       minimum distance for each point (=observation) to 
%                   any border of the map.
%                   NOTE: Since maps are hypercubic, the minimum distance
%                   to any border will always be perpendicular to the
%                   border. Therefore Euclidean, Chebychev and City-Block
%                   distance are identical.
%
%
%   Copyright:      Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008



[m n] = size(X);

mapmin = ones(m,1)*map(1,:);
mapmax = ones(m,1)*map(2,:);

dist1 = abs(mapmin - X);
dist2 = abs(mapmax - X);


d1 = min(dist1, [], 2);
d2 = min(dist2, [], 2);

d = min([d1 d2], [], 2);