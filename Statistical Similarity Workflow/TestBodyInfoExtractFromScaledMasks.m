% -------------------------------------------------------------------------
% Surface Proc
% -------------------------------------------------------------------------
clear;close all;

Path = '.\scaled\';
sx = 0; sy = 0;
FileList = dir(Path);
nfile = length(FileList)-2;
for j=3:nfile+2
    SaveName = FileList(j).name;
    load([Path SaveName]);
    % ------------------------------------------------------------------------
    % assign space for saving
    nl = length(NewLobeMask);
    SP = zeros(nl,2);% source points
    T = zeros(nl,4);% orientation vectors
    Edges = cell(nl,1); % edges
    Masks = cell(nl,1); % lobe masks
    for i=1:nl
        Lobei = cell2mat(NewLobeMask(i));
        % ------------------------------------------------------------------------
        % Extract geometric information
        [EdgeMap,EdgeCoor,LobeMask,SPt,Theta] = ExtractInfo(Lobei,sx,sy);
        % ------------------------------------------------------------------------
        SP(i,1) = SPt(2);SP(i,2) = SPt(1);
        T(i,1) = Theta(1,2);T(i,2) = Theta(1,1);
        T(i,3) = Theta(2,2);T(i,4) = Theta(2,1);
        Masks(i)=mat2cell(LobeMask);
        Edges(i)=mat2cell(EdgeCoor);
        sprintf('j=%d, i=%d',j,i)
    end
    % ------------------------------------------------------------------------
    save([SaveName '_Extr'],'SP','T','Edges','Masks','-v7.3');
end
% ------------------------------------------------------------------------
% % plot results
% hfb = figure;
% imshow(EdgeMap);
% % plot boundary line using coordinates
% hfc = figure;
% [ny,nx]=size(EdgeMap);
% plot(EdgeCoor(:,2),EdgeCoor(:,1),'-r');
% axis([0 nx-1 0 ny-1]);
% set(gca,'YDir','reverse');
% hfm=figure;
% imshow(LobeMask);
% % plot source point
% figure(hfc);
% hold on;
% plot(SPt(:,2),SPt(:,1),'b.','MarkerSize',20);
% % plot orientation vector
% figure(hfc);
% hold on;
% plot(Theta(2,2),Theta(2,1),'b.','MarkerSize',20);
% plot(Theta(:,2),Theta(:,1),'b-','LineWidth',2);
