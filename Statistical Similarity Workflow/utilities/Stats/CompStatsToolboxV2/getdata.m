% function [term,nkt,imp] = getdata(tree)
% This function will extract the data needed from the tree. These data
% are the vector of terminal nodes, the number of points in each node
% and the impurity for each node.

function [term,nkt,imp]=getdata(tree)

tp = squeeze(struct2cell(getfield(tree,'node')));
term = cat(1,tp{1,:});  % this should get the terminal node flags
nkt = cat(1,tp{2,:});	% this should get the number of points in each node
imp = cat(1,tp{3,:});	% this should get the impurity of the nodes


