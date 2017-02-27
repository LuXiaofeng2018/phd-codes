function G = spst_G(D, map, options)
%
% G = spst_G(D, map, options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%
%           map     Hypercubic map for uniform csr. For higher data
%                   dimensions (>3) the use of a map and corresponding edge
%                   correction is strongly advised against. Use map = [] instead.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           options.step:       *0.008*, any decimal
%           options.maxD:       *4*, any integer
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


[m n] = size(D);


% if options is omitted, set default values
if (nargin < 3)
    options.distmode='euc';
    options.step=0.01;
    options.maxD=10;
end

% set x-axis and preallocate G
x = 0:options.step:options.maxD;
G = zeros(size(x,2), 1);

% if a map is used calculate distance to border for edge correction
if (max(size(map))>0)
    d2b_events = dist2border(D, map);
    d2b_events = d2b_events * ones(1,size(x,2));
end

% For each event calculate distance to nearest neighbor
dist = nndist(D, D, 1, options.distmode);
dist = dist*ones(1,size(x,2));

% calculate cumulative distribution 
w = ones(m,1)*x;
dnn = dist < w;

% if a map is used, apply edge correction
if (map)
    in_center = d2b_events <= w;
    nn = dnn & in_center;
else
    nn = dnn;
end      

G = (sum(nn)./m)';   % We want the fraction of events

G = [x' G];  % Append x-axis 
