% Example 11.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First load the data.
load insect
% We will look only at the first
% two dimensions in this example.
X = insect(:,1:2);
plot(X(1:10,1),X(1:10,2),'.')
hold on
plot(X(11:20,1),X(11:20,2),'+')
plot(X(21:30,1),X(21:30,2),'x')
hold off
xlabel('Width First Joint (microns)')
ylabel('Width Second Joint (microns)')

% Then get the pairwise distances. 
% We will use Euclidean distance.
d = pdist(X);
% Now get two types of linkage.
zs = linkage(d,'single');
zc = linkage(d,'complete');
% Now plot in dendrograms.
dendrogram(zs);
title('Single Linkage')

set(gcf,'pos',[9    95   800   500])

figure
dendrogram(zc);
title('Complete Linkage')

set(gcf,'pos',[9    95   800   500])

% Get the membership for 3 clusters.
Ts = cluster(zs,'maxclust',3);
Tc = cluster(zc,'maxclust',3);
% Now find out what ones are in each cluster
% for the complete linkage case.
ind1 = find(Tc == 1);
ind2 = find(Tc == 2);
ind3 = find(Tc == 3);

% Results are:
%      1     2     4     5     7     8     9    11    15
%      3    12    13    14    16    17    18    19    20
%      6    10    21    22    23    24    25    26    27    28    29    30

% Now look at the cophenetic coefficient to
% compare single and complete linkage.
cophs = cophenet(zs,d)
cophc = cophenet(zc,d)



