% -------------------------------------------------------------------------
% edge extraction
% -------------------------------------------------------------------------
% Input: 
%        RGBPic: the RGB pic file of interpreted object whose boundary and
%        source point is to be extracted (Assuming the source point is at 
%        upper left corner)
% Outputs:
%        BWEdge: the BW image with only edge pixels
%        EdgeCoor: the coodinate information of the edge [X Y]
%        LobeMask: the BWmask of lobe area
%        SPt: source point coordinates
function [BWEdge,EdgeCoor,LobeMask,SPt] = ExtractEdge(RGBPic)
    % ---------------------------------------------------------------------
    % generate grey scale photo
    GrayPic = rgb2gray(RGBPic);
    GrayPic(GrayPic==255)=0;
 
    % generate BW pics
    BWPic = im2bw(GrayPic,0);
    % ---------------------------------------------------------------------
    % internal functions
    % erosion moving out the blurred boundary of the lobe
    s = strel('disk',3);
    BWPic = imerode(BWPic,s);
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
    % ---------------------------------------------------------------------
    % Source Pt
    SkelMap = bwmorph(LobeMask,'skel',Inf);
    SEPtMap = bwmorph(SkelMap,'endpoints');
%     SEPt = bwboundaries(SEPtMap,8);
%     SPt = cell2mat(SEPt(1));
    [SPtI,SPtJ] = find(SEPtMap);
    d = sqrt(SPtI.^2+SPtJ.^2);
    [mind,minI] = min(d);
    SPt = [SPtI(minI),SPtJ(minI)];
end