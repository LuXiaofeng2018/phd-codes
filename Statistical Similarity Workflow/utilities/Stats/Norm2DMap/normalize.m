%--------------------------------------------------------------------------
%   normalize a 2d map so that sum of elements is 1
%--------------------------------------------------------------------------
function [ map_norm ] = normalize( map )
% idx = map>0;
map_norm = map/sum(map(:));
if isnan(map_norm(:))
    map_norm = ones(size(map));
end
% if they are all the same
if length(unique(map_norm(:)))==1
    map_norm = ones(size(map));
end
end

