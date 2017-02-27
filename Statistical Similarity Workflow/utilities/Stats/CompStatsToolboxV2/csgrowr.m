function tree = csgrowr(X,y,maxn)
% CSGROWR   Regression tree.
%
%   TREE = CSGROWR(X,Y,MAXN)
%   This function will grow a regression tree.
%   X is a matrix of observed values of the predictor variables.
%   Y is a vector of observed values of the response variable.
%   MAXN is the maximum number of observations allowed in a 
%   terminal node.
%
%   See also CSPRUNER, CSTREER, CSPLOTREER, CSPICKTREER


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


% Here is where the function should start
n = length(y);

% The tree will be implemented as a structure
% get the initial tree - which is the data set itself
tree.maxn = maxn;	% maximum number to be allowed in the terminal nodes
tree.n = n;	% total number of points
tree.numnodes = 1;	% number of nodes in the tree - total
tree.termnodes = 1;	% vector of terminal nodes
tree.node.term = 1;	% (1) 1=terminal node, 0=not terminal
tree.node.nt = n;  % (2) total number of points in the node
tree.node.impurity = sqrer(y,tree.n);   % Response for root is average value of responses
tree.node.parent = 0; % root node has no parent
% this will be a 2 element vector of node numbers to the children
tree.node.children = []; 
tree.node.sibling = [];	% pointer to sibling node
tree.node.yhat = mean(y);  % average of the responses in the node
tree.node.split = []; % the splitting value
tree.node.var = [];   % the variable or dimension that will be split
tree.node.x = X;	% the root node contains all of the data
tree.node.y = y;

% Now get started on growing the tree very large
% first we have to extract the number of terminal nodes that 
% qualify for splitting.
[term,nt,imp]=getdata(tree);	% get the data needed to decide to split the node

% find all of the nodes that qualify for splitting
ind = find( (term==1) & (imp>0) & (nt>maxn) );
% now start splitting
while ~isempty(ind)	% while there are terminal nodes that quality for split
   for i=1:length(ind)	% check all of them
      % get split
      [split,dim]=splitnoder(...
         tree.node(ind(i)).x,...
         tree.node(ind(i)).y,...
         tree.node(ind(i)).impurity,...
         tree.n);
      % split the node
      tree = addnoder(tree,ind(i),dim,split);
   end  % end for loop
   [term,nt,imp]=getdata(tree);
   tree.termnodes = find(term==1);
   ind = find( (term==1) & (imp>0) & (nt>maxn) );
end  % end while loop

