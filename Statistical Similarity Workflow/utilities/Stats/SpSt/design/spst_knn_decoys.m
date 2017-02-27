function R = spst_knn_decoys(D, X, t, nsel, options)

if (size(t,1) < 1)
    t = true(size(D,1),1);
end

% number of actives
n = sum(t);

% number of decoys per active
k = floor(nsel/n);

R = false(size(X,1),1);

[D, IDY] = nndist(D(t,:), X, size(X,1), options.distmode);

nns = IDY(:,1:k);
nns = unique(nns(:));

b = min(nsel, size(nns,1));

R(nns(1:b),1) = true;
l= k+1;
remaining = nsel - sum(R);

while ((remaining >0) && (l <= size(IDY,2)))
    selected = find(R);
    lnns = unique(IDY(:,l));
    select = setdiff(lnns, selected);
    
    if ((size(select,1) <= remaining) && size(select,1) >0)
        R(select,1) = true;
    elseif((size(select,1) > remaining) && size(select,1) >0)
        t = randperm(size(select,1));
        t = t(1:remaining);
        R(select(t),1) = true;
    end
    l=l+1;
    remaining = nsel - sum(R);
end

if (remaining ~= 0)
    warning(strcat('spst_knn_decoys: ', remaining, ' datapoints missing.'));
end
