% Example 9.2
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load geyser
n = length(geyser);
% Use Normal Reference Rule for bin width.
h = 3.5*std(geyser)*n^(-1/3);
% Get the bin mesh. Put some extra space on the ends.
t0 = min(geyser) - 1;
tm = max(geyser) + 1;
rng = tm - t0;
nbin = ceil(rng/h);
bins = t0:h:(nbin*h + t0);
% Get the bin counts vk.
vk = histc(geyser,bins);


% Normalize to make it a bona fide density.
fhat = vk/(n*h);
fhat(end) = [];

% To plot this, use bar with the bin centers.
tm = max(bins);
bc = (t0+h/2):h:(tm-h/2);
bar(bc,fhat,1,'w')

xlabel('Waiting Times (minutes)')
ylabel('Probability')
title('Old Faithful - Waiting Time Between Eruptions')


