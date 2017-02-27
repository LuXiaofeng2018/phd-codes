function [treeseq]= cspruner(tree)
% CSPRUNER  Prune a regression tree.
%
%   TREESEQ = CSPRUNER(TREE)
%   This function implements the pruning procedure for regression
%   trees. The output TREESEQ is a sequence of pruned trees. The
%   input is the inital TREE grown using CSGROWR.
%
%   See also CSGROWR, CSTREER, CSPLOTREER, CSPICKTREER


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


% Find T1 - prune off terminal nodes where the misclassification rate is not better
% than the parent.
[term,nt,imp]=getdata(tree);  
ind = find(term == 1);
indchild=[];
indpar = [];
% decide which ones to prune
w = 0;
for i = 1:length(ind)	% these are the terminal nodes
   parnode = tree.node(ind(i)).parent;
   sibnode = tree.node(parnode).children;
   if all(term(sibnode))	
      % if they are both terminal (i.e., equal to 1), then check for pruning
      rt = imp(parnode);
      rtl = imp(sibnode(1));
      rtr = imp(sibnode(2));
      if rt == (rtl+rtr)
         w = w+1;
         indchild(w) = ind(i);
         indpar(w) = parnode;
      end
   end
end
if ~isempty(indpar)
   indpar=unique(indpar); % get rid of the duplicates
end
if ~isempty(indchild)
   % change the parents to terminal nodes
   tree.node(indpar).term = 1;
   tree.node(indpar).children = [];
   tree.node(indpar).var = [];
   tree.node(indpar).split = [];
   % delete the children
   tree.node(indchild) = [];
   % reset the new number of nodes in the tree
   [term,nt,imp]=getdata(tree);
   tree.numnodes = length(tree.node);
   tree.termnodes = find(term==1);
end
tree.alpha = 0;	
k=1;
treeseq{k} = tree;	% this is the first tree in the sequence

% Note: The variable tree should always have the same number
% of nodes as the original tree(1). We will just be re-setting
% the flags to 1 if terminal and the children to empty.

%oldbranch =[];
numnodes=tree.numnodes;

while numnodes > 1		% find weakest link branches
   k=k+1;
   [term,nt,imp]=getdata(tree);
   % now get the other trees in the sequence
   node = find(term==0);	% all non-term nodes
   numbranch = length(node);  % number of non-term nodes
   gt = zeros(1,numbranch);
   % loop over all of the branches (non-terminal nodes)
   for i = 1:numbranch
      % get the weakest link function for all of the branches
      gt(i) = brncherr(node(i),tree);
   end
   [mg,mi]=min(gt);	% find the weakest link
   weak=find(gt==mg);
   mi=max(weak);	% prune the maximum node, if more than one weak link
   % prune those branches 
   branch=getbranch(node(mi),tree);
%   branch = [oldbranch(:); brn(:)];
%   oldbranch = branch;	% keep track of all nodes pruned
   tree.node(node(mi)).term=1;
   tree.node(node(mi)).children=[];
   tree.node(node(mi)).split=[];
   tree.node(node(mi)).var=[];
   for i=1:length(branch)
      tree.node(branch(i)).term = 100;		% a flag of 100 means pruned off
   end
   
   numnodes = numnodes - length(branch);	% number of nodes pruned off
   tree.alpha = mg;
   treeseq{k}=tree;
   
%   tmp=tree;
%   tmp.node(branch)=[];
%   tmp.numnodes =length(tmp.node);
%   [term,nt,imp]=getdata(tmp);
%   tmp.termnodes=find(term==1);
%   tmp.alpha=mg;
%   treeseq{k}=tmp;
   
   
%   tree.node(branch)=[];
%   tree.numnodes = length(tree.node);
%   [term,nt,imp]=getdata(tree);
%   tree.termnodes = find(term==1);
%   tree.alpha = mg;
%   treeseq{k}=tree;
   
end

   
   


