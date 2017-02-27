% -------------------------------------------------------------------------
% Surface Proc
% -------------------------------------------------------------------------
clear;close all;
RGBPic=imread('TCut1.jpg');
% -------------------------------------------------------------------------
% show original photo
figure;
% imagesc(photo);
imshow(RGBPic);
%% ------------------------------------------------------------------------
% PACKED FUNCTION
[EdgeMap,EdgeCoor,LobeMask,SPt] = ExtractEdge(RGBPic);
% EdgeCoor = cell2mat(EdgeCoor(1));
hfb = figure;
imshow(EdgeMap);
hfc = figure;
[ny,nx]=size(EdgeMap);
plot(EdgeCoor(:,2),EdgeCoor(:,1),'-r');
axis([0 nx-1 0 ny-1]);
set(gca,'YDir','reverse');
hfm=figure;
imshow(LobeMask);
figure(hfc);
hold on;
plot(SPt(:,2),SPt(:,1),'b.','MarkerSize',40);