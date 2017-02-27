% -------------------------------------------------------------------------
% Surface Proc
% -------------------------------------------------------------------------
clear;close all;

% % Borneo
% ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\BorneoCoarse\Extracted\';
% FileName = 'Borneo_Extr';
% % SummerCoarse
% ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\SummerCoarse\Extracted\';
% FileName = 'Summer_Extr';% Save name
% % WCDCoarse
% ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\WCDCoarse\Extracted\';
% FileName = 'WCD_Extr';% Save name
% Amazon
ImgPath = 'D:\workspace\TempWork\NewData\InfoExtract\Amazon\Extracted\';
FileName = 'Amazon_Extr';% Save name

load([ImgPath FileName]);
nfile = length(SP);
[ny,nx] = size(cell2mat(Masks(1)));
hfc = figure;
for i=1:nfile
    SPt = SP(i,:);
    Theta = T(i,:);
    EdgeCoor = cell2mat(Edges(i,:));
    LobeMask = cell2mat(Masks(i));
    imagesc(LobeMask,'AlphaData',LobeMask>0);
    % plot source point
    figure(hfc);
    hold on;
    % ------------------------------------------------------------------------
    % plot boundary line using coordinates
    plot(EdgeCoor(:,2),EdgeCoor(:,1),'-g');
    axis([0 nx-1 0 ny-1]);
    set(gca,'YDir','reverse');    
    plot(SPt(2),SPt(1),'k*','MarkerSize',30);
    % plot orientation vector
    plot(Theta(4),Theta(3),'k.','MarkerSize',30);
    plot(Theta(2:2:end),Theta(1:2:end),'b-','LineWidth',2);
    hold off;
    title(sprintf('Data: %s; Lobe=%d',FileName,i),'FontSize',20);
    pause;
end