%% ------------------------------------------------------------------------
% The script load an image sequence of cutted lobes and extract the following
% information:
% File 1: '.\Extracted\SaveName_Extr.mat' consists of varialbles
%          'SP': Location Index of lobe source point
%          'AlgEdges': Coordinates of aligned boundaries of all lobes (aligned by SP and Orientation)
%          'normSP': normalized index of lobe source points
%          'normEdges': normalized indices of boundaries of all lobes
%          'T': lobe orientations
%          'Edges': original location indices of boundaries of all lobes
%          'Masks': masks of all lobes
% File 2: '.\Extracted\SaveName_PDMat.mat' consists of variables
%          'MatSPProx','MatThetaProx','MatPolyProx','MatShapeProx':pairwise
%                    proximity matrices of lobe source points, lobe orientations,
%                    lobe polygonal distance; lobe shape similarity
% File 3: '.\Extracted\SaveName_NND.mat'] includes 'NND', the nearest
% neighbor proximities
% ------------------------------------------------------------------------
close all;clc;clear
addpath(genpath('.\utilities\'));
%% ------------------------------------------------------------------------
% Interpreted photo path - Choose one lobe set at a time to process

% % BorneoCoarse - Kutai Basin
% ImgPath = '.\BorneoCoarse\';
% SaveName = 'Borneo';% Save name
% sx = 200; sy = 0; % the pixel index of the basin overall source point location

% % Amazon - Amazon Fan
% ImgPath = '.\Amazon\';
% SaveName = 'Amazon';% Save name
% sx = 185; sy = 749;% the pixel index of the basin overall source point location

% % SummerCoarse - Exp. A
% ImgPath = '.\SummerCoarse\';
% SaveName = 'Summer';% Save name
% sx = 0; sy = 0;% the pixel index of the basin overall source point location

% WCDCoarse - Exp. B
ImgPath = '.\WCDCoarse\';
SaveName = 'WCD';% Save name
sx = 0; sy = 0;% the pixel index of the basin overall source point location

%% ------------------------------------------------------------------------
% Extract geometric information
% Basin Source
bkcolor = 255;
% -------------------------------------------------------------------------
FileList = dir(ImgPath);
% -------------------------------------------------------------------------
% assign space for saving
isub = [FileList(:).isdir]; %# returns logical vector
nsub = sum(isub); % # of subfolders
nfile = length(FileList)-nsub;
SP = zeros(nfile,2);% source points
T = zeros(nfile,4);% orientation vectors
Edges = cell(nfile,1); % edges
Masks = cell(nfile,1); % lobe masks
ArryEdges = []; % edges with normalized coordinates
normEdges = cell(nfile,1); % normalized edges
AlgArryEdges = []; % edges with aligned coordinates
AlgEdges = cell(nfile,1); % aligned and normalized edges
j=1;
for i=3:nfile+nsub
    imgName = FileList(i).name;
    if ~FileList(i).isdir
        [RGBPic,map]=imread([ImgPath imgName]);
        % ---------------------------------------------------------------------
        % Extract geometric information: boudary, source point, orientation
        % etc.
        [EdgeMap,EdgeCoor,LobeMask,SPt,Theta] = ExtractInfo(RGBPic,sx,sy,bkcolor);
        % -----------------------------------------------------------------
        SP(j,1) = SPt(1);SP(j,2) = SPt(2);
        T(j,1:2) = Theta(1,:);
        T(j,3:4) = Theta(2,:);
        Masks(j)={LobeMask};
        Edges(j)={EdgeCoor};
        AEdge = AlignShape(SPt,Theta,EdgeCoor);
        AlgEdges(j) = {AEdge};
        AlgArryEdges = [AlgArryEdges;AEdge];
        ArryEdges = [ArryEdges;EdgeCoor];        
        sprintf('Extracting basic information from Image #: %d',j)
        j = j+1;
%         % ---------------------------------------------------------------
%         imagesc(LobeMask);
%         plot(EdgeCoor(:,2),EdgeCoor(:,1),'-b');
%         hold on;
%         plot(SPt(2),SPt(1),'.b','MarkerSize',30);
%         plot(Theta(:,2),Theta(:,1),'-r');
%         hold off;
%         [ny,nx]=size(RGBPic);
%         axis([0 ny 0 nx]);
%         set(gca,'YDir','reverse');
    end
end
% ------------------------------------------------------------------------
% normalize stacking pattern using Procrustes Analysis

ci = mean(ArryEdges(:,1));cj=mean(ArryEdges(:,2));
s = sqrt(mean((ArryEdges(:,1)-ci).^2 + (ArryEdges(:,2)-cj).^2));
for i=1:nfile
    TEdge = cell2mat(Edges(i));
    nTEdge = zeros(size(TEdge));

    nTEdge(:,1) = (TEdge(:,1)-ci)/s;
    nTEdge(:,2) = (TEdge(:,2)-cj)/s;
    
    normEdges(i) = {nTEdge};
end
normSP = zeros(size(SP));
normSP(:,1) = (SP(:,1)-ci)/s;
normSP(:,2) = (SP(:,2)-cj)/s;

figure;
hold on;
for i=1:nfile
    TEdge = cell2mat(normEdges(i));
%     plot(TEdge(:,1),TEdge(:,2),'-b');
    fill(TEdge(:,1),TEdge(:,2),'b','FaceAlpha',0.5);
end
plot(normSP(:,1),normSP(:,2),'.k','markersize',20);
hold off;

figure;
hold on;
for i=1:nfile
    AEdge = cell2mat(AlgEdges(i));
%     plot(AEdge(:,1),AEdge(:,2),'-b');
    fill(AEdge(:,1),AEdge(:,2),'b','FaceAlpha',0.5);
    ci = mean(AEdge(:,1));cj = mean(AEdge(:,2));
    plot([0 ci],[0 cj],'--r','MarkerSize',30);
end
hold off;
% ------------------------------------------------------------------------
ExtPath = [ImgPath '\Extracted\'];
if (~exist(ExtPath,'dir'))
    mkdir(ExtPath)
end

save([ImgPath '\Extracted\' SaveName '_Extr'],'SP','AlgEdges','normSP','normEdges',...
    'T','Edges','Masks','-v7.3');
%% ------------------------------------------------------------------------
% Generete Pairwise distances
% assigne space
MatSPProx = zeros(nfile);
MatThetaProx = zeros(nfile);
MatPolyProx = zeros(nfile);
MatShapeProx = zeros(nfile);

normSPD = zeros(nfile);
normThetaD = zeros(nfile);
normPolyD = zeros(nfile);
normShapeD = zeros(nfile);

ArrySPProx = [];
ArryThetaProx = [];
ArryPolyProx = [];
ArryShapeProx = [];

DiaIdx = false(nfile);

for i=1:nfile
    for j=i+1:nfile
%         nSP = [SP(i,:);SP(j,:)];        
%         Edge = [Edges(i); Edges(j)];
        nSP = [normSP(i,:);normSP(j,:)];
        Edge = [normEdges(i); normEdges(j)];
        Theta = [T(i,:); T(j,:)];

        AEdge = [AlgEdges(i); AlgEdges(j)];
        D = GenProx(nSP,Theta, Edge, AEdge);
        MatSPProx(i,j) = D(1);
        MatThetaProx(i,j) = D(2);
        MatPolyProx(i,j) = D(3);
        MatShapeProx(i,j) = D(4);
        sprintf('Generating Pairwise Distance Matrix #row=%d, #column=%d, Case: %s',i,j,SaveName)
        MatSPProx(j,i) = D(1);
        MatThetaProx(j,i) = D(2);
        MatPolyProx(j,i) = D(3);
        MatShapeProx(j,i) = D(4);
        
        DiaIdx(i,j)=1;
        DiaIdx(j,i)=1;
        ArrySPProx = [ArrySPProx; D(1)];
        ArryThetaProx = [ArryThetaProx; D(2)];
        ArryPolyProx = [ArryPolyProx; D(3)];
        ArryShapeProx = [ArryShapeProx; D(4)];
    end
end
    
% ------------------------------------------------------------------------
% no normalization
normSPD = MatSPProx; % already normalized in the cloud stage on coordinates
normThetaD = MatThetaProx; % no need because they are in the same domain
normPolyD = MatPolyProx;  % need to normalize at the very original stage on coordinates or use variance of distances
normShapeD = MatShapeProx; % 
% ------------------------------------------------------------------------
ExtPath = [ImgPath '\Extracted\'];
if (~exist(ExtPath,'dir'))
    mkdir(ExtPath)
end
save([ImgPath '\Extracted\' SaveName '_PDMat'],'MatSPProx','MatThetaProx','MatPolyProx','MatShapeProx',...
    'normSPD','normThetaD','normPolyD','normShapeD', ...
    'ArrySPProx','ArryThetaProx','ArryPolyProx','ArryShapeProx',...
    'normEdges',...
    'DiaIdx','-v7.3');
%% ------------------------------------------------------------------------
% Generete NND - SP Not first
NND2 = zeros(nfile,4);
for i=1:nfile
    % SP
    temp = normSPD(i,:);
    temp = sort(temp(DiaIdx(i,:)));
    NND2(i,1) = temp(1);
    % Theta
    temp = normThetaD(i,:);
    temp = sort(temp(DiaIdx(i,:)));
    NND2(i,2) = temp(1);
    % Polygon
    temp = normPolyD(i,:);
    temp = sort(temp(DiaIdx(i,:)));
    NND2(i,3) = temp(1);
    % Shape
    temp = normShapeD(i,:);
    temp = sort(temp(DiaIdx(i,:)));
    NND2(i,4) = temp(1);
end

% Generete NND - SP first
NND = zeros(nfile,4);
for i=1:nfile
    temp1 = normSPD(i,:);
    temp1 = temp1(DiaIdx(i,:));
    % SP
    [temp2,idx] = sort(temp1);
    temp3 = normSPD(i,:);
    temp3 = temp3(DiaIdx(i,:));
    NND(i,1) = temp3(idx(1));
    % Theta
    temp3 = normThetaD(i,:);
    temp3 = temp3(DiaIdx(i,:));
    NND(i,2) = temp3(idx(1));
    % Polygon
    temp3 = normPolyD(i,:);
    temp3 = temp3(DiaIdx(i,:));
    NND(i,3) = temp3(idx(1));
    % Shape
    temp3 = normShapeD(i,:);
    temp3 = temp3(DiaIdx(i,:));
    NND(i,4) = temp3(idx(1));
 end

% ------------------------------------------------------------------------
ExtPath = [ImgPath '\Extracted\'];
if (~exist(ExtPath,'dir'))
    mkdir(ExtPath)
end
save([ImgPath '\Extracted\' SaveName '_NND'],'NND','NND2','-v7.3');
