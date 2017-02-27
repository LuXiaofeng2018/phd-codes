% -------------------------------------------------------------------------
% Generate a geobody including Two Sufaces and one facies map
% -------------------------------------------------------------------------
% Input:
%    KPt: Key points for generating the centerline
%    ModelParam: structure of model
% Output:
%    DMap: Distance map
%    Surfaces: Positive & negative surface, and Facies map
%    CXY: centerline Xs and Ys
%    BXY1/BXY2: boundary Xs and Ys
function [DMap,Surfaces,CXY,BXY1,BXY2,ModelParam] = Geobody (KPt, ModelParam)
    OutLineControl = ModelParam.OutLineControl; % for boundary
    GridInfo = ModelParam.GridInfo; % for grid
    SurfPParam = ModelParam.SurfPParam; % for positive surface 
    SurfNCoef = ModelParam.SurfNCoef; % for negative surface
    FaciesParam = ModelParam.FaciesParam;
    p = KPt; % Key points on the centerline
    % ---------------------------------------------------------------------
    % generate outlines given center line control points and
    % boundary geometrical information
    % ---------------------------------------------------------------------
    [b1,b2,cline,LSourceHWidth] = LobeOutline(p(:,1),p(:,2),OutLineControl);
    CXY = cline;
    BXY1 = b1;
    BXY2 = b2;
%     % ---------------------------------------------------------------------
%     % generate boundary to centerline distance map for channel
%     % ---------------------------------------------------------------------
%     pjun = p(3,:); % take the junction of channel and lobe
%     [ChannelDMap] = ChannelDistanceMap(GridInfo,pjun,cline,LSourceHWidth);
    % ---------------------------------------------------------------------
    % generate boundary to channel toe distance map for lobe
    % ---------------------------------------------------------------------
    pjun = p(1,:); % take the junction of channel and lobe
    [LobeDMap] = LobeDistanceMap(GridInfo,pjun,b1,b2,cline);
    % ---------------------------------------------------------------------
    % the total distance map
    % ---------------------------------------------------------------------
%     DMap = -1*ones(size(LobeDMap));
%     idx = ChannelDMap~=-1;
%     DMap(idx) = ChannelDMap(idx);
%     idx = LobeDMap~=-1;
%     DMap(idx) = LobeDMap(idx);
%     idx = DMap>1;
%     DMap(idx)=1;
      DMap = LobeDMap;
%     % ---------------------------------------------------------------------
%     % generate positive/negative surfaces for channel
%     % ---------------------------------------------------------------------
    [ PSurf,NSurf ] = ChannelSurfs(DMap,SurfPParam,SurfNCoef);
    Surfaces = zeros([size(PSurf),3]);
    Surfaces(:,:,1) = PSurf;
    Surfaces(:,:,2) = NSurf;
    % ---------------------------------------------------------------------
    % threshold for the facies
    % ---------------------------------------------------------------------
    FMap = GeobodyFacies(DMap, FaciesParam.Ft,FaciesParam.FTag);
    Surfaces(:,:,3) = FMap;
%     % ---------------------------------------------------------------------
%     ModelParam.OutLineControl = OutLineControl; % for boundary
end








