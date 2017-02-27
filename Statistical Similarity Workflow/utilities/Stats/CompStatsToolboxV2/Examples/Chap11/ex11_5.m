% Example 11.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First load the data.
load insect
% We will look only at the first
% two dimensions in this example.
x = insect(:,1:2);
[n,d] = size(x);

% Choose the number of clusters
k = 3;

% Pick some observations to be the cluster centers.
ind = randperm(n);
ind = ind(1:k);
nc = x(ind,:);
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

while ~isequal(cid,oldcid)	&& iter < maxiter
    oldcid = cid;
    % Implement the hmeans algorithm.
    % For each point, find the distance 
    % to all cluster centers.
    for i = 1:n
        dist = sum((repmat(x(i,:),k,1)-nc).^2,2);
        [m,ind] = min(dist);	% assign it to this cluster
        cid(i) = ind;
    end
    % Find the new cluster centers.
    for i = 1:k
        % find all points in this cluster
        ind = find(cid==i);
        % find the centroid
        nc(i,:) = mean(x(ind,:));
        % Find the number in each cluster;
        nr(i) = length(ind);
    end
    iter = iter + 1
end

% Now find out what ones are in each cluster
% for the complete linkage case.
ind1 = find(cid == 1);
ind2 = find(cid == 2);
ind3 = find(cid == 3);
% Plot using different plotting symbols.

plot(x(ind1,1),x(ind1,2),'.')
hold on
plot(x(ind2,1),x(ind2,2),'+')
plot(x(ind3,1),x(ind3,2),'x')
hold off
xlabel('Width First Joint (microns)')
ylabel('Width Second Joint (microns)')



