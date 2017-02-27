% -------------------------------------------------------------------------
% Threshold a Section and plot out the wheeler diagram
% -------------------------------------------------------------------------
% Input:
%      CSec: A 2D matrix of size [X T]. 
%            X: length of measuring line; T: Number of surfaces.
%            It can be elevation recorded in tank data or from realizations
%            of surface-based model
%      Vt: Threshold
%         if length(Vt)=1, then 0<Vt<100, the percentile value to choose;
%         if length(Vt)=2, then Vt is the real threshold value to use;
%      FFigure: Wheter to plot or not
%      FSave: Whether to save the plot or not
%      imgName: a string defining the saving name of your plots. In this 
%            case we have two plots: 'imgName_Dep' and 'imgName_Ero'
% Output:
%      WCSec: a 3D matrix with dimension [X T 2]. 
%            [X T 1] is the thresholded deposition pattern; 
%            [X T 2] is the thresholded erosion pattern.
%      strutfh: structure of figure handles.
%            'strutfh.dep' for deposition
%            'strutfh.ero' for deposition
function [WCSec,strutfh]=...
                        ThreshWheeler2D(CSec,Vt,FFigure,FSave,imgName)
    if nargin < 5
        imgName = 'Wheeler-Diagram';
    end
    if nargin < 4
        FSave = false;
    end
    if nargin < 3
        FFigure = false;
    end
    if nargin < 2
        Vt = 99;
    end
    % take section size
    [nx,nt] = size(CSec);
    T = [0:nt-1];
    X = [0:nx-1];
    % generate the 2D pixel plots
    EroAmountMap = nan(nt,nx); % amount of erosion
    DepAmountMap = nan(nt,nx); % amount of deposition
    % calculate dep/ero from elevation
    for i=2:nt
%         Pattern = nan(nx,1);
        Pattern = CSec(:,i) - CSec(:,i-1);
        IdxE = Pattern < 0;
        IdxD = Pattern > 0;
        % depo amount
        DAmount = nan(nx,1);
        DAmount(IdxD) = Pattern(IdxD);
        DepAmountMap(i,:) = DAmount;
        % ero amount
        EAmount = nan(nx,1);
        EAmount(IdxE) = Pattern(IdxE);
        EroAmountMap(i,:) = EAmount;        
    end
    % threshold the map by volume (thickness of a connected area)
    thDAmountMap = zeros(size(DepAmountMap));
    thEAmountMap = zeros(size(EroAmountMap));
    for i=1:nt
        % deposition areas
        dPattern = DepAmountMap(i,:);
        idxd = dPattern>0;
        ccd = bwconncomp(idxd,4);    
        Objs = ccd.PixelIdxList;
        DepV = [];
        for j=1:ccd.NumObjects
            ObjV = sum(dPattern(Objs{j}));
            DepV = [DepV ObjV];
        end
        if length(Vt)==1
            thDepV = prctile(DepV,Vt);
        end
        if length(Vt)==2
            thDepV = Vt(1);
        end
        for j=1:ccd.NumObjects
            if DepV(j) < thDepV;
                dPattern(Objs{j}) = nan;
            end
        end
        thDAmountMap(i,:)=dPattern;
        % erosion areas
        ePattern = EroAmountMap(i,:);
        idxe = ePattern<0;
        cce = bwconncomp(idxe,4);
        Objs = cce.PixelIdxList;
        EroV = [];
        for j=1:cce.NumObjects
            ObjV = sum(ePattern(Objs{j}));
            EroV = [EroV ObjV];
        end
        if length(Vt)==1
            thEroV = prctile(EroV,100-Vt);
        end
        if length(Vt)==2
            thEroV = Vt(2);
        end
        for j=1:cce.NumObjects
            if EroV(j) > thEroV;
                ePattern(Objs{j}) = nan;
            end
        end
        thEAmountMap(i,:)=ePattern;  
    end
    % output the thresholded patterns
    WCSec(:,:,1)=thDAmountMap;
    WCSec(:,:,2)=thEAmountMap;
    strutfh = [];
    if FFigure==true
        % plot and output
        strutfh.dep = figure;
        set(gcf, 'Position', get(0,'Screensize'));
        imagesc(X,T,thDAmountMap,'Alphadata',~isnan(thDAmountMap));
        title([imgName ' - Dep'],'FontSize',20);
        caxis([min(thEAmountMap(:)) max(thDAmountMap(:))]);
    %     set(gca,'XTick',[],'YTick',[]);
        set(gca,'YDir','normal');
        colorbar;
        if FSave==true
            export_fig([imgName '-Dep'],'-jpg');
        end
        strutfh.ero = figure;
        set(gcf, 'Position', get(0,'Screensize'));
        imagesc(X,T,thEAmountMap,'Alphadata',~isnan(thEAmountMap));
        title([imgName ' - Ero'],'FontSize',20);
        caxis([min(thEAmountMap(:)) max(thDAmountMap(:))]);
    %     set(gca,'XTick',[],'YTick',[]);
        set(gca,'YDir','normal');
        colorbar;
        if FSave==true
            export_fig([imgName '-Ero'],'-jpg');
        end
    end
end