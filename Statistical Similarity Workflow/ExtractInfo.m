% -------------------------------------------------------------------------
% edge extraction
% -------------------------------------------------------------------------
% Input: 
%        RGBPic: the RGB pic file of interpreted object whose boundary and
%        source point is to be extracted (Assuming the source point is at 
%        upper left corner)
%        sx, sy: basin source coordinate in the photo
%        bkcolor: background color of RGBPic
% Outputs:
%        BWEdge: the BW image with only edge pixels
%        EdgeCoor: the coodinate information of the edge [rows columns]
%        LobeMask: the BWmask of lobe area
%        SPt: source point coordinates [rows columns]
%        Theta; Lobe orientation vector [rows columns]
function [BWEdge,EdgeCoor,LobeMask,SPt, Theta] = ExtractInfo(RGBPic,sx,sy,bkcolor)
    % ---------------------------------------------------------------------
    % generate grey scale photo
    % generate BW pics
    if nargin<4
        BWPic = RGBPic;
        s = strel('disk',3);
        BWPic = imdilate(BWPic,s);
    else
        GrayPic = rgb2gray(RGBPic);
        GrayPic(GrayPic==bkcolor)=0;
        s = strel('disk',2);
%         GrayPic = imdilate(GrayPic,s);
%         GrayPic = imerode(GrayPic,s);
%         GrayPic = imclearborder(GrayPic);
        BWPic = im2bw(GrayPic,0);
    end
    ps = [10 10];
%     BWPic = padarray(BWPic,ps,'replicate');
    BWPic = padarray(BWPic,ps);
    % ---------------------------------------------------------------------
    % internal functions
    % erosion moving out the blurred boundary of the lobe
    s = strel('disk',3);
%     BWPic = imdilate(BWPic,s);
    BWPic = imerode(BWPic,s);
    BWPic = BWPic(1+ps(1):end-ps(1),1+ps(2):end-ps(2));
    % boundary from edge detection
    BWEdge = edge(BWPic,'roberts');
    % close the BW Edge
    BWEdge=bwmorph(BWEdge,'close');
    % ---------------------------------------------------------------------
    % cleaning with beperim result
    ccEdge = bwconncomp(BWEdge);
    nObj = ccEdge.NumObjects;
    MaxObjList = cell2mat(ccEdge.PixelIdxList(1));
    MaxObjSize = length(MaxObjList);
    for i=1:nObj
        ObjList = cell2mat(ccEdge.PixelIdxList(i));
        ObjSize = length(ObjList);
        if ObjSize > MaxObjSize
            BWEdge(MaxObjList) = 0;
            MaxObjList = ObjList;
            MaxObjSize = ObjSize;
        elseif ObjSize < MaxObjSize
            BWEdge(ObjList)=0;
        end
    end
    % ---------------------------------------------------------------------
    BWEdge = bwmorph(bwmorph(BWEdge,'thin',Inf),'spur');
    % ---------------------------------------------------------------------
    % filled map
    LobeMask = imfill(BWEdge,'holes');
    % ---------------------------------------------------------------------
    % boundary coordinates
    EdgeCoor = cell2mat(bwboundaries(LobeMask,8));
    if ~isequal(EdgeCoor(1,:),EdgeCoor(end,:))
        EdgeCoor = [EdgeCoor;EdgeCoor(1,:)];
    end
    % ---------------------------------------------------------------------
    % Source Pt
%     SkelMap = bwmorph(LobeMask,'skel',Inf);
%     SkelMap = bwmorph(LobeMask,'thin',Inf);
%     SEPtMap = bwmorph(SkelMap,'endpoints');
%     [SPtI,SPtJ] = find(SEPtMap);
    SPtI = EdgeCoor(:,1); SPtJ = EdgeCoor(:,2);
    d = sqrt((SPtI-sy).^2+(SPtJ-sx).^2);
    [mind,minI] = min(d);
    SPt = [SPtI(minI),SPtJ(minI)];
    % ---------------------------------------------------------------------
    % Find the orientation vector
%     % use most distal
%     PPDist = sqrt((EdgeCoor(:,1)-SPt(1)).^2+(EdgeCoor(:,2)-SPt(2)).^2);
%     [maxPd,maxPI]=max(PPDist);
%     DPt = EdgeCoor(maxPI,:);
    % use centroid
    ic = mean(EdgeCoor(:,1));jc = mean(EdgeCoor(:,2));
    DPt = [ic jc];
    Theta = [SPt;DPt];
end