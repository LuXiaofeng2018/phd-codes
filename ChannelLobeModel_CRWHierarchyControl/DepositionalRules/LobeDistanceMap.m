function [NormedMap] = LobeDistanceMap(GridInfo,pjun,b1,b2,cline)
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
    % taking out the channel part
    Lobeb1 = b1(ipjun:end,:);
    Lobeb2 = b2(ipjun:end,:);
%     Lobecline = cline(1:ipjun,:);
    % make a mask for the channel
    LobeBoundary = [Lobeb1;flipud(Lobeb2);Lobeb1(1,:)];
    % generate the mask
%     Mask = inpolygon(X,Y,LobeBoundary(:,1),LobeBoundary(:,2));
    MaskArry = inpoly([X(:),Y(:)],[LobeBoundary(:,1),LobeBoundary(:,2)]);
    Mask = reshape(MaskArry,size(X));
    % compute distance to centerline
    Map = ones(M,N);
    [I,J]=find(Mask);
    % loop and save the distance maps
    for i=1:length(I)
        x = X(I(i),J(i));y = Y(I(i),J(i));
        tmp_d = 0.01*rand(1)+sqrt((pjun(1)-x)^2+(pjun(2)-y)^2);
        Map(I(i),J(i))=tmp_d;
    end
    % unify and clean irrelavent areas
    Map(~Mask) = nan;
    % initiate memory for normalized distance map
    NormedMap = nan(size(Map));
    % get coordinates of masked area in cartesian
    IX = X(~isnan(Map)); IY = Y(~isnan(Map));
    IX = IX - pjun(1); IY = IY - pjun(2);
    % convert cartesian coordinates of filled pixels into polar coordinates
    [TH,R] = cart2pol(IX,IY);
    % convert cartesian coordinates of filled pixels into polar coordinates
    [THB,RB] = cart2pol(LobeBoundary(:,1)- pjun(1),LobeBoundary(:,2)- pjun(2));
    % range of the theta
    MaxTH = max(TH);MinTH = min(TH);
    % number of bins in polar coordinates
    Nth = 100;
    dth = (MaxTH-MinTH)/Nth;
    th0 = MinTH;
    % find pixels in a bin
    for i=MinTH-dth:dth:MaxTH+dth
        th1 = i;
        if abs(th1-MaxTH)<1e-15
            idx = (TH>=th0)&(TH<=th1);
            HalfTh = (th0+th1)/2;
            [thv, idxb] = min(abs(THB-HalfTh));
        else
            idx = (TH>=th0)&(TH<th1);
            HalfTh = (th0+th1)/2;
            [thv, idxb] = min(abs(THB-HalfTh));
        end
        % get pixels in cartesian grid whose polar coordinates are in this
        % bin
        ii = I(idx);jj = J(idx);
        r = R(idx);
        id = r/max(RB(idxb));% normalize the distance by the boundary
        for k=1:length(ii)
            NormedMap(ii(k),jj(k)) = id(k);
        end
        th0 = th1;
    end
    % the transition line between minus TH and positive TH are not chosen,
    % now fill them up
%     Ii=find(Mask - ~isnan(NormedMap));
% 	[RestTH, RestR]=cart2pol(X(Ii),Y(Ii));
%     [thv,idxb] = min(abs(THB-mean(RestTH)));
%     id = RestR/max(RB(idxb));
%     for k=1:length(Ii)
%         NormedMap(Ii) = id(k);
%     end
    % set the empty area to be -1
    NormedMap(isnan(NormedMap)) = -1;
end