% -------------------------------------------------------------------------
% Generate PMap of distance to a point
% Input:
%       X, Y: coordinate grids
%       P: the point
%       Mask: the Mask area of operation
%       W: length for caliberating the DMap, for lobe we choose lobe width
%       such as half lobe width
%       Gamma: scale parameter of Cauchy-Lorentzian equation
% Output:
%       PMap: Probability map
function [PMap] = MPMap(X,Y,P,Gamma,W,Mask)
       if nargin < 6
           Mask = true(size(X));
       end
       if isnan(P)
           DMap = ones(size(X));
       else
           DMap = p_dist(X,Y,P)/W;
           DMap(Mask) = Cauchy(DMap(Mask),Gamma);
       end
       DMap(~Mask) = -1;
       PMap = D2P(DMap,Mask);
end