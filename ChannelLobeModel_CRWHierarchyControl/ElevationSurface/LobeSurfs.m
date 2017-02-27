% -------------------------------------------------------------------------
% generate channel positive/negative surfaces for channel
% -------------------------------------------------------------------------
function [PSurf, NSurf] = LobeSurfs(DMap,LPSParam,LRCoef,CPSParam,CRCoef)
    % parameter for positive surface
    ChannelH1 = CPSParam.H1; % highest point fo positive surface
    ChannelCenter1 = CPSParam.C1; % center point of positive surface
    ChannelSpan1 = CPSParam.S1; % span of positive surface
    % coefficients correlating positive and negative surfaces
    R_ChannelH = CRCoef.R_H;
    R_ChannelCenter = CRCoef.R_C;
    R_ChannelSpan = CRCoef.R_S;
    % parameter for negative surface
    ChannelH2 = ChannelH1*R_ChannelH; % lowest point fo negative surface
    ChannelCenter2 = ChannelCenter1*R_ChannelCenter; % center point of negative surface
    ChannelSpan2 = ChannelSpan1*R_ChannelSpan; % span of negative surface
    % parameters for the positive lobe surface
    LobeH1 = LPSParam.H1; % highest point fo positive lobe surface
    LobeCenter1 = LPSParam.C1; % center point of positive lobe surface
    LobeSpan1 = LPSParam.S1; % span of positive lobe surface
    % LobeSkew1 = 0.6; % skew ratio of positive lobe surface
    LobeSkew1 = sqrt(- LobeCenter1^2/2/LobeSpan1^2/log(ChannelH1/LobeH1)); % skew ratio of positive lobe surface
    % coefficients correlating positive and negative surfaces
    R_LobeH = LRCoef.R_H;
    R_LobeCenter = LRCoef.R_C;
    R_LobeSpan = LRCoef.R_S;
    % R_LobeSkew = 1;
    % parameters for the negative lobe surface
    LobeH2 = LobeH1*R_LobeH; % highest point fo negative lobe surface
    LobeCenter2 = LobeCenter1*R_LobeCenter; % center point of negative lobe surface
    LobeSpan2 = LobeSpan1*R_LobeSpan; % span of negative lobe surface
    % LobeSkew2 = LobeSkew1*R_LobeSkew; % skew ratio of negative lobe surface
    LobeSkew2 = sqrt(- LobeCenter2^2/2/LobeSpan2^2/log(ChannelH2/LobeH2)); % skew ratio of positive lobe surface
    % generate surfaces
    Mask = DMap~=-1;
    PSurf = zeros(size(DMap));
    NSurf = zeros(size(DMap));
    % positive surface
    idx1 = (DMap>=LobeCenter1);
    PSurf(idx1&Mask) = LobeH1*exp(-(DMap(idx1&Mask)-LobeCenter1).^2/2/LobeSpan1^2);
    PSurf((~idx1)&Mask) = LobeH1*exp(-(DMap((~idx1)&Mask)-LobeCenter1).^2/2/LobeSpan1^2/LobeSkew1^2);
    PSurf(~Mask)=NaN;
    % negative surface
    idx2 = (DMap>=LobeCenter2);
    NSurf(idx2&Mask) = LobeH2*exp(-(DMap(idx2&Mask)-LobeCenter2).^2/2/LobeSpan2^2);
    NSurf((~idx2)&Mask) = LobeH2*exp(-(DMap((~idx2)&Mask)-LobeCenter2).^2/2/LobeSpan2^2/LobeSkew2^2);
    NSurf(~Mask)=NaN;
end