% -------------------------------------------------------------------------
% Given a centerline, generate the projected center
% Input:
%       CtrLineX: x coordinates of the centerline
%       CtrLineY: y coordinates of the centerline
% Output:
%       StraightDistance:
%       LineDistance
% -------------------------------------------------------------------------
function [ StraightDistance, LineDistance ] = ProjectedDistance( CtrLineX, CtrLineY)
        P = [CtrLineX(1) CtrLineY(1)]; R = [CtrLineX(end) CtrLineY(end)];
        Q = [CtrLineX',CtrLineY'];
        % get the squared point-segment distance
        [sqr_psd, I]=csmv(P,R,Q);
        sqr_ped = (CtrLineX-P(1)).^2+(CtrLineY-P(end)).^2;
        StraightDistance = sqrt(sqr_ped - sqr_psd);
        % get the Euclidean distance from a centerline point to the channel
        % source
        LineDistance = zeros(size(CtrLineX));
        dX = diff(CtrLineX); dY = diff(CtrLineY);
        dD = sqrt(dX.^2+dY.^2);
        dD = cumsum(dD);
        LineDistance(2:end) = dD;
end