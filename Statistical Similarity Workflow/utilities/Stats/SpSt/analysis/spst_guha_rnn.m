function RNN = spst_guha_rnn(D, options)
%
% RNN = spst_guha_rnn(D, options)
%
% Input:    D       Data matrix with rows = observations, columns=variables
%                   (m,n)
%
%           options Options struct variable. Default values are indicated
%                   by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           options.step:       *0.008*, any decimal
%           options.maxD:       *4*, setting maxD to 'max', causes the
%                                   maximum intra-set distance to be
%                                   determined at run-time.
%           options.normalize   *true*, logical. RNN is normalized by the
%                                   number of points - 1.
%
%
% Output:   RNN     RNN curves for D. First column: x-Axis.
%
%
% Reference:
% Guha R, Dutta D, Jurs PC, Chen T.
% R-NN curves: an intuitive approach to outlier detection using a distance based
% method.
% J. Chem. Inf. Model. 2006, 46(4):1713-22
%
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


if (nargin < 2)
    options.step = 10;
    options.distmode= 'euc';
    options.normalize = true;
    options.maxD=10;
end

[m n] = size(D); % Determine dataset size


% Distance matrix
Dist = distance(D, D, options.distmode);

% allow the user to set maxD without knowing it prior.
if (ischar(options.maxD) && strcmpi(options.maxD, 'max'))
    options.maxD = max(max(Dist));
end

% generate x-Axis
x = (0:options.step:options.maxD);
% exclude self-self distances
Dist = Dist + diag(ones(size(Dist,1),1).*999999999);

%initialize
RNN=zeros(size(x,1), m);

% calculate RNN
for j = 1:size(x,2)
    y = sum((Dist < x(j)), 2);
    RNN(j,:) = y;
end

% normalize by number of available neighbors
if (options.normalize)
    RNN = RNN./(size(D,1)-1);
end

RNN = [x' RNN];


