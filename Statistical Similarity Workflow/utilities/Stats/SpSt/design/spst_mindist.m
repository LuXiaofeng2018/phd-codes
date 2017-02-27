function R = spst_mindist(D, t, nsel, k, options)
%
% R = spst_mindist(D, nsel, options)
%
% Minimum Distance Design of a subset of nsel UNIQUE points from 
% a candidate set D. 
% 
% Input:    D       Candidate points (m,n). 
%                   Rows=observations, columns=variables.
%
%           t       Logical array (m,1). t=true: Rows are included in design
%                   set t = [] to use all points.
%
%           nsel    Number of points to select
%
%           k       Distances up to the k nearest neighbor are considered
%                   in the design.
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.iter    *20*  Number of random starting designs to try.
%           options.distmode 'euc', 'cheby','city'
%
% Output:   R       Logical array (m,1) into D. Subset of nsel datapoints
%                   with minimum sum of intraset k-nn distances.
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008
%
% check for valididty of k and nsel
if(k>nsel)
    error('spst_mindist: k must be k<=nsel !!!');
end

% get dataset size
[m n] = size(D);
start_des_tries=50;
global_best_sD = Inf;

% initialize random numbers generator
old = rand('state');
rand('state', 0);

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
    warning('spst_mindist: Number of candidates smaller than nsel!!');
    return;
end

for j=1:start_des_tries
    
    %if (options.verbose)
    %    disp(strcat('spst_mindist: Random starting design number:', num2str(j)));
    %end
    % generate random starting design
    s = randperm(sum(t));
    ind = find(t);
    RR = false(m,1);
    RR(ind(s(1)),1) = true;
    has_changed = true;
    iter = 0;


    while(has_changed && iter <= options.iter)
        has_changed = false;
        iter = iter + 1;
        %if (options.verbose)
        %    disp(strcat('Iteration:', num2str(iter)));
        %end
        tabu = true(m,1);
        
        for i=1:nsel
            % find points in and not in set
            r = find(RR);
            nr = find(not(RR) & tabu);

            % compute old sum of intraset knn distances
            kk = min(k-1, size(r,1));
            oldD = sum(sum(nndist(D(r,:), D(r,:), kk, options.distmode)));
            
            
            if (size(r,1) == nsel)
                % remove row i without setdiff
                r2 = [r(1:i-1,1); r(i+1:end,1)];
            else
                r2 = r;
            end
            
            % calculate knn distances to candidates
            kk = min(k-1, size(r2,1));
            knnD = sum(nndist(D(nr,:), D(r2,:), kk, options.distmode),2);

            % find index in D with smallest knnD
            [mknnD, ind] = min(knnD);
            index = nr(ind);
            
            if (size(r,1) == nsel)
                % incorporate in new design
                r2 = [r(1:i-1,1); index; r(i+1:end,1)];
            else
                r2 = [r; index];
            end
            
            % calculate new intraset distances
            kk = min(size(r2,1), k);
            newD = sum(sum(nndist(D(r2,:), D(r2,:), kk, options.distmode)));

            % make swap if newD<oldD or set is not complete
            if(size(r,1) < nsel || newD < oldD)
                has_changed=true;
                RR = false(m,1);
                RR(r2,1) = true;
                tabu(r(i),1) = false;
            end
        end
    end
    
    % calculate final intraset distances
    newD = sum(sum(nndist(D(RR,:), D(RR,:), k-1, options.distmode)));
    
    if (newD < global_best_sD)
        R = RR;
        global_best_sD = newD;
        if (options.verbose)
            disp(global_best_sD);
            disp(strcat('Sum of intraset knn distances now at:', num2str(global_best_sD)));
        end
    end
end


