function F = spst_F(D, map, I, options)

% F = spst_F(D, map, I, options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%
%           map     Hypercubic map for uniform csr. For higher data
%                   dimensions (>3) the use of a map and corresponding uniform csr
%                   is strongly advised against. Use map = [] and
%                   options.csr = 'bt' instead.
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
%           options.step:       *0.008*, any positve
%           options.maxD:       *4*, any positive
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


%initialize random numbers algorithm
old = rand('state');
rand('state', 0);

% if options is omitted, set default values
if (nargin < 4)
    options.distmode='euc';
    options.csr='bt';
    options.nP=10000;
    options.iter=1;
    options.step=0.01;
    options.maxD=10;
end
 
% set x-axis and preallocate F
x = 0:options.step:options.maxD;
F = zeros(size(x,2), options.iter);

% if all decoys are used, only one iteration is necessary
if(strcmpi(options.csr, 'all'))
    options.iter=1;
end


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
    
    % if a map is used calculate distance of each point to all events
    % else compute only distance to nearest event
    if (max(size(map))>0)
        dist = distance(sP, D, options.distmode);
        % calculate distance to border for edge correction
        d2b_events = dist2border(D, map);
        d2b_points = dist2border(sP, map);
    else
        dist = nndist(sP, D, 1, options.distmode);
    end
    
    % calculate cumulative distribution 
    for i=1:size(x,2);
        w = x(i);
        
        % if a map is used, apply edge correction
        if (map)
            events = d2b_events <= w;
            points = d2b_points <= w;
            dnn = min(dist(points,events), [], 2);
        else
            dnn = dist;
        end
        
        nn = dnn < w;      
        
        num_set = sum(nn);
        F(i,j) = num_set;
    end
end

F= F./nP;       % We want the fraction of points
F=mean(F,2);    % Get the mean from the iterations
F = [x' F];     % Append x-axis

rand('state', old); % Return random number generator to its original state.
