HeadFile;
%% -------------------------------------------------------------------------
flagS = true; % save figures
flagS = false; % save figures
% -------------------------------------------------------------------------
% load geometry and facies information
% -------------------------------------------------------------------------
LobeFileName = 'realization_1180ThickSamePosNeg';
load(LobeFileName);
% FacieFileName = 'realization_1180ThickSamePosNegFPlusT12'; nt = 2;
% load(FacieFileName);
toolpath = 'C:\Dropbox\utilities';
addpath(genpath(toolpath));
%% -------------------------------------------------------------------------
% Cut off the boundary
% -------------------------------------------------------------------------
% [ny,nx,nz] = size(FCube1);
nt = 30;
t0 = 5;
IX = [150 175];
IY = [50 75];
PCube = PCube(40:end,:,t0:t0+nt-1);
NCube = NCube(40:end,:,t0:t0+nt-1);
[ny,nz,nt] = size(NCube);
TCube = zeros(ny,nz,2*nt+1);
% NCube(isnan(NCube)) = 0;
% PCube(isnan(PCube)) = 0;
%% -------------------------------------------------------------------------
% Set up figure
% -------------------------------------------------------------------------
hf1 = figure;
set(gcf, 'Position', get(0,'Screensize')); 
% caxis([0 10]);
%% -------------------------------------------------------------------------
% initial topo
T = squeeze(TCube(:,:,1));
figure(hf1);
surf(T);
shading flat;
az = 30; el = 110;
view([az el]);
zb1 = -50; zb2 = 50;
cb1 = zb1/4; cb2 = zb2/4;
caxis([cb1 cb2]);
zlim([zb1 zb2]);
set(gca,'XTick',[],'YTick',[],'ZTick',[]);
if flagS==true
    export_fig(['Model Simulation 1'],'-jpg');   
end
%% -------------------------------------------------------------------------
% Start figuring
% -------------------------------------------------------------------------
k=2;
for i=1:nt
    % plot cross section before erosion
    
    % place erosion surface
    N = squeeze(NCube(:,:,i));
    IdxN = ~isnan(N);
    T(IdxN) = T(IdxN) + N(IdxN);
    figure(hf1);
    surf(T);
    shading flat;
    view([az el]);
    caxis([cb1 cb2]);
    zlim([zb1 zb2]);
    set(gca,'XTick',[],'YTick',[],'ZTick',[]);
    if flagS==true
        export_fig(['Model Simulation Neg' sprintf(' %d',i+1)],'-jpg');   
    end
    TCube(:,:,k) = T;
    k=k+1;
    % plot cross section after erosion
    
    % plot out following lobes
    P = squeeze(PCube(:,:,i));
    IdxP = ~isnan(P);
    T(IdxP) = T(IdxP) + P(IdxP);
    figure(hf1);
    surf(T);
    shading flat;
    view([az el]);
    caxis([cb1 cb2]);
    zlim([zb1 zb2]);
    set(gca,'XTick',[],'YTick',[],'ZTick',[]);
    if flagS==true
        export_fig(['Model Simulation Pos' sprintf(' %d',i+1)],'-jpg');   
    end
    TCube(:,:,k) = T;
    k=k+1;
    % plot cross section after deposition
    
end
save('DeomDynSurf.mat','TCube');
% From the 2nd figuring
% for i=1:nt
%     % plot out all prev surfaces again
%     hold on;
%     j=i;
%     % plot out prev Shale layers
%     T = squeeze(TCube1(:,:,j));
%     F = squeeze(FCube1(:,:,j));
%     IdxShale = (F==1)*1;
% %         imagesc(IdxShale,'alphadata',IdxShale);        
%     surf(T,IdxShale,'alphadata',IdxShale);
%     shading flat;
%     view([50 120]);
%     set(gca,'XTick',[],'YTick',[],'ZTick',[]);
% %         pause;
%     % plot out following lobes
%     TT = squeeze(TCube1(:,:,j+1));
%     P = squeeze(PCube(:,:,j));
%     IdxP = ~isnan(P)*(j+1);
% %         imagesc(IdxP,'alphadata',IdxShale);        
%     surf(TT,IdxP,'alphadata',IdxShale);
%     shading flat;
%     view([50 120]);
%     set(gca,'XTick',[],'YTick',[],'ZTick',[]);
% %         pause;
% 
% hold off;
% end

%% -------------------------------------------------------------------------
% Finish up figure
% -------------------------------------------------------------------------