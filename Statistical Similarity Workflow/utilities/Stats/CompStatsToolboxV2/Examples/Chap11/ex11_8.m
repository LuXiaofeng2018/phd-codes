% Example 11.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Let's look at model 7, 3 groups of the
% insect data.
% We extract the parameter information:
pies = allmodel(7).clus(3).pies;
mus = allmodel(7).clus(3).mus;
vars = allmodel(7).clus(3).vars;

% Find the group labels.
[clabs7,unc] = mixclass(X,pies,mus,vars);

% Find the observations in each group.
ind1 = find(clabs7 == 1);
ind2 = find(clabs7 == 2);
ind3 = find(clabs7 == 3);