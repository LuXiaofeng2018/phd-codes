%% ------------------------------------------------------------------------
% test simulation
% ------------------------------------------------------------------------
run('..\EnviSetting');
safeimg = true;
safeimg = false;
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
    % Simulation records
    ModelParam.SimRecord.MPP(i+1,:) = ModelParam.RuntimeParam.SimMPP;
    ModelParam.SimRecord.DMPP(i+1,:) = ModelParam.RuntimeParam.SimDMPP;
    ModelParam.SimRecord.TLobe(i+1,:) = ModelParam.RuntimeParam.SimTLobe;
    ModelParam.SimRecord.VTLobe(i+1,:) = ModelParam.RuntimeParam.SimVThetaLobe;
    % ---------------------------------------------------------------------
    % Generate all surfaces (Positive, Negative, Facies) for a geobody
    [DMap,Surfaces,cline,b1,b2,ModelParam] =...
                            Geobody(ModelParam.RuntimeParam.CPt(3:5,:),ModelParam);
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
%     ax1 = subplot(2,3,1);
    imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PSMap);
    title('Source PMap & All Simulated Lobe Centers');
    set(gca,'YDir','normal');
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
%     ax2 = subplot(2,3,2);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PCMap,...
%         'Alphadata',ModelParam.RuntimeParam.PCMap>-1);
%     set(ax2,'YDir','normal');
%     minC = unique(min(ModelParam.RuntimeParam.PCMap(ModelParam.RuntimeParam.PCMap>-1)));
%     maxC = unique(max(ModelParam.RuntimeParam.PCMap(ModelParam.RuntimeParam.PCMap>-1)));
%     if minC==maxC
%         minC = minC-minC/2;
%         maxC = maxC+maxC/2;
%     elseif ~isempty([minC maxC])
%         caxis([minC maxC]);
%     end
%     % colorbar;
%     hold on;
%     plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
%     hold off;
%     title('Channel MidPoint PMap');
%     axis square;
%     ax3 = subplot(2,3,3);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PLMap);
%     set(ax3,'YDir','normal');
%     % colorbar;
%     title('Lobe Source PMap');
%     axis square;
%     ax4 = subplot(2,3,4);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PTMap);
%     set(ax4,'YDir','normal');
%     % colorbar;
%     title('Depo Thickness PMap');
%     axis square;
%     % plot combined pmap
%     ax5 = subplot(2,3,5);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.PMap);
%     set(ax5,'YDir','normal'); 
%     hold on;
%     plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
%     hold off;
%     title('Combined PMap');
%     % colorbar;
%     axis square;
%     ax6 = subplot(2,3,6);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,PSurf,'Alphadata',PSurf>0);
%     set(ax6,'YDir','normal'); 
%     hold on;
%     plot(ModelParam.RuntimeParam.CPt(:,1),ModelParam.RuntimeParam.CPt(:,2),'.-k','MarkerSize',20);
%     hold off;
%     title('Simulated Positive Surface');
%     % colorbar;
%     hold on;
%     plot(p(:,1),p(:,2),'.','MarkerSize',30);
%     plot(set1x,set1y,'.k-','LineWidth',3);
%     plot(bx1,by1,'.-b');
%     plot(bx2,by2,'.-r');
%     hold off;
%     axis square;
    % ---------------------------------------------------------------------
%     figure(fhsurf);
%     imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.CurrentSurf);shading flat;
% %     axis([0 max(ModelParam.GridInfo.x) 0 max(ModelParam.GridInfo.y)]);
% %     caxis([min(ModelParam.FaciesParam.FTag) max(ModelParam.FaciesParam.FTag)]);
% %     colormap(redgreencmap);
%     colorbar;
%     % set(gca,'XTickLabel','','YTickLabel','');
%     title(sprintf('Elevation at ie = %d',i),'FontSize',20);
% %     set(gcf, 'Position', get(0,'Screensize')); 
%     set(gca,'YDir','normal');
%     axis square;
%     pause(0.02);
    figure(fhsurf);
    idx = ModelParam.RuntimeParam.CurrentSurf~=0;
    himg = imagesc(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.CurrentSurf,'AlphaData',idx);
    caxis([0 10]);
