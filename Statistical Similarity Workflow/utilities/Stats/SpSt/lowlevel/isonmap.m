function ison = isonmap(X, map)
% ison = isonmap(X, map)
%   
%   Input:  X       Datapoints. Rows are observations, columns are
%                   variables. 
%           map     hyper[quader] map, given by minimum and maximum value in each
%                   dimension. 
%                   A map from -1 to 1 in 3 dimensions would be given by        
%                   map = [-1 -1 -1;1 1 1];
%                   
%   Output: ison    logical array of size mX specifying points (=observations, =rows) 
%                   that are on the map
%
%   Copyright:      Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutica    R = fix(R);l Chemistry
%                   2008

[m n] = size(X);

nmap = size(map,2);

if (not(n == nmap))
    error('isonmap: Data an map dimensions do not match!');
end

minmap = ones(m,1)*map(1,:);
maxmap = ones(m,1)*map(2,:);

under_max = p <= maxmap;    % Are p's coordinates smaller than the upper limit?
over_min = p >= minmap;     % larger than lower limit?

onmap = under_max & over_min; % p larger than lower and smaller than upper limit are on map.

ison = logical(prod(double(onmap,2),2)); % To be on the map, EACH coordinate of p must be between limits.
