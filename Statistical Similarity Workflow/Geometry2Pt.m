% -------------------------------------------------------------------------
% Geometry to points
% input:
%   Geometry: output from ThreshWheeler2D, WCSec(:,:,1) or WCSec(:,:,2)
%   Type: 1 - Deposition pattern, WCSec(:,:,1)
%         2 - Erosion pattern, WCSec(:,:,2)
% output:
%   V: the pattern values at point (X)
function [V,X] = Geometry2Pt(Geometry,Type)
    if Type==1
       [V,X] = max(Geometry,[],2);
    elseif Type==2
       [V,X] = min(Geometry,[],2);
    end
    idx = ~isnan(V);
    V = V(idx);
    X = X(idx);
end