%     title(sprintf('Elevation at ie = %d',i),'FontSize',20);
%     set(gcf, 'Position', get(0,'Screensize')); 
%     set(gca,'YDir','normal');
%     axis square;
%     set(gca,'XTick',[],'YTick',[],'ZTick',[]);
%     grid off;
%     set(gca,'box','off');   
%     set(gca,'xcolor',get(gcf,'color'),'ycolor',get(gcf,'color'));
% 
%     set(gca,'box','off');    % set the tight region
%     pause(0.2);
%     if ((mod(i,5)==0) && (safeimg==true))
%         saveas(himg,sprintf('img%d.eps',i),'epsc');
%     end
%     
    hsf = surf(ModelParam.GridInfo.x,ModelParam.GridInfo.y,ModelParam.RuntimeParam.CurrentSurf);
    shading flat;
    caxis([0 10]);
    axis([0 max(ModelParam.GridInfo.x) 0 max(ModelParam.GridInfo.y) 0 800]);
%     caxis([min(ModelParam.FaciesParam.FTag) max(ModelParam.FaciesParam.FTag)]);
%     caxis([min(ModelParam.FaciesParam.FTag) max(ModelParam.FaciesParam.FTag)]);
%     colormap(redgreencmap);
%     colorbar;
%     title(sprintf('Elevation at ie = %d',i),'FontSize',20);
%     set(gcf, 'Position', get(0,'Screensize')); 
    set(gca,'YDir','normal');
    axis square;
    view(9, 48);
    set(gca,'XTick',[],'YTick',[],'ZTick',[]);
    grid off;
    box off;
    set(gca,'xcolor',get(gcf,'color'),'ycolor',get(gcf,'color'),'zcolor',get(gcf,'color'));

    pause(0.02);
    if ((mod(i,5)==0) && (safeimg==true))
        saveas(hsf,sprintf('surf%d.eps',i),'epsc');
    end
end
% Simulation records
ModelParam.SimRecord.MPP = ModelParam.SimRecord.MPP(2:end,:);
ModelParam.SimRecord.DMPP = ModelParam.SimRecord.DMPP(2:end,:);
ModelParam.SimRecord.TMPP = ModelParam.SimRecord.TMPP(2:end,:);
ModelParam.SimRecord.TLobe = ModelParam.SimRecord.TLobe(2:end,:);
ModelParam.SimRecord.VTMPP = ModelParam.SimRecord.VTMPP(2:end,:);
ModelParam.SimRecord.VTLobe = ModelParam.SimRecord.VTLobe(2:end,:);
% qq plot of the simulated cdfs
% qq plot comparing results
figure;
h = qqplot(ModelParam.PriorCdfs.dRMPP,ModelParam.SimRecord.DMPP);
set(h,'linewidth',8,'markersize',30);
set(gca,'fontsize',40);
xlabel('');ylabel('');
axis tight;
figure;
h=qqplot(ModelParam.PriorCdfs.dThetaLobe,ModelParam.SimRecord.TLobe);
set(h,'linewidth',8,'markersize',30);
set(gca,'fontsize',40);
xlabel('');ylabel('');
axis tight;
% build up the sequence cube
ECube = zeros(ny,nx,SimParam.NEvent*2);
ECube(:,:,1:2:end-1)=NCube;
ECube(:,:,2:2:end)=PCube;
% take out slice 50
ns = 50;
% CSec = squeeze(ECube(:,ceil(ns),:))';
CSec = squeeze(ECube(ceil(ns),:,:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 100
ns = 100;
CSec = squeeze(ECube(ceil(ns),:,:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 150
ns = 150;
CSec = squeeze(ECube(ceil(ns),:,:))';
WCSec = repmat(CSec,[1 1 2]);
WCSec(1:2:end-1,:,1)=0;
WCSec(2:2:end,:,2)=0;
WCSec(WCSec==0)=nan;
fh = GeometricWheeler2D(WCSec);
title(get(gcf,'CurrentAxes'),sprintf('Slice y=%d',ns));
% take out slice 200
ns = 200;
CSec = squeeze(ECube(ceil(ns),:,:))';
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