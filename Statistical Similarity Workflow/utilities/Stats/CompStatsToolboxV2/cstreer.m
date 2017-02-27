function [yhat,node]=cstreer(x,tree)
% CSTREER   Return estimated response from regression tree.
%
%   [YHAT,NODE] = CSTREER(X,TREE)
%   This function returns the estimated response YHAT for an observation
%   X from a regression tree. The TREE is obtained from CSGROWR.
%   The output also includes the terminal NODE that X falls into.
%
%   See also CSGROWR, CSPRUNER, CSPLOTREER, CSPICKTREER


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

n = 1;	% start at node 1 - the root
term = 0;	% not a terminal node
while term ==0 		% while not a terminal node or not pruned
   % get split index and split value
   ind = tree.node(n).var;
   sval = tree.node(n).split;
   if x(ind) <= sval		% go to the left
      n = tree.node(n).children(1);
   else
      n = tree.node(n).children(2);	% go to the right
   end
   term = tree.node(n).term;	% is this a terminal node
end
% once it is a terminal node, it drops out of the loop
% that will be the value of n
yhat = tree.node(n).yhat;
node = n;