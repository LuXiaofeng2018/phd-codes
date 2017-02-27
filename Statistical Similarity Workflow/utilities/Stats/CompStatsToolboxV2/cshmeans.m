function [cid,nr,centers] = cshmeans(x,k,nc)
% CSHMEANS K-means clustering.
%
%   [CID,NR,CENTERS] = CSHMEANS(X,K,NC) Performs K-means
%   clustering using the data given in X. 
%   
%   INPUTS: X is the n x d matrix of data,
%   where each row indicates an observation. K indicates
%   the number of desired clusters. NC is a k x d matrix for the
%   initial cluster centers. If NC is not specified, then the
%   centers will be randomly chosen from the observations.
%
%   OUTPUTS: CID provides a set of n indexes indicating cluster
%   membership for each point. NR is the number of observations
%   in each cluster. CENTERS is a matrix, where each row
%   corresponds to a cluster center.
%
%   See also CSKMEANS


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


warning off
[n,d] = size(x);
if nargin < 3
	% Then pick some observations to be the cluster centers.
    ind = ceil(n*rand(1,k));
	% We will add some noise to make it interesting.
	nc = x(ind,:) + randn(k,d);
end

% set up storage
% integer 1,...,k indicating cluster membership
cid = zeros(1,n);	
% Make this different to get the loop started.
oldcid = ones(1,n);
% The number in each cluster.
nr = zeros(1,k);	
% Set up maximum number of iterations.
maxiter = 100;
iter = 1;

while ~isequal(cid,oldcid)	& iter < maxiter
    oldcid = cid;
	% Implement the hmeans algorithm
	% For each point, find the distance to all cluster centers
	for i = 1:n
		dist = sum((repmat(x(i,:),k,1)-nc).^2,2);
		[m,ind] = min(dist);	% assign it to this cluster center
		cid(i) = ind;
	end
	% Find the new cluster centers
	for i = 1:k
		% find all points in this cluster
		ind = find(cid==i);
		% find the centroid
		nc(i,:) = mean(x(ind,:));
		% Find the number in each cluster;
		nr(i) = length(ind);
	end
	iter = iter + 1;
end
centers = nc;
warning on