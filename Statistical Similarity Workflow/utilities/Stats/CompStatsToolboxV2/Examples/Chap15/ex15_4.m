% Example 15.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load uganda
X = [x,y];
h = 220;
[xl,yl,lamhat] = csintkern(X,ugpoly,h);
pcolor(xl,yl,lamhat)
map = gray(256);
% Flip the colormap so zero is white and max is black.
map = flipud(map);
colormap(map)
shading flat
hold on
plot(ugpoly(:,1),ugpoly(:,2),'k')
hold off
% First plot the surface.
surf(xl,yl,lamhat)
map = gray(256);
map = flipud(map);
colormap(map)
shading flat
% Now plot the dot map underneath the surface.
X(:,3) = -max(lamhat(:))*ones(length(x),1);
ugpoly(:,3) = -max(lamhat(:))*...
			ones(length(ugpoly(:,1)),1);
hold on
plot3(X(:,1),X(:,2),X(:,3),'.')
plot3(ugpoly(:,1),ugpoly(:,2),ugpoly(:,3),'k')
hold off
axis off
grid off