% function [term,misclass,pt] = getinfo(tree)
% This function will extract the data needed from the tree. These data
% are the vector of terminal nodes, and the misclassification rate

function [term,misclass,pt]=getinfo(tree)

tp = squeeze(struct2cell(getfield(tree,'node')));
term = cat(1,tp{1,:});  % this should get the terminal node flags
misclass = cat(1,tp{4,:});	% this should get the misclassification rate in each node
pt=cat(1,tp{5,:});	% this should be the probability that a point is in node t

