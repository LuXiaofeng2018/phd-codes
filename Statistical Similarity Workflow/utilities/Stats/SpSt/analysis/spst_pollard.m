function P = spst_pollard(D, map, k, I, options)
%
% P = spst_pollard(D, map, I, options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%
%           map     Hypercubic map for uniform csr. For higher data
%                   dimensions (>3) the use of a map and corresponding uniform csr
%                   is strongly advised against. Use map = [] and options.csr = 'bt' instead.
%
%           k       Distances to the k-th nearest event are used for the
%                   calculation.
%
%           I       Background data for the generation of bootstrap or
%                   convex pseudo-data csr.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           options.csr:        *'bt'*, 'pseudo', 'disc', 'dec', 'all'
%           options.nP:         *10000*, any integer
%           options.iter:       *20*, any integer
%           options.step:       *0.008*, any decimal
%           options.maxD:       *4*, any integer
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


%initialize random numbers algorithm
old = rand('state');
rand('state', 0);

% if options is omitted, set default values
if (nargin < 5)
    options.distmode='euc';
    options.csr='bt';
    options.nP=10000;
    options.iter=1;
    options.step=0.01;
    options.maxD=10;
end

% initialize
p = zeros(1,options.iter);

% start calculation
for j=1:options.iter
    nP = options.nP;
    % generate random points
    if strcmpi(options.csr, 'bt')
        sP = bootstrap(nP, I,options.replacement);
        
    elseif strcmpi(options.csr, 'all')
        sP = I;
        nP = size(sP,1);
    elseif strcmpi(options.csr, 'pseudo')
        sP = convex_pseudo_data(nP, I);
    elseif strcmpi(options.csr, 'dec')
        sP = unifcsr(map, nP, 'dec');
    elseif strcmpi(options.csr, 'disc')
        sP = unifcsr(map, nP, 'disc');
    else
        error('spst_F: CSR (options.csr) mode not supported.');
    end
    
    % calculate distances to k nearest neighbors
    dist = nndist(sP, D, k, options.distmode);
    
    % only k-th nearest neighbor is needed
    dist = dist(:,k);
    
    % get squared distances
    dist = dist.^2;
    
    % sum of squared distances
    sX2 = sum(dist);
    
    %sum of natural logarithms
    slnX2= sum(log(dist));
    
    % calculate p for this iteration
    p(1,j) = 12*k^2*options.nP*(options.nP*log(sX2/options.nP) - slnX2)/((6*k*options.nP+options.nP+1)*(options.nP-1));
    
end

P = mean(p,2);
    
    
    
    
    



