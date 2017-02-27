% Example 5.22
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This comes in the CS Toolbox.
load cereal
% This file contains the labels and 
% the matrix of 8 observations.

% Construct the star plot - the default
glyphplot(cereal,'glyph','star','Obslabels',labs)
title('Star Plot of Cereal Data')
box on

% Construct the face plot using the 
% Statistics Toolbox function.
glyphplot(cereal,'glyph','face','Obslabels',labs)
box on
title('Chernoff Face Plot of Cereal Data')

