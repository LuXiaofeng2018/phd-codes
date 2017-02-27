function R = spst_kennardstone(D, t, nsel, options)
%
% R = spst_kennardstone(D, t, nsel, options)
%
% Kennard-Stone design from a set of candidate points D
% 
% Input:    D       Candidate points (m,n). Rows are observations, columns
%                   variables.
%
%           t       Logical array (m,1). t=true: Rows are included in design
%                   set t = [] to use all points.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           
%
% Output:   D       Distance matrix (mX,mQ)
%
% Copyright:        Knut Baumann, Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Departme nt of Pharmaceutical Chemistry
%                   2008


[m n] = size(D);

% use all points, if no preselection is made
if (size(t,1) == 0)
    t = true(m,1);
end

% initialize
R = false(m,1);

% If the number of candidates is smaller than the number of points to
% select return all candidates and issue warning
if (sum(t) <= nsel)
    R(t,1) = true;
    warning('spst_kennardstone: Number of candidates smaller than nsel!!');
    return;
end

% The point next to the Center of Mass is the first point to be chosen
CoM = mean(D(t,:));
dist2center = sqeudist(CoM, D);
dist2center(not(t)) = 99999999999;
[sorted, IDY] = sort(dist2center, 'ascend');
start = IDY(1);
R(start,1) = true;


while (sum(R) < nsel)
    
    % candidates not yet chosen
    nR = not(R) & t;
    
    % convert to indices instead of logical
    candidates = find(nR);
    
    % distance to nearest neighbors
    nnD = nndist(D(nR,:), D(R,:), 1, options.distmode);
    
    % select the point with the maximum nearest neighbor distance
    [Y, ind] = max(nnD);
    R(candidates(ind),1) = true;
end

