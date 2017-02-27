%% ------------------------------------------------------------------------
% Setting Initial Parameters
% -------------------------------------------------------------------------
% simulation
SimParam.NEvent = 140;
% grid
nx = 200; ny = 200; dx = 2;
% Input lobe migration sequence
PriorcdfPath = 'Priorcdfs_296LobeCaseTankA.mat';

% geometry outline
OutLineControl.L = 120; 
OutLineControl.f_w = 0.7; % LobeW/LobeL ratio
OutLineControl.f_LOffset = 0; % Offset of lobe source to the oval origin
OutLineControl.oval_control = -0.1; % Degree of the oval
% Positive surface
SurfPParam.f_H1 = 5*1e-2; % highest point fo positive surface
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
ProcParam.Source = [nx*dx/2 ny*dx]; % channel source center x,y coordinate
ProcParam.WSource = 10; % source region width
ProcParam.VTheta = 0; % variance range of flow orientation
ProcParam.VBTheta = [ProcParam.Source nx*dx/2 (ny-1)*dx]; % Vector of basin flow orientation
% RunTime
RuntimeParam.Tau = ...
    [1 ... % source component weight
     1 ... % lobe center component weight
     1]; % depo thickness component weight
RuntimeParam.Gamma = 2;% controling the stacking pattern
RuntimeParam.f_WCBelt = 1; % potential channel belt width
RuntimeParam.CBeltMask = []; % Mask for potential belt region
RuntimeParam.CW = []; % channel half width

RuntimeParam.bMPP = 0.5; % combination factor for MPP migration direction
RuntimeParam.kaiMPP = 0.6; % parameter for Cauchy distribution
RuntimeParam.rangeMPP = [0 2*pi]; % parameter for sampling from Cauchy distribution
