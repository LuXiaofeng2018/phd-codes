% Example 11.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Get the cluster output from the linkage function.
zsingle = linkage(ye,'single');
zcomplete = linkage(ye,'complete');
% Get the dendrogram.
dendrogram(zsingle)
title('Clustering - Single Linkage')

dendrogram(zcomplete)
title('Clustering - Complete Linkage')

