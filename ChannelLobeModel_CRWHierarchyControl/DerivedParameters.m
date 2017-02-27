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
% Prior cdfs
PriorCdfs = load(PriorcdfPath);
% Simulation records
SimRecord.MPP = nan(SimParam.NEvent+1,2); % MPP sequence coordinates
% rand some first point along the given direction
[SimRecord.MPP(1,:)] = LobeKeyPoints...
    ([ProcParam.VBTheta(1:2);ProcParam.VBTheta(3:4)],0, emprand(PriorCdfs.dRMPP));

SimRecord.DMPP = nan(SimParam.NEvent+1,1); % DMPP sequence
SimRecord.TMPP = nan(SimParam.NEvent+1,1); % TMPP sequence
SimRecord.TLobe = nan(SimParam.NEvent+1,1); % TLobe sequence
SimRecord.VTMPP = nan(SimParam.NEvent+1,4); % Vector of TMPP sequence
SimRecord.VTMPP(1,:) = ProcParam.VBTheta;
SimRecord.VTLobe = nan(SimParam.NEvent+1,4); % Vector of VTLobe sequence
SimRecord.VTLobe(1,:) = ProcParam.VBTheta;
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

RuntimeParam.PMPP = SimRecord.MPP(1,:); % set the initial previous MPP to basin source
RuntimeParam.PVMPPTheta = SimRecord.VTMPP(1,:); % set the initial previous MPP migrating theta to basin flow orientaion
RuntimeParam.PVLobeTheta = SimRecord.VTLobe(1,:); % set the initial previous lobe orienataion to 

% parameters for prior sampling outputs
RuntimeParam.SimMPP = nan(1,2);
RuntimeParam.SimDMPP = nan(1,1);
RuntimeParam.SimTLobe = nan(1,1);
RuntimeParam.SimVThetaLobe = nan(1,4);

%
ModelParam.OutLineControl = OutLineControl;
ModelParam.GridInfo = GridInfo;
ModelParam.PriorCdfs = PriorCdfs;
ModelParam.SimRecord = SimRecord;
ModelParam.SurfPParam = SurfPParam;
ModelParam.SurfNCoef = SurfNCoef;
ModelParam.FaciesParam = FaciesParam;
ModelParam.ProcParam = ProcParam;
ModelParam.SimParam = SimParam;
ModelParam.RuntimeParam = RuntimeParam;