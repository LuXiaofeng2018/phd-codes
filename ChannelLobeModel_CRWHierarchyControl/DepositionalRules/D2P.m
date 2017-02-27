%--------------------------------------------------------------------------
%   Convert a 2d map from distance to Pmap so that they are between 0 and 1
%--------------------------------------------------------------------------
function [ map_norm ] = D2P( map, Mask)
       if nargin < 2
           Mask = true(size(map));
       end
       map_norm = ones(size(map));
       map_norm(Mask) = map(Mask)/sum(sum(map(Mask)));
       map_norm(~Mask) = -1;
end
