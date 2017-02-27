% Example 10.4
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Change the decision boundary. 
bound = -0.5;
ind1 = find(dom <= bound);
ind2 = find(dom > bound);
pmis1 = sum(ppxg1(ind2))*.1;

pmis2 = sum(ppxg2(ind1))*.1;
errorhat = pmis1 + pmis2;
