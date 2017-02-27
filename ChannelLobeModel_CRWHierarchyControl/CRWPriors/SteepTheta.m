% -------------------------------------------------------------------------
% find the steepest direction given a point Pt = [x y], a radius d and a
% topographic surface S, which is coordinate by matrix X, Y
function [TopoTheta] = SteepTheta(Pt, d, S, X, Y)

    %% -------------------------------------------------------------------------
    % find distance map
    D2PtMap = sqrt((Pt(1)-X).^2 + (Pt(2)-Y).^2);

    %% -------------------------------------------------------------------------
    % find the ring of given radius
    D2PtMask = (D2PtMap<=d);
    [B,L]=bwboundaries(D2PtMask);
    B = cell2mat(B);
    if ~isempty(B)
        %% -------------------------------------------------------------------------
        % find the steepest point on the ring
        [minS,iPt] = min(D2PtMap(:));
        ePt = S(iPt);
        eCircle = S(sub2ind(size(S),B(:,1),B(:,2)));
        ds = eCircle - ePt;
        [minS,ind] = min(ds);
        minbi = B(ind,1); minbj = B(ind,2);
        %% -------------------------------------------------------------------------
        % return the coordinates
        TopoTheta = [Pt X(minbi,minbj) Y(minbi,minbj)];
    else
        TopoTheta = [Pt Pt];
    end
    
end