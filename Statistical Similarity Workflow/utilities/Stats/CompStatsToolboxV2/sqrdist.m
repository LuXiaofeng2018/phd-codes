function dist = sqrdist(x,nc)
% This returns a vector of k distances from observation x to all of the
% cluster centers.
[k,d]=size(nc);
dist = sum((repmat(x,k,1)-nc).^2,2);
