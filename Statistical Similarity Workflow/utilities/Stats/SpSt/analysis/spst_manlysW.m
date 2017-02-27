function W = spst_manlysW(D, k, options)
%
% W = spst_manlysW(D, k, options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%
%           k       W will be calculated up to the k-th nearest neigbor
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

% if options is omitted, set to default
if (nargin < 3)
    options.distmode='euc';
end

% calculate nearest neighbor distances
dnn = nndist(D, D, k, options.distmode);

% average
W = mean(dnn(:,k));