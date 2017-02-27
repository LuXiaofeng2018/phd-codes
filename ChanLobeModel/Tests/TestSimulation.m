%% ------------------------------------------------------------------------
% test simulation
% ------------------------------------------------------------------------
run('..\EnviSetting');
%% ------------------------------------------------------------------------
% Initial parameters
% -------------------------------------------------------------------------
InitParameters;
%% ------------------------------------------------------------------------
% Derivative parameters
% -------------------------------------------------------------------------
DerivedParameters;
%% ------------------------------------------------------------------------
% Initialized Surface Cubes
% -------------------------------------------------------------------------
FCube = zeros(ny,nx,SimParam.NEvent);
PCube = zeros(ny,nx,SimParam.NEvent);
NCube = zeros(ny,nx,SimParam.NEvent);
LSPt = zeros(SimParam.NEvent,2);
fhpmap = figure;
fhsurf = figure;
% -------------------------------------------------------------------------
for i=1:SimParam.NEvent
    %% --------------------------------------------------------------------
    % Generate centerline key points
    ModelParam = GeobodyCenterLine(ModelParam);
    % ---------------------------------------------------------------------
    % Generate all surfaces (Positive, Negative, Facies) for a geobody
    [DMap,Surfaces,cline,b1,b2,ModelParam] =...
                            Geobody(ModelParam.RuntimeParam.CPt,ModelParam);
    PSurf = Surfaces(:,:,1);
    PSurf(isnan(PSurf))=0;
    NSurf = Surfaces(:,:,2);
    NSurf(isnan(NSurf))=0;
    FMap = Surfaces(:,:,3);
    % ---------------------------------------------------------------------
    % Update current surface and save geobody
    ModelParam.RuntimeParam.CurrentSurf = ModelParam.RuntimeParam.CurrentSurf + NSurf + PSurf;
    PCube(:,:,i) = PSurf;
    NCube(:,:,i) = NSurf;
    FCube(:,:,i) = FMap;
    LSPt(i,:) = ModelParam.RuntimeParam.CPt(3,:);
    i
    % ---------------------------------------------------------------------
    % plot each component
    figure(fhpmap);
%     set(gcf, 'Position', get(0,'Screensize')); 
%     ax1 = subplot(2,3,1);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PSMap);
%     title('Source PMap');
%     set(ax1,'YDir','normal');
%     colorbar;
    ax1 = subplot(2,3,1);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PSMap);
    title('Source PMap & All Simulated Lobe Centers');
    set(ax1,'YDir','normal');
    set1x = cline(:,1); set1y = cline(:,2);
    bx1 = b1(:,1);bx2 = b2(:,1);
    by1 = b1(:,2);by2 = b2(:,2);
    p = ModelParam.RuntimeParam.CPt;
    hold on;
    plot(LSPt(:,1),LSPt(:,2),'.k','MarkerSize',10);
    plot(p(3,1),p(3,2),'.r','MarkerSize',20);
    hold off;
    axis([min(ModelParam.GridInfo.x) max(ModelParam.GridInfo.x) ...
          min(ModelParam.GridInfo.y) max(ModelParam.GridInfo.y)]);
    axis square;
    ax2 = subplot(2,3,2);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PCMap,...
        'Alphadata',ModelParam.RuntimeParam.PCMap>-1);
    set(ax2,'YDir','normal');
    minC = unique(min(ModelParam.RuntimeParam.PCMap(ModelParam.RuntimeParam.PCMap>-1)));
    maxC = unique(max(ModelParam.RuntimeParam.PCMap(ModelParam.RuntimeParam.PCMap>-1)));
    if minC==maxC
        minC = minC-minC/2;
        maxC = maxC+maxC/2;
    elseif ~isempty([minC maxC])
        caxis([minC maxC]);
    end
    % colorbar;
    hold on;
    plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
    hold off;
    title('Channel MidPoint PMap');
    axis square;
    ax3 = subplot(2,3,3);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PLMap);
    set(ax3,'YDir','normal');
    % colorbar;
    title('Lobe Source PMap');
    axis square;
    ax4 = subplot(2,3,4);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PTMap);
    set(ax4,'YDir','normal');
    % colorbar;
    title('Depo Thickness PMap');
    axis square;
    % plot combined pmap
    ax5 = subplot(2,3,5);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PMap);
    set(ax5,'YDir','normal'); 
    hold on;
    plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
    hold off;
    title('Combined PMap');
    % colorbar;
    axis square;
    ax6 = subplot(2,3,6);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,PSurf,'Alphadata',PSurf>0);
    set(ax6,'YDir','normal'); 
    hold on;
    plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
    hold off;
    title('Simulated Positive Surface');
    % colorbar;
    hold on;
    plot(p(:,1),p(:,2),'.','MarkerSize',30);
    plot(set1x,set1y,'.k-','LineWidth',3);
    plot(bx1,by1,'.-b');
    plot(bx2,by2,'.-r');
    hold off;
    axis square;
    % ---------------------------------------------------------------------
    figure(fhsurf);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.CurrentSurf);shading flat;
%     axis([0 max(ModelParam.GridInfo.x) 0 max(ModelParam.GridInfo.y)]);
%     caxis([min(ModelParam.FaciesParam.FTag) max(ModelParam.FaciesParam.FTag)]);
%     colormap(redgreencmap);
    % colorbar;
    % set(gca,'XTickLabel','','YTickLabel','');
    title(sprintf('Elevation at ie = %d',i),'FontSize',20);
%     set(gcf, 'Position', get(0,'Screensize')); 
    set(gca,'YDir','normal');
    axis square;
    pause(0.02);
end
% build up the sequence cube
ECube = zeros(ny,nx,SimParam.NEvent*2);
ECube(:,:,1:2:end-1)=NCube;
ECube(:,:,2:2:end)=PCube;
% take out slice 50
ns = 50;
CSec = squeeze(ECube(:,ceil(ns),:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 100
ns = 100;
CSec = squeeze(ECube(:,ceil(ns),:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 150
ns = 150;
CSec = squeeze(ECube(:,ceil(ns),:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 200
ns = 200;
CSec = squeeze(ECube(:,ceil(ns),:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% % take out slice 250
% ns = 250;
% CSec = squeeze(ECube(:,ceil(ns),:))';
% WCSec = repmat(CSec,[1 1 2]);
% WCSec(1:2:end-1,:,1)=0;
% WCSec(2:2:end,:,2)=0;
% WCSec(WCSec==0)=nan;
% fh = GeometricWheeler2D(WCSec);
% title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));