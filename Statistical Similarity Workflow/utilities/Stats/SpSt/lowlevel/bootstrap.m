function sP = bootstrap(nP, I, replacement)
%
% sP = bootstrap(nP, I, replacement)
%
% Bootstrap sample of size nP from original data I, drawn with or without
% replacement.
%
%
%   Input:      nP              (int)       Size of the bootstrap sample.
%
%               I                           Original data.
%
%               replacement     (Boolean)   Sample with or without
%                                           replacement.
%
%   Output:     sP      Pseudo-datapoints. (nP x dim(I))
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

[m n] = size(I);

% If you want to sample with replacement, you need the statistics toolbox.
if (replacement)
    if (license('checkout', 'statistics_toolbox'))
        t = randsample(m,nP, 1);
    else
        error('bootstrap: Statistics toolbox not available. Run with replacment = false');
    end
else
    if(nP <= m)
        r = randperm(m);
        t = r(1:nP);
    else
        error('bootstrap: not enough datapoints. If Statistics toolbox is available use replacement = true');
    end
end

t= t';

sP = I(t,:);