function [Map] = ChannelDistanceMap(GridInfo,pjun,cline,LSourceHWidth)
    % taking out grid information
    M = GridInfo.ny; 
    N = GridInfo.nx;
    dx = GridInfo.dx;
    x = [0:1:N-1]*dx;
    y = [0:1:M-1]*dx;
    [X,Y] = meshgrid(x,y);
    % find channel part of the object
    d2pjun = sqrt( (cline(:,1)-pjun(1)).^2 + (cline(:,2)-pjun(2)).^2 );
    [ipjun]=find(d2pjun==0);
    Channelcline = cline(1:ipjun,:);
    % generate distance map
    Map = nan(M,N);
    np = length(Channelcline(:,1));
    cpx = squeeze(Channelcline(:,1));
    cpy = squeeze(Channelcline(:,2));
    R = 0.01*rand(M,N);
    for i=1:np
%         R = 0.01*rand(M,N);
%         A = (cpx(i)-X).^2;
%         B = (cpy(i)-Y).^2;
%         C = sqrt(A+B);
%         tmp_d = R + C;
        tmp_d = R +(((cpx(i)-X).^2)+((cpy(i)-Y).^2)).^0.5;
        Map=min(Map,tmp_d);
    end
% normalize and crop out useless area
    Map = Map/LSourceHWidth;
    Map(Map>1) = -1;
end