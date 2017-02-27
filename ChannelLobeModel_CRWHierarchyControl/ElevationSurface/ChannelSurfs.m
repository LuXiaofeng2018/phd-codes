% -------------------------------------------------------------------------
% generate channel positive/negative surfaces for channel
% -------------------------------------------------------------------------
function [PSurf, NSurf] = ChannelSurfs(DMap,PSParam,RCoef)
    % parameter for positive surface
    ChannelH1 = PSParam.H1; % highest point fo positive surface
    ChannelCenter1 = PSParam.C1; % center point of positive surface
    ChannelSpan1 = PSParam.S1; % span of positive surface
    % coefficients correlating positive and negative surfaces
    R_ChannelH = RCoef.R_H;
    R_ChannelCenter = RCoef.R_C;
    R_ChannelSpan = RCoef.R_S;
    % parameter for negative surface
    ChannelH2 = ChannelH1*R_ChannelH; % lowest point fo negative surface
    ChannelCenter2 = ChannelCenter1*R_ChannelCenter; % center point of negative surface
    ChannelSpan2 = ChannelSpan1*R_ChannelSpan; % span of negative surface
    % generate surfaces
    Mask = DMap~=-1;
    PSurf = zeros(size(DMap));
    NSurf = zeros(size(DMap));
    PSurf(Mask) = ChannelH1*exp(-(DMap(Mask)-ChannelCenter1).^2/2/ChannelSpan1^2);
    PSurf(~Mask)=NaN;
    NSurf(Mask) = ChannelH2*exp(-(DMap(Mask)-ChannelCenter2).^2/2/ChannelSpan2^2);
    NSurf(~Mask)=NaN;
end