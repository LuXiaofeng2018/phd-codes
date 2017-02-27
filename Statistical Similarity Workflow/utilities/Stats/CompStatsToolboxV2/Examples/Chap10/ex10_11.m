% Example 10.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Use the data from the previous example.
% Construct a tree using classregtree.
% The 'splitmin' parameter tells MATLAB that
% there has to be at least 5 observations in
% a node to split it.
t = classregtree(X,clab,'splitmin',5,...
    'method','classification')

view(t)
