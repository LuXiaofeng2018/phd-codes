%% ------------------------------------------------------------------------
% This script extracts geometrics and nearest neighbor proximity measures from lobe masks at all scales (TestWorkFlow2)
% relative files are saved in folders
% .\ScalesExtr\ - geometric information
% .\ScalesNND\ - nearest neighbor proximities
% ------------------------------------------------------------------------
close all;clc;clear
addpath(genpath('.\utilities\'));
%% ------------------------------------------------------------------------
% Load extracted cases
% % SummerCoarse - Exp. A
% ImgPath = '.\SummerCoarse\Extracted\Scales\';
% SavePath1 = '.\SummerCoarse\Extracted\ScalesExtr\';
% SavePath2 = '.\SummerCoarse\Extracted\ScalesNND\';
% sx = 0; sy = 0;
% WCDCoarse - Exp. B
ImgPath = '.\WCDCoarse\Extracted\Scales\';
SavePath1 = '.\WCDCoarse\Extracted\ScalesExtr\';
SavePath2 = '.\WCDCoarse\Extracted\ScalesNND\';
sx = 0; sy = 0;
%% ------------------------------------------------------------------------
% Extract direct information
% -------------------------------------------------------------------------
FileList = dir(ImgPath);
% -------------------------------------------------------------------------
% assign space for saving
isub = [FileList(:).isdir]; %# returns logical vector
nsub = sum(isub); % # of subfolders
nfile = length(FileList)-nsub;
for i=3:nfile+nsub
    imgName = FileList(i).name;
    load([ImgPath imgName]);
    if ~FileList(i).isdir
        nlobe = length(NewLobeMask);    
        SP = zeros(nlobe,2);% source points
        T = zeros(nlobe,4);% orientation vectors
        Edges = cell(nlobe,1); % edges
        Masks = cell(nlobe,1); % lobe masks
        ArryEdges = []; % edges with normalized coordinates
        AlgArryEdges = []; % edges with aligned coordinates
        normEdges = cell(nlobe,1); % normalized edges
        AlgEdges = cell(nlobe,1); % aligned and normalized edges
        for j=1:nlobe
            RGBPic = cell2mat(NewLobeMask(j));
            % ---------------------------------------------------------------------
            % Extract geometric information
            [EdgeMap,EdgeCoor,LobeMask,SPt,Theta] = ExtractInfo(RGBPic,sx,sy);
            % ---------------------------------------------------------------------
            SP(j,1) = SPt(1);SP(j,2) = SPt(2);
            T(j,1:2) = Theta(1,:);
            T(j,3:4) = Theta(2,:);
            Masks(j)={LobeMask};
            Edges(j)={EdgeCoor};
            AEdge = AlignShape(SPt,Theta,EdgeCoor);
            AlgEdges(j) = {AEdge};
            ArryEdges = [ArryEdges;EdgeCoor];
            AlgArryEdges = [AlgArryEdges;AEdge];
            sprintf('Extracting basic information from Image #: %d, case#: %d',j,i-2)
%             % ---------------------------------------------------------------------
%             imagesc(LobeMask);
%             hold on;
%             plot(EdgeCoor(:,2),EdgeCoor(:,1),'-g');
%             plot(SPt(2),SPt(1),'.b','MarkerSize',30);
%             plot(Theta(:,2),Theta(:,1),'-r');
%             hold off;
%             [ny,nx]=size(RGBPic);
%             axis([0 ny 0 nx]);
%             set(gca,'YDir','reverse');
%             title(sprintf('Group#: %d(%d)',j,nlobe));
%             pause(0.01)
        end
        % ------------------------------------------------------------------------
        % normalized edges on coordinates

        ci = mean(ArryEdges(:,1));cj=mean(ArryEdges(:,2));
        s = sqrt(mean((ArryEdges(:,1)-ci).^2 + (ArryEdges(:,2)-cj).^2));
        for in=1:nlobe
            TEdge = cell2mat(Edges(in));
            nTEdge = zeros(size(TEdge));

            nTEdge(:,1) = (TEdge(:,1)-ci)/s;
            nTEdge(:,2) = (TEdge(:,2)-cj)/s;

            normEdges(in) = {nTEdge};
        end
        normSP = zeros(size(SP));
        normSP(:,1) = (SP(:,1)-ci)/s;
        normSP(:,2) = (SP(:,2)-cj)/s;
%         % check normalized point clouds
%         figure;
%         plot(normSP(:,1),normSP(:,2),'.b','MarkerSize',10);
%         % check normalized patterns
%         figure;
%         hold on;
%         for in=1:nlobe
%             TEdge = cell2mat(normEdges(in));
%             plot(TEdge(:,1),TEdge(:,2),'-b');
%         end
%         plot(normSP(:,1),normSP(:,2),'.k','markersize',20);
%         hold off;
%         % check aligned shapes
%         figure;
%         hold on;
%         for in=1:nlobe
%             AEdge = cell2mat(AlgEdges(in));
%             plot(AEdge(:,1),AEdge(:,2),'-b');
%             ci = mean(AEdge(:,1));cj = mean(AEdge(:,2));
%             plot([0 ci],[0 cj],'--r','MarkerSize',30);
%         end
%         hold off;
        % ------------------------------------------------------------------------
%         SclExtrPath = [ImgPath '\ScalesExtr'];
        if (~exist(SavePath1,'dir'))
            mkdir(SavePath1)
        end

        save([SavePath1 'Extr_' imgName],'normSP','SP','AlgEdges',...
            'normEdges','T','Edges','Masks','-v7.3');
        %% ------------------------------------------------------------------------
        % Generete Pairwise distances
        % assigne space
        MatSPProx = zeros(nlobe);
        MatThetaProx = zeros(nlobe);
        MatPolyProx = zeros(nlobe);
        MatShapeProx = zeros(nlobe);

        normSPD = zeros(nlobe);
        normThetaD = zeros(nlobe);
        normPolyD = zeros(nlobe);
        normShapeD = zeros(nlobe);

        % ------------------------------------------------------------------------
        % NND SP 1st class
        [pD, IDQ] = nndist(normSP, normSP, 1, 'euc');
        NND = zeros(nlobe,4);
        for in=1:nlobe
            jn = IDQ(in);
            nSP = [normSP(in,:);normSP(jn,:)];
            Theta = [T(in,:); T(jn,:)];
            Edge = [normEdges(in); normEdges(jn)];
            AEdge = [AlgEdges(in); AlgEdges(jn)];
            D = GenProx(nSP,Theta, Edge, AEdge);
            % SP
            NND(in,1) = D(1);
            % Theta
            NND(in,2) = D(2);
            % Polygon
            NND(in,3) = D(3);
            % Shape
            NND(in,4) = D(4);
        end
        sprintf('Finished NND for case #: %d',i-2)
        % ------------------------------------------------------------------------
%         ExtPath = [ImgPath '\Extracted\'];
        if (~exist(SavePath2,'dir'))
            mkdir(SavePath2)
        end
        save([SavePath2 'NND_' imgName],'NND','-v7.3');
    end
end
