function [D, IDQ] = nndist(X, Q, k, mode)

% [D, IDQ] = nndist(X, Q, k, mode)
%
% Nearest neighbor distance of two matrices X, Q
% Colums are variables, rows observations. For each observation in X, 
% determine the distance to its k nearest neighbors in Q. 
%
% Input:    X, Q    Data matrices. Of mX, mQ rows and nX, nQ columns. 
%                   Rows are observations, columns are variables.
%
%           k       number of nearest neighbors in Q to be considered
%
%           mode    distance mode. Possible values include:
%                   'euc':      Euclidean distance
%                   'cheby':    Chebychev distance
%                   'city':     City-Block (Manhattan) Distance
%
% Output:   D       Distance matrix (mX,k)
%
%           IDQ     Row-indices in Q of the k nearest neighors of each
%                   observation in X. (mX, k)
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


[mX nX] = size(X);
[mQ nQ] = size(Q);

% initialize
D = zeros(mX, k);
IDQ = zeros(mX, k);

% check if X and Q are identical;
identical = (mX == mQ) && (nX == nQ) && logical(prod(prod(double(X==Q))));

if (mX*mQ <= 10000000)              % Conservative estimation: Will the problem fit in memory?
    
    % calculate distance matrices according to distance mode
    if (strcmpi(mode, 'euc'))
        d = sqeudist(X, Q);
        d = sqrt(d);
    elseif(strcmpi(mode, 'cheby'))
        d = chebydist(X, Q);
    elseif(strcmpi(mode, 'city'))
        d = citydist(X,Q);
    else
        error(strcat('nndist: mode:', mode, ' not supported'));
    end
    
    % if X and Q are identical, take out diagonal
    if (identical)
        bigdiag = diag(ones(size(d,1),1).*999999999);
        d = d+bigdiag;
    end
    
    % sort in ascending order along rows
    [sd, id] = sort(d, 2);
    
    % distances to k nearest neighbors
    D = sd(:,1:k);
    % row-indices of k nearest neighbors in Q
    IDQ = id(:,1:k);
    
else
    
    % Split the problem to chunks.
    % With larger chunk sizes the program will get faster but more memory
    % consuming. You can speed up the program by adjusting the chunk size
    % to what is feasible on your system.
    
    ch_size = 100;
    chunks = 1:ch_size:mX;
    numchunks = numel(chunks);
    
    % do the same as above for every chunk
    for c = 1:numchunks-1
        
        if (strcmpi(mode, 'euc'))
            d = sqeudist(X(chunks(c):(chunks(c)+ch_size-1),:),Q);
            d = sqrt(d);
        elseif(strcmpi(mode, 'cheby'))
            d = chebydist(X(chunks(c):(chunks(c)+ch_size-1),:),Q);
        elseif(strcmpi(mode, 'city'))
            d = chebydist(X(chunks(c):(chunks(c)+ch_size-1),:),Q);
        else
            error(strcat('nndist: mode:', mode, ' not supported'));
        end
            
        if (identical)
            bigdiag = diag(ones(ch_size,1).*9999999999);
            d(:,chunks(c):chunks(c)+ch_size-1) = d(:,chunks(c):chunks(c)+ch_size-1)+bigdiag;
        end
        
        [sd id] = sort(d, 2);
        D(chunks(c):chunks(c)+ch_size-1,:) = sd(:,1:k);
        IDQ(chunks(c):chunks(c)+ch_size-1,:) = id(:,1:k);
    end
    
    % the last chunk might be shorter than the preceding ones
    % and must therefore be handled separately
    
    if (strcmpi(mode, 'euc'))
        d = sqeudist(X(chunks(c):end,:),Q);
        d = sqrt(d);
    elseif(strcmpi(mode, 'cheby'))
        d = chebydist(X(chunks(c):end,:),Q);
    elseif(strcmpi(mode, 'city'))
        d = citydist(X(chunks(c):end,:),Q);
    else
        error(strcat('nndist: mode:', mode, ' not supported'));
    end
    
    if (identical)
        nummissing = mX-chunks(c)+1;
        bigdiag = diag(ones(nummissing,1).*999999999);
        d(:,chunks(c):end) = d(:,chunks(c):end)+bigdiag;
    end
    
    [sd id] = sort(d, 2);
    D(chunks(c):end,:) = sd(:,1:k);
    IDQ(chunks(c):end,:) = id(:,1:k);
    
end