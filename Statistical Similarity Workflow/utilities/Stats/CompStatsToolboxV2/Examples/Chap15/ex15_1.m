% Example 15.1
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load uganda
% This loads up x and y vectors corresponding 
% to point locations.
% It also loads up a two column matrix 
% containing the vertices to the region.
% Plot locations as points.
plot(x,y,'.k')
hold on
% Plot boundary as line.
plot(ugpoly(:,1),ugpoly(:,2),'k')
hold off
title('Volcanic Craters in Uganda')
