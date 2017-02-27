%--------------------------------------------------------------------------
%   generate distance map withing meshgrid X, Y, relative to point P
%Input: 
%   meshgrid X, Y, point coordinates P
%output:
%   distance proximity map
%--------------------------------------------------------------------------
function [ d_map ] = p_dist( X,Y,P )

d_map = sqrt((X-P(1)).^2+(Y-P(2)).^2);

end

