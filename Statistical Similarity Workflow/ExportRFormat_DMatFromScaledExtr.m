close all;clc;clear
run('EnviSetting');
%% ------------------------------------------------------------------------
% Load data
Path = '.\Scaled_extr\';
FileList=dir(Path);
nfiles = length(FileList)-2;
for k=4:nfiles+2%-----------------------------------------------------
    FileName = FileList(k).name;
    load(FileName);
    nl = length(Masks);
    % ------------------------------------------------------------------------
    % Compute proximity matrix
    ns = size(SP,1);
    % assigne space
    MatSPProx = zeros(ns);
    MatThetaProx = zeros(ns);
    MatPolyProx = zeros(ns);
    MatShapeProx = zeros(ns);
    for i=1:ns
        for j=i:ns
            Theta = [T(i,:); T(j,:)];
            Edge = [Edges(i); Edges(j)];
            D = GenProx(Theta, Edge);
            MatSPProx(i,j) = D(1);
            MatThetaProx(i,j) = D(2);
            MatPolyProx(i,j) = D(3);
            MatShapeProx(i,j) = D(4);
            sprintf('DMat #row=%d, #column=%d, #file=%s',i,j,FileName)
            MatSPProx(j,i) = D(1);
            MatThetaProx(j,i) = D(2);
            MatPolyProx(j,i) = D(3);
            MatShapeProx(j,i) = D(4);
        end
    end
    % ---------------------------------------------------------------------
    % construct the min NND array P(xD)
    NND = zeros(ns,4);
    %
    for i=1:ns
        % SP
        tt = MatSPProx(i,:);
        tt = sort(tt);
        NND(i,1) = tt(2);
        % Theta
        tt = MatThetaProx(i,:);
        tt = sort(tt);
        NND(i,2) = tt(2);
        % Poly
        tt = MatPolyProx(i,:);
        tt = sort(tt);
        NND(i,3) = tt(2);
        % Shape
        tt = MatShapeProx(i,:);
        tt = sort(tt);
        NND(i,4) = tt(2);
        sprintf('NNP xD #row=%d, #file=%s',i,FileName)
    end
    % normalize NND
    norm_NND = zeros(size(NND));
    maxNND = max(NND,[],1);
    for i=1:size(NND,2)
        norm_NND(:,i) = NND(:,i)/maxNND(:,i);
    end
    % ------------------------------------------------------------------------
    % Save P(xD)
    save([FileName '_DMats'],'MatSPProx','MatThetaProx','MatPolyProx','MatShapeProx',...
        '-v7.3');
    save([FileName '_NND_PxD'],'NND','norm_NND','-v7.3');
    saveR([FileName '_PxD.R'],'SP','NND','norm_NND');
    % ---------------------------------------------------------------------
    % construct the min NND array P(xD_SD)
    NND = zeros(ns,4);
    %
    for i=1:ns
        % SP
        tt = MatSPProx(i,:);
        [tt,ii] = sort(tt);
        % Take out the nn
        Theta = [T(i,:); T(ii(2),:)];
        Edge = [Edges(i);Edges(ii(2))];
        % compute
        Dinn = GenProx(Theta,Edge);
        %
        NND(i,:)=Dinn;
        sprintf('NNP xD_SD #row=%d, #file=%s',i,FileName)
    end
    % normalize NND
    maxNND = max(NND,[],1);
    norm_NND = zeros(size(NND));
    for i=1:size(NND,2)
        norm_NND(:,i) = NND(:,i)/maxNND(:,i);
    end
    % ------------------------------------------------------------------------
    % Save P(xD_SD)
    save([FileName '_NND_PxD_SD'],'NND','norm_NND','-v7.3');
    saveR([FileName '_PxD_SD.R'],'SP','NND','norm_NND');
end