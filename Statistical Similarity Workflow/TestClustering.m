% -------------------------------------------------------------------------
% Test clustering point patterns
clc;close all;clear;
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
set(gca,'XTick',[],'XTickLabel',[]);
[CtdRD]=Dendro2RP(CtdzMZ,DenOrd');
figure;
% subplot(2,1,2);
bar(CtdRD);
set(gca,'XTick',[1:size(CtdRD,1)],'XTickLabel',DenOrd);
% set(gca,'XTick',[],'XTickLabel',[]);
set(gca,'FontSize',35);
axis tight;
% -------------------------------------------------------------------------
% Choose scale-of-interpretation in the hierarchy
load([Path filename '_Extr']);
CtdCut = 0.15;
CtdIdxCut = CtdRD>CtdCut;
CtdIdx = -1*ones(size(CtdRD));
[CtdICut] = find(CtdIdxCut);
nc = length(CtdICut);
for i=1:nc-1
    CtdIdx(CtdICut(i):CtdICut(i+1)-1)=i;
end
CtdIdx(CtdICut(end):end)=(i+1);
sprintf('Number of Clusters: %d',length(unique(CtdIdx)))

% plot bar of clusters
figure;
nc = sum(CtdIdxCut);
CtdRDC = [];
for i=1:nc
    CtdRDC = [CtdRDC CtdRD];
end
for i=1:nc
    idx = CtdIdx~=i;
    temp= CtdRDC(:,i);
    temp(idx)=nan;
    CtdRDC(:,i)=temp;
end
bar(CtdRDC,'stacked');
set(gca,'FontSize',35);
% set(gca,'XTick',[1:size(CtdRD,1)],'XTickLabel',DenOrd);
set(gca,'XTick',[1:size(CtdRD,1)],'XTickLabel',CtdIdx);
% set(gca,'XTick',[],'XTickLabel',[]);

axis tight;
% -------------------------------------------------------------------------
% combine lobes in each group
fNL = figure;
% load([Path filename]);
NewLobeMask = cell(nc,1);
[ny,nx]=size(cell2mat(Masks(1)));
for i=1:nc
    idxi = sort(DenOrd(CtdIdx==i));
    groupi = Masks(idxi);
    Lobei = cell2mat(groupi(1));
        figure(fNL);
        imagesc(Lobei);
    for j=2:length(groupi)
        Lobe = cell2mat(groupi(j));
%             figure(fNL);
%             imagesc(Lobe);
        Lobei = Lobe|Lobei;
            figure(fNL);
            imagesc(Lobei);
    end
    Lobei(Lobei>0)=1;
%         figure(fNL);
%         imagesc(Lobei);
    NewLobeMask(i)=mat2cell(Lobei);
    sprintf('#length=%d, #Group=%d(%d)',kk,i,nc)
end
% % -------------------------------------------------------------------------
% % Save New Lobes
% save([filename sprintf('_%dGroups',nc)],'NewLobeMask','DenOrd','CtdIdx',...
%     'CtdCut','-v7.3');