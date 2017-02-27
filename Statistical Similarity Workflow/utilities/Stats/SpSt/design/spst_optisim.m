function R = spst_optisim(D, t, nsel, r, K, options)
%
% R = spst_optisim(D, nsel, options)
%
% Optisim Design of a subset of nsel UNIQUE points from a candidate set D
% 
% Input:    D       Candidate points (m,n). 
%                   Rows=observations, columns=variables.
%
%           t       Logical array (m,1). t=true: Rows are included in design
%                   set t = [] to use all points.
%
%           nsel    Number of points to select
%
%           r       Dissimilarity cutoff. Only points with a distance
%                   greater than r from any of the points selected so far
%                   are selectable.
%
%           K       Number of points considered in each iteration. Set K=m
%                   for a maximum diversity design.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.iter    *20*  Number of random starting designs to try.
%
% Output:   R       Logical array (m,1) into D. Subset of nsel datapoints
%                   fulfilling Optisim criteria.
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008
%


% get dataset size
[m n] = size(D);

% use all points, if no preselection is made
if (size(t,1) == 0)
    t = true(m,1);
end

% initialize random numbers generator
old = rand('state');
rand('state', 0);

% number of candidates per round
Kstart = K;

% initialize
recycle = false(m,1);
R = false(m,1);
sim = false(m,1);

% get the first point randomly
start = randperm(m);
R(start(1,1),1) = true; 

counter = 1;

while (K>0)
    
    nR = not(R) & t;
    
    % in order to minimize bias introduced by the random startin point,
    % discard it after two iterations.
    if (counter == 3)
        R(start(1,1),1) = false;
    end
    
    % find candidates. switch to indices instead of logical array
    candidates = find(nR & not(recycle) & not(sim));
    
    % check if there are candidates
    if(size(candidates,1) == 0)
        
        % if there are canditates in the recycle bin, get them for the next
        % iteration
        if (sum(double(recycle)) > 0)
            candidates = find(recycle);
            
        % if there are neither candidates nor recycle points return what
        % has been selected so far and issue a warning.
        else
            disp('spst_optisim exited before number of points to select was reached.');
            disp(strcat('Parameters: nsel: ', num2str(nsel), ', r: ', num2str(r), ' K: ', num2str(Kstart)));
            nselected = sum(double(R));
            disp(strcat('Selected: ', num2str(nselected)));
            error('Check parameters for compatibility with dataset.');
        end
    end
    
    % empty recycle bin
    recycle = false(m,1);
    
    % compute distances between selected and cadidtate points
    Dist = distance(D(R,:), D(candidates,:), options.distmode);
    
    % allow only points above dissimilarity cutoff
    dissim = Dist > r;
    dissim = logical(prod(double(dissim),1));
    %sim(candidates(not(dissim),1),1) = true;
    
    % if there are selectable candidates...
    if (sum(sum(dissim)) > 0)    
        
        candidates = candidates(dissim);
        rp = randperm(size(candidates,1));
        
        % take only a random subset of candidates for dissimilarity
        % selection. If K = m, the algorithm produces a maximum
        % dissimilarity design.
        k = min(size(candidates,1), K);
        test = candidates(rp(1:k));
        
        % select the most dissimilar from the random set
        Dist2 = distance(D(R,:), D(test,:), options.distmode);
        [sorted, ind] = sort(Dist2, 2);
        maxima = ind(:,end);
        R(test(maxima,1),1) = true;

        % those not selected go into the recycle bin 
        recycle(candidates(setdiff(1:size(candidates), maxima),1),1) = true;
    end
    % get the number of points we have so far.
    selected = sum(R);
    % Number of points we can consider in the next iteration.
    K = min(K, (nsel - selected));
    % update counter.
    counter = counter +1;
end

if (options.verbose)
    disp('Optisim finished.');
    disp(strcat('Parameters: nsel: ', num2str(nsel), ', r: ', num2str(r), ' K: ', num2str(Kstart)));
    nselected = sum(double(R));
    disp(strcat('Selected: ', num2str(nselected)));
end

    
% reset random numbers generator
rand('state', old);