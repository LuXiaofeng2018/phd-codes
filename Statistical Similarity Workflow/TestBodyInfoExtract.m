% -------------------------------------------------------------------------
% Surface Proc
% -------------------------------------------------------------------------
clear;close all;


% Path = 'D:\workspace\TempWork\NewData\InfoExtract\04_Sed_Sup_Cycle\';
% sx=0;sy=0; % Summer cutted
% SaveName = 'Summer';

% Path = 'D:\workspace\TempWork\NewData\InfoExtract\WCD\';
% sx=0;sy=0; % WCD cutted
% SaveName = 'WCD';

Path = 'D:\workspace\TempWork\NewData\InfoExtract\Borneo\';
sx=300;sy=0; % Borneo cutted
SaveName = 'Borneo';


FileList = dir(Path);

%% ------------------------------------------------------------------------
% assign space for saving
nfile = length(FileList)-2;
SP = zeros(nfile,2);% source points
T = zeros(nfile,4);% orientation vectors
Edges = cell(nfile,1); % edges
Masks = cell(nfile,1); % lobe masks
for i=3:nfile+2
    imgName = FileList(i).name;
    RGBPic=imread([Path imgName]);
    % ------------------------------------------------------------------------
    % Extract geometric information
    [EdgeMap,EdgeCoor,LobeMask,SPt,Theta] = ExtractInfo(RGBPic,sx,sy);
    % ------------------------------------------------------------------------
    SP(i-2,1) = SPt(2);SP(i-2,2) = SPt(1);
    T(i-2,1) = Theta(1,2);T(i-2,2) = Theta(1,1);
    T(i-2,3) = Theta(2,2);T(i-2,4) = Theta(2,1);
    Masks(i-2)=mat2cell(LobeMask);
    Edges(i-2)=mat2cell(EdgeCoor);
    i-2
end
% ------------------------------------------------------------------------
save(SaveName,'SP','T','Edges','Masks','-v7.3');
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
