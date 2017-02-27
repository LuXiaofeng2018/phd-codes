% Example 5.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load tibetan
% This loads up all 5 measurements of the skulls.
% We use the fourth characteristic to illustrate
% the stem-and-leaf plot. We first round them.
x = round(tibetan(:,4));
% Figure 5.4
csstemleaf(x)
title('Height (mm) of Tibetan Skulls')
% Figure 5.5
csstemleaf(x,2)
title('Height (mm) of Tibetan Skulls')
