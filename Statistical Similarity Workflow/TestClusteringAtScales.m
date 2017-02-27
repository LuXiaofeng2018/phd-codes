% -------------------------------------------------------------------------
% Test clustering point patterns
clc;close all;clear;
addpath(genpath('D:\Dropbox\utilities\'));
% filename = 'WCD';
% Path = 'D:\workspace\TempWork\NewData\InfoExtract\WCD\Extracted\';
% filename = 'Summer';
% Path = 'D:\workspace\TempWork\NewData\InfoExtract\Summer\Extracted\';
filename = 'Borneo';
Path = 'D:\workspace\TempWork\NewData\InfoExtract\Borneo\Extracted\';
% filename = 'Amazon';
% Path = 'D:\workspace\TempWork\NewData\InfoExtract\Amazon\Extracted\';
% -------------------------------------------------------------------------
load([Path filename '_PDMat']);
% -------------------------------------------------------------------------
% normalize all proximity values
normSPD = MatSPProx./max(MatSPProx(:));
normThetaD = MatThetaProx./max(MatThetaProx(:));
normPolyD = MatPolyProx./max(MatPolyProx(:));
normShapeD = MatShapeProx./max(MatShapeProx(:));
% -------------------------------------------------------------------------
% Fusing the distance
%% equal
w1 = 0.4;
w2 = 0.2;
w3 = 0.1;
w4 = 0.3;
D = sqrt(w1*normSPD.^2 + w2*normThetaD.^2 + w3*normPolyD.^2 + w4*normShapeD.^2);
% -------------------------------------------------------------------------
% Hierarchical clustering
% calculate cumulated distance
SPDist = SeqPDist(D);
CtdzMZ = linkage(SPDist,'centroid');
% normalized the distance by its maximum
CtdzMZ(:,3)=CtdzMZ(:,3)/max(CtdzMZ(:,3));
% plot out result
figure;
% subplot(2,1,1);
[hden,dent,DenOrd]=dendrogram(CtdzMZ,0);
set(gca,'FontSize',35);
[CtdRD]=Dendro2RP(CtdzMZ,DenOrd');
figure;
% subplot(2,1,2);
bar(CtdRD);
% set(gca,'XTick',[1:size(CtdRD,1)],'XTickLabel',DenOrd);
% axis([0 length(DenOrd) 0 0.06]);
ylim([0 0.08]);
set(gca,'XTick',[],'XTickLabel',[]);
set(gca,'FontSize',35);
% title('Tank B','FontSize',35);
axis tight;
% -------------------------------------------------------------------------
% Choose scale-of-interpretation in the hierarchy
CtdCut0 = 0.06;% Starting scale 
CutOffset = 0.001;% offset
%
CtdCutArray = [CtdCut0:-CutOffset:CutOffset];
fNL = figure;
load([Path filename '_Extr']);
OldMasks = Masks;
for kk=1:length(CtdCutArray)
    CtdCut = CtdCutArray(kk);
    CtdIdxCut = CtdRD>CtdCut;
    CtdIdx = -1*ones(size(CtdRD));
    [CtdICut] = find(CtdIdxCut);
    nc = length(CtdICut);
    for i=1:nc-1
        CtdIdx(CtdICut(i):CtdICut(i+1)-1)=i;
    end
    CtdIdx(CtdICut(end):end)=(i+1);
    sprintf('Number of Clusters: %d, length:%f',length(unique(CtdIdx)),CtdCut)
    %% -------------------------------------------------------------------------
    % combine lobes in each group
%     load([Path filename]);
    NewLobeMask = cell(nc,1);
    [ny,nx]=size(cell2mat(OldMasks(1)));
    for i=1:nc
        idxi = sort(DenOrd(CtdIdx==i));
        groupi = OldMasks(idxi);
        Lobei = cell2mat(groupi(1));
        figure(fNL);
        imagesc(Lobei);
        for j=2:length(groupi)
            Lobe = cell2mat(groupi(j));
%             figure(fNL);
%             imagesc(Lobe);
            Lobei = Lobe|Lobei;
%             figure(fNL);
%             imagesc(Lobei);
        end
        Lobei(Lobei>0)=1;
        figure(fNL);
        imagesc(Lobei);
        NewLobeMask(i)=mat2cell(Lobei);
        sprintf('#length=%d, #Group=%d(%d)',kk,i,nc)
    end
    % -------------------------------------------------------------------------
    % Save New Lobes
    NewLobeSaveName = [sprintf('%dGroups_Cut%1.3f',nc,CtdCut) filename ];
    save([NewLobeSaveName '.mat'],'NewLobeMask','DenOrd','CtdIdx',...
        'CtdCut','-v7.3');
    %% ------------------------------------------------------------------------
    % Extract information
    sx=0;sy=0;
    nl = length(NewLobeMask);
    SP = zeros(nl,2);% source points
    T = zeros(nl,4);% orientation vectors
    Edges = cell(nl,1); % edges
    Masks = cell(nl,1); % lobe masks
    for i=1:nl
        Lobei = cell2mat(NewLobeMask(i));
        % ------------------------------------------------------------------------
        % Extract geometric information
        [EdgeMap,EdgeCoor,LobeMask,SPt,Theta] = ExtractInfo(Lobei,sx,sy);
        % ------------------------------------------------------------------------
        SP(i,1) = SPt(2);SP(i,2) = SPt(1);
        T(i,1) = Theta(1,2);T(i,2) = Theta(1,1);
        T(i,3) = Theta(2,2);T(i,4) = Theta(2,1);
        Masks(i)=mat2cell(LobeMask);
        Edges(i)=mat2cell(EdgeCoor);
        sprintf('Extracting info for New Lobe %d',i)
    end
    % ------------------------------------------------------------------------
    ExtraedInfoSaveName = [NewLobeSaveName '_Extr'];
    save([ExtraedInfoSaveName '.mat'],'SP','T','Edges','Masks','-v7.3');
    %% ---------------------------------------------------------------------
    % construct the min NND array P(xD)
    NND = zeros(nl,4);
    [D DI]= nndist(SP,SP,1,'euc');
    %
    for i=1:nl
        Theta = [T(i,:); T(DI(i),:)];
        Edge = [Edges(i);Edges(DI(i))];
        [D] = GenProx(Theta,Edge);
        NND(i,:)=D;
        sprintf('NND xD_SD #row=%d, #file=%s',i,NewLobeSaveName)
    end
    % normalize NND
    norm_NND = zeros(size(NND));
    maxNND = max(NND,[],1);
    for i=1:size(NND,2)
        norm_NND(:,i) = NND(:,i)/maxNND(:,i);
    end
    % ------------------------------------------------------------------------
    % Save P(xD_SD)
    save([ExtraedInfoSaveName '_NND_PxD_SD' '.mat'],'NND','norm_NND','-v7.3');
    saveR([ExtraedInfoSaveName '_PxD_SD.R'],'SP','NND','norm_NND');
end