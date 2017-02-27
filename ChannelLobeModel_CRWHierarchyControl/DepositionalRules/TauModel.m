% Use the Tau Model to combine multiple probability information
% input:
%     PDiMap: 3D matrix, PDiMaps, different components are along the 3rd
%     dimension, X0 = PDiMap(:,:,1);
%     Tau: array of Tau weights, length is one element less than the 3rd 
%       dim of PDiMap, Tau(i) is the Tau weight for PDiMaps(:,:,i+1)
% output:
%     PMao: the combined PMap
function [PMap] = TauModel(PDiMap,Tau)
    [ny,nx,nc] = size(PDiMap);
    P0 = squeeze(PDiMap(:,:,1));
    X0 = (1-P0)./P0;
    X = X0;
    for i=2:nc
        Pi = squeeze(PDiMap(:,:,i));
        taui = Tau(i-1);
        Xi = (1-Pi)./Pi;
        X = X.*(Xi./X0).^taui;
    end
    PMap = 1./(1+X);
end