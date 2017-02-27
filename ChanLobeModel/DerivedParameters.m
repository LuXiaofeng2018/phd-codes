%% ------------------------------------------------------------------------
% Setting Derived Parameters
% -------------------------------------------------------------------------
% grid
x = [0:nx-1]*dx; y = [0:ny-1]*dx;
GridInfo.nx = nx;
GridInfo.x = x;
GridInfo.ny = ny;
GridInfo.y = y;
GridInfo.dx = dx;
GridInfo.BotSurf = zeros(ny,nx); % flat bottom surface
[GridInfo.X, GridInfo.Y]=meshgrid(x,y); % coordinate grid
% Outline
OutLineControl.W = OutLineControl.L*OutLineControl.f_w; % lobe width
% SurfPParam
SurfPParam.H1 = SurfPParam.f_H1*OutLineControl.L;
% Process
ProcParam.SXRange = [ProcParam.Source(1)-ProcParam.WSource,ProcParam.Source(1)+ProcParam.WSource];
ProcParam.SYRange = [ProcParam.Source(2)-ProcParam.WSource,ProcParam.Source(2)+ProcParam.WSource];
% Runtime
RuntimeParam.PAMap = 1/(ny*nx)*ones(ny,nx); % Initial probability P(A)
RuntimeParam.PSMap = zeros(ny,nx); % Source component map
RuntimeParam.PCMap = zeros(ny,nx); % Prev Channel component map
RuntimeParam.PLMap = zeros(ny,nx); % Prev Lobe component map
RuntimeParam.PTMap = zeros(ny,nx); % Prev Thickness component map
RuntimeParam.PMap = zeros(ny,nx); % Combined PMap
RuntimeParam.PDiMap(:,:,1) = RuntimeParam.PAMap;
RuntimeParam.PDiMap(:,:,2) = RuntimeParam.PSMap;
RuntimeParam.PDiMap(:,:,3) = RuntimeParam.PLMap;
RuntimeParam.PDiMap(:,:,4) = RuntimeParam.PTMap;

RuntimeParam.CPt =nan(5,2); % array for centerline key points
RuntimeParam.CurrentSurf = GridInfo.BotSurf; % set initial surface as the current surface
% Surfaces
ModelParam.OutLineControl = OutLineControl;
ModelParam.GridInfo = GridInfo;
ModelParam.SurfPParam = SurfPParam;
ModelParam.SurfNCoef = SurfNCoef;
ModelParam.FaciesParam = FaciesParam;
ModelParam.ProcParam = ProcParam;
ModelParam.SimParam = SimParam;
ModelParam.RuntimeParam = RuntimeParam;