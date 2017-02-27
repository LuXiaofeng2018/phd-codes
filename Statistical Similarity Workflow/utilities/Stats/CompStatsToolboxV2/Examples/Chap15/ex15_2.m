% Example 15.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load cardiff
% This loads up x and y vectors corresponding 
% to point locations.It also loads up a two 
% column matrix containing the vertices
% to the region.
% Plot locations as points and boundary as line.
% Note: can do as one command:
plot(x,y,'.k',cardpoly(:,1),cardpoly(:,2),'k')
title('Juvenile Offenders in Cardiff')
