% -------------------------------------------------------------------------
% threshold for the facies
% inputs:
%       DMap: Distance maps for a geobody
%       Ft: an 1*N increasing array,threshold a distance map for facies map,
%       FTag: an 1*(N+1) integer array to index each facies
% outputs:
%       FMap: Facies Map for the geobody
% -------------------------------------------------------------------------
function [ FMap ] = GeobodyFacies( DMap, Ft, FTag)
    nf = length(Ft);
    nt = length(FTag);
    if nf+1~=nt
        sprintf('Facies Tag is one element more than Thresholds')
    end
    FMap = DMap;
    Ft = [-1,Ft,1];
    nf = length(Ft);
    for i=2:nf
        f1 = Ft(i-1);
        f2 = Ft(i);
        FMap((DMap>f1)&(DMap<=f2))=FTag(i-1);
    end
end

