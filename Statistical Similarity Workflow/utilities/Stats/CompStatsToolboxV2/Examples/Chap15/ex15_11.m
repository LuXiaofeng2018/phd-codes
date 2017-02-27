% Example 15.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load uganda
% loads up x, y, ugpoly
xp = ugpoly(:,1);
yp = ugpoly(:,2);
n = length(x);
xg = zeros(n,1);
yg = zeros(n,1);
% Find the maximum and the minimum for a 'box' around
% the region. Will generate uniform on this, and throw
% out those points that are not inside the region.
% Find the bounding box.
minx = min(xp);
maxx = max(xp);
miny = min(yp);
maxy = max(yp);

% Now get the points.
i = 1;
cx = maxx - minx;
cy = maxy - miny;
while i <= n
    xt = rand(1)*cx + minx;
    yt = rand(1)*cy + miny;
    k = inpolygon(xt, yt, xp, yp);
    if k == 1
        % it is in the region
        xg(i) = xt;
        yg(i) = yt;
        i = i+1;
    end
end
