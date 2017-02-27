%% ------------------------------------------------------------------------
% Setting Initial Parameters
% -------------------------------------------------------------------------
% simulation
SimParam.NEvent = 50;
% grid
nx = 200; ny = 200; dx = 10;
% geometry outline
OutLineControl.L = 1500; 
OutLineControl.f_w = 0.7; % LobeW/LobeL ratio
OutLineControl.f_LOffset = 0.15; % Offset of lobe source to the oval origin
OutLineControl.oval_control = -0.5; % Degree of the oval
% Positive surface
SurfPParam.f_H1 = 0.5*1e-3; % highest point fo positive surface
SurfPParam.C1 = 0; % center point of positive surface
SurfPParam.S1 = 0.25; % span of positive surface
% Correlating positive and negative surfaces
SurfNCoef.R_H = -0.6;
SurfNCoef.R_C = 1;
SurfNCoef.R_S = 1;
% Facies map
FaciesParam.Ft = [0.6]; % Threshold of facies change based on the distance map
FaciesParam.FTag = [1,0]; % facies tags one more element than FaciesParam.Ft
% Process
% ProcParam.Source = [-300,600]; % channel source center x,y coordinate
% ProcParam.Source = [-5656.9,7656.9]; % channel source center x,y coordinate
ProcParam.Source = [-500,2500]; % channel source center x,y coordinate
ProcParam.WSource = 25; % source region width
ProcParam.VTheta = 10; % general flow orientation
ProcParam.SW = 2000; % system hald width, the half width of the depo system,
                     % such as the fan, lobe complex, lobe, depending on
                     % the scale you are modeling
% RunTime
RuntimeParam.Tau = ...
    [1 ... % source component weight
     1 ... % lobe center component weight
     1]; % depo thickness component weight
RuntimeParam.Gamma = 2;% controling the stacking pattern
RuntimeParam.f_WCBelt = 1; % potential channel belt width
RuntimeParam.CBeltMask = []; % Mask for potential belt region
RuntimeParam.CW = []; % channel hald width