% -------------------------------------------------------------------------
% denoise 2D pixel plots
% -------------------------------------------------------------------------
% Input:
%       Map: raw binary map, with NAN for no data
%       th: area threshold
% Output:
%       CleanMap: binary matrix showing cleaned map
function CleanMap = AreaThreshold(bwMap, th)
%     bwMap = double(~isnan(Map));
    
    ccMap = bwconncomp(bwMap,8);
    
    lbMap = labelmatrix(ccMap);    
    
    properties = regionprops(ccMap,'basic');
    ccAreas = [properties.Area];
    idxAreas = ccAreas >= th;
    
    CleanMap = false(size(bwMap));
%     a = idxAreas;
    I = ccMap.PixelIdxList{idxAreas};
    CleanMap(I) = true;
end