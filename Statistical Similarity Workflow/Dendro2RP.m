function RP = Dendro2RP(Z,Ord)
    % transform the cluster informaiton
    Z = transz(Z);
    % loop Ord to get the reachability map
    n = length(Ord);
    RP = nan(length(Ord),1);
    RP(1) = max(Z(:,3));
    for i=2:n
        a = Ord(i); % current  node
        b = []; % pair current node with previous nodes
        for j=i-1:-1:1
            b = [b; a,Ord(j)];
        end
        b = sort(b,2);
        % find paris in Z having a
        [I,J]=find(Z(:,1:2)==a);
        c = Z(I,1:2);
%         c = sort(c,2);
        % find the common pair
        Lic = ismember(c,b,'rows');
        % distance belongs to the common pair is the reachability value of
        % a
        RP(i) = Z(I(Lic),3);
    end

% ---------------------------------------
function Z = transz(Z)
%TRANSZ Translate output of LINKAGE into another format.
%   This is a helper function used by DENDROGRAM and COPHENET.

%   In LINKAGE, when a new cluster is formed from cluster i & j, it is
%   easier for the latter computation to name the newly formed cluster
%   min(i,j). However, this definition makes it hard to understand
%   the linkage information. We choose to give the newly formed
%   cluster a cluster index M+k, where M is the number of original
%   observation, and k means that this new cluster is the kth cluster
%   to be formmed. This helper function converts the M+k indexing into
%   min(i,j) indexing.

m = size(Z,1)+1; 
for i = 1:(m-1)
    if Z(i,1) > m
        Z(i,1) = traceback(Z,Z(i,1));
    end
    if Z(i,2) > m
        Z(i,2) = traceback(Z,Z(i,2));
    end
    if Z(i,1) > Z(i,2)
        Z(i,1:2) = Z(i,[2 1]);
    end
end


function a = traceback(Z,b)

m = size(Z,1)+1;

if Z(b-m,1) > m
    a = traceback(Z,Z(b-m,1));
else
    a = Z(b-m,1);
end
if Z(b-m,2) > m
    c = traceback(Z,Z(b-m,2));
else
    c = Z(b-m,2);
end

a = min(a,c);
