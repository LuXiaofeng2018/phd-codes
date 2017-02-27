% ---------------------------------------------------------------------
% point from PMap
%       Input:
%           x,y: coordinate array along each direction
%           map: probability map
%           Mask
%       Output:
%           p: point drawn from the map
function [p] = PtFromPMap(x,y,map,Mask)
    if nargin <4
        Mask = true(size(map));
    end
    map(~Mask)=0;
    [px,py]=pinky(x,y,map);
    p=[px py];
end