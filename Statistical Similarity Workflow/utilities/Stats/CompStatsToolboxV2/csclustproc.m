function [x,y] = csclustproc(npar,region,regionp,lam,r)
% CSCLUSTPROC Generate locations for a cluster process.
%
%   [X,Y] = CSCLUSTPROC(NPAR,REGION,REGIONP,LAMBDA,R)
%
%   This generates locations X and Y that follow a cluster
%   process. 
%
%   NPAR is the number of parents.
%   REGION is the set of vertices for the study region. This is
%   a 2 column matrix, where the first column represents the
%   x locations for the vertices and the second column holds the
%   y locations for the vertices. 
%   REGIONP represents the region over which to generate the parent
%   locations. The format is the same as in REGION.
%   LAMBDA is the average number of children per parent.
%   R governs the radius of the clusters.
%
%   See also CSPOISSPROC, CSBINPROC, CSINHIBPROC, CSSTRAUSPROC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox



% get the vertices for the regions
rx = region(:,1);
ry = region(:,2);
rxp = regionp(:,1);
ryp = regionp(:,2);

sig = r*eye(2);

% Get all of the parents
[xp,yp] = csbinproc(rxp, ryp, npar);

% get the number of children per parent
nchild = cspoirnd(lam,npar);

X = [];
% Locate the chilren
for i = 1:npar
	xc = randn(nchild(i),2)*sig + repmat([xp(i) yp(i)],nchild(i),1);
	X = [X; xc];
end

% Find the children that are within R.
ind = find(inpolygon(X(:,1), X(:,2), rx, ry));

% Those are the required children
x = X(ind,1);
y = X(ind,2);


