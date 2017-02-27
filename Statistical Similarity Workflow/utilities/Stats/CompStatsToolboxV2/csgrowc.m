function tree = csgrowc(X,maxn,clas,Nk,pies)
% CSGROWC   Classification Tree.
%
%   TREE = CSGROWC(X,MAXN,CLAS,NK,PRIORS)
%
%   This function grows a classification tree.
%   X is a matrix containing the cases, along with a class label.
%   Each row contains a case. The first d columns of X correspond
%   to the variables/features and the last column is the class
%   label.
%   MAXN is the maximum number of cases allowed in a terminal node
%   if they do not all belong to the same class.
%   CLAS is a vector of numeric class labels: 1, 2, ...
%   NK is the number of cases in each class.
%   PRIORS is a vector of prior probabilities for each class. If this
%   is not provided, then the priors are estimated based on the 
%   number in each class.
%
%   See also CSPRUNEC, CSTREEC, CSPLOTREEC, CSPICKTREEC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

[n,dd] = size(X);
%d = d-1;
if nargin == 4	% then estimate the pies
	pies = Nk/n;
end

% The tree will be implemented as a structure
% get the initial tree - which is the data set itself
tree.pies = pies;
tree.class = clas;  % need for node impurity calcs
tree.Nk = Nk;
tree.maxn = maxn;	% maximum number to be allowed in the terminal nodes
tree.numnodes = 1;	% number of nodes in the tree - total
tree.termnodes = 1;	% vector of terminal nodes
tree.node.term = 1;	% (1) 1=terminal node, 0=not terminal
tree.node.nt = sum(Nk);  % (2) total number of points in the node
tree.node.impurity = impure(pies);   % (3)
tree.node.misclass = 1-max(pies);	% 1 - max(tree.node.pclass)  (4)
tree.node.pt = 1;	% prob it is node t  (5)
tree.node.parent = 0; % root node has no parent
% this will be a 2 element vector of node numbers to the children
tree.node.children = []; 
tree.node.sibling = [];	% pointer to sibling node
tree.node.class = [];  % the class membership associated with this node
tree.node.split = []; % the splitting value
tree.node.var = [];   % the variable or dimension that will be split
tree.node.nkt = Nk;	% number of points from each class in this node
% joint prob it is class k and it falls into node t
tree.node.pjoint = pies;
tree.node.pclass = pies;	%prob it is class k given node t
tree.node.data = X;	% the root node contains all of the data

% Now get started on growing the tree very large
% first we have to extract the number of terminal nodes that 
% qualify for splitting.
[term,nt,imp]=getdata(tree);	% get the data needed to decide to split the node

% find all of the nodes that qualify for splitting
ind = find( (term==1) & (imp>0) & (nt>maxn) );

% now start splitting
while ~isempty(ind)	% while there are terminal nodes that qualify for split
%for k=1:2
   for i=1:length(ind)	% check all of them
      % get split
      [split,dim]=splitnode(tree.node(ind(i)).data,tree.node(ind(i)).impurity,...
         tree.class,tree.Nk,tree.pies);
      % split the node
      tree = addnode(tree,ind(i),dim,split);
   end  % end for loop
   [term,nt,imp]=getdata(tree);
   tree.termnodes = find(term==1);
   ind = find( (term==1) & (imp>0) & (nt>maxn) );
   length(tree.termnodes);
   itmp = find(term==1);
 %end
end  % end while loop


