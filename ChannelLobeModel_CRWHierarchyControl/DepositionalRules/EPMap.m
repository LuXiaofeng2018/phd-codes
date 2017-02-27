% -------------------------------------------------------------------------
% Generate PMap of elevation
% Input:
%       Elev: elevation surface
%       Mask: the Mask area of operation
% Output:
%       PMap: Probability map
function [PMap] = EPMap(Elev,Mask)
       if nargin < 2
           Mask = true(size(Elev));
       end
       if length(unique(Elev(:)))==1
           [ny,nx]=size(Elev);
           PMap = -ones(ny,nx);
           PMap(Mask)=1/sum(Mask(:));
           return;
       end
       DMap = max(max(Elev(Mask)))-Elev;
       DMap(~Mask) = -1;
       PMap = D2P(DMap,Mask);
end