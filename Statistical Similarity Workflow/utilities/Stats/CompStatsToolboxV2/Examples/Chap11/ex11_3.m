% Example 11.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

x = [1 1; 1 2; 2 1; -1 -1; -1 -2];
ye = pdist(x,'euclid');
ycb = pdist(x,'cityblock');
zsineu = linkage(ye,'single');
zcompeu = linkage(ye,'complete');
zsincb = linkage(ycb,'single');
zcomcb = linkage(ycb,'complete');

% Find the cophenetic coefficients:
ccompeu = cophenet(zcompeu,ye);
csineu = cophenet(zsineu,ye);
csincb = cophenet(zsincb,ycb);
ccomcb = cophenet(zcomcb,ycb);