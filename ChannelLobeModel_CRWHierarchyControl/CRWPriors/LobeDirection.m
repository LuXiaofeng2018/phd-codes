% given a shifting angle DTheta (0-pi), identify the two options, and find
% the lowest one;
function [VThetaLobe,SimDTheta] = LobeDirection(PVThetaLobe, DTheta, MPP, S, X, Y, L)
    % rotate Theta into two different directions
    [Theta1,SimDTheta1] = RotateLobe(PVThetaLobe,DTheta, MPP, L);

    [Theta2,SimDTheta2] = RotateLobe(PVThetaLobe,-DTheta, MPP, L);

    %% -------------------------------------------------------------------------
    % find elevation of both possible lobe end point and choose the lower one
    DMap1 = sqrt( (X-Theta1(3)).^2+(Y-Theta1(4)).^2 );
    DMap2 = sqrt( (X-Theta2(3)).^2+(Y-Theta2(4)).^2 );
%     figure;imagesc(DMap1);set(gca,'YDir','normal');axis square;
%     figure;imagesc(DMap2);set(gca,'YDir','normal');axis square;

    [minS,iPt] = min(DMap1(:));
    ePt1 = S(iPt);
    [minS,iPt] = min(DMap2(:));
    ePt2 = S(iPt);
    if ePt1 <= ePt2
        VThetaLobe = Theta1;
        SimDTheta = SimDTheta1;
    else
        VThetaLobe = Theta2;
        SimDTheta = SimDTheta2;
    end    
end