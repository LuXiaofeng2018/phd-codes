% -------------------------------------------------------------------------
% Input:
%      Line: 2*2 array of the defined line, Line(1,:) are the two xs,
%      Line(2,:) are the two ys
%      points defining the line
%      f_WBelt: half width of the channel belt, in the range of [0,1]. 1 is
%      the farthest
%      X,Y: coordinate grids of the simulation grid
% Output:
%      CBeltMask: mask of the channel belt region
function [CBeltMask, CBeltHDMap, CBeltPDMap,aL2,bL2,cL2] = ChannelBelt(Line,f_WBelt,X,Y)
       % calculate DMap to the line
       x1 = Line(1,1); y1 = Line(1,2);
       x2 = Line(2,1); y2 = Line(2,2);
       aL1 = y1-y2;
       bL1 = x2-x1;
       cL1 = y1*(x1-x2)-x1*(y1-y2);
       CBeltHDMap = abs(aL1*X+bL1*Y+cL1)/sqrt(aL1^2+bL1^2);
       % calculate direct distance from channel source to lobe source
       L = sqrt((x2-x1)^2+(y2-y1)^2);
       WBelt = f_WBelt*L/2;
       % normalize the DMap
%        CBeltHDMap = CBeltHDMap./max(CBeltHDMap(:));
       CBeltMask = ones(size(CBeltHDMap));
       CBeltMask(CBeltHDMap>WBelt)=0;
       % mid point of the segment
       x3 = (x1+x2)/2;y3 = (y1+y2)/2;
       aL2 = bL1;
       bL2 = -aL1;
       cL2 = aL1*y3-bL1*x3;
       CBeltPDMap = abs(aL2*X+bL2*Y+cL2)/sqrt(aL2^2+bL2^2);
       WPBelt = 0.25*sqrt((x1-x2)^2+(y1-y2)^2);
       CBeltMask(CBeltPDMap>WPBelt)=0;
       CBeltMask = logical(CBeltMask);
