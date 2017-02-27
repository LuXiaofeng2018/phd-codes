
function tree = addnode(tree,snode,sdim,sval)

% snode is the node number/index that will be split
% sdim is the dimension that will be split on
% sval is the value determining the split
%
% this function will add the left and right nodes based on the new split

% get the new node numbers - total number of nodes
nleft = tree.numnodes +1;
nright = tree.numnodes +2;
tree.numnodes = nright;  	% reset the number of nodes in the tree

% reset things on the parent node
tree.node(snode).term = 0;	% no longer a terminal node
tree.node(snode).children = [nleft nright];
tree.node(snode).split = sval;
tree.node(snode).var = sdim;

% set the easy things
tree.node(nleft).term=1;	% it is a terminal node
tree.node(nright).term=1;
tree.node(nleft).parent = snode;	% the parent is the node number we are splitting
tree.node(nright).parent = snode;
tree.node(nleft).children = [];		% it has no children.
tree.node(nright).children = [];
tree.node(nleft).sibling = nright;
tree.node(nright).sibling = nleft;
tree.node(nleft).split = [];	% no split - terminal node
tree.node(nright).split = [];
tree.node(nleft).var = [];		% no split
tree.node(nright).var = [];

% find the amount of data in the left node
x = tree.node(snode).data;	% these are the data that will be split
[n,dd]=size(x);
ind = find(x(:,sdim)<=sval);
indr = find(x(:,sdim)>sval);
tree.node(nleft).nt = length(ind);	% number of points in the node
tree.node(nright).nt = length(indr);
tree.node(nleft).data=x(ind,:);
tree.node(nright).data=x(indr,:);
for i = 1:length(tree.class)	% find the number in each class
	tree.node(nleft).nkt(i)=length(find(x(ind,dd)==tree.class(i)));
	tree.node(nright).nkt(i)=length(find(x(indr,dd)==tree.class(i)));
end
tree.node(nleft).pjoint=tree.pies.*tree.node(nleft).nkt./tree.Nk;
tree.node(nright).pjoint=tree.pies.*tree.node(nright).nkt./tree.Nk;
tree.node(nleft).pt = sum(tree.node(nleft).pjoint);
tree.node(nright).pt = sum(tree.node(nright).pjoint);
if tree.node(nleft).pt ~= 0
	tree.node(nleft).pclass = tree.node(nleft).pjoint./tree.node(nleft).pt;
else
	tree.node(nleft).pclass = 0;
end
if tree.node(nright).pt ~= 0
	tree.node(nright).pclass = tree.node(nright).pjoint./tree.node(nright).pt;
else
	tree.node(nright).pclass = 0;
end
[mc,ic]=max(tree.node(nleft).pclass);
[mr,ir]=max(tree.node(nright).pclass);
tree.node(nleft).class = tree.class(ic);
tree.node(nright).class = tree.class(ir);
tree.node(nleft).misclass = 1 - mc;
tree.node(nright).misclass = 1 - mr;
tree.node(nleft).impurity = impure(tree.node(nleft).pclass);
tree.node(nright).impurity = impure(tree.node(nright).pclass);
%keyboard
