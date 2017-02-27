% -------------------------------------------------------------------------
% Find the junction of ChannelSource-LobeSource line and the
% region boundary
% Input:
%    P1: channel source coordinate
%    P2: lobe source coordinate
%    xr: x coordinate of model boundary
% Output:
function [Pt] = ChanBoundJunction(P1,P2,xr)
    x1 = P1(1);y1 = P1(2);
    x2 = P2(1);y2 = P2(2);
    A = [-(y2-y1) (x2-x1);...
          1          0   ];
    b = [y1*(x2-x1)-x1*(y2-y1);0];
    y = A\b;
    Pt=[xr,y(2)];