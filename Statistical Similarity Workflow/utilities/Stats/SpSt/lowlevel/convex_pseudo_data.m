function sP = convex_pseudo_data(nP, I)
%
% sP = convex_pseudo_data(nP, I)
%
% Convex pseudo-datapoints generated following the algorithm by Breiman et
% al. To generate nP pseudo-datapoints, the algorithm randomly uses 2xnP
% datapoints from the original data. See
%
% CITATION
%
% for details.
%
%   Input:      nP      Number of pseudo-datapoints to generate. 
%
%               I       Original data.
%
%
%   Output:     sP      Pseudo-datapoints. (nP x dim(I))
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


[m n] = size(I);

if (license('checkout', 'statistics_toolbox'))      % Use statistics toolbox,
    s1 = unidrnd(m, nP, 1);                         % if available.
    s2 = unidrnd(m, nP, 1);                         % Much faster.
else
    if(nP <=m)                                      % Without stats. toolbox,
        r1 = randperm(1:m);                         % random points can only be
        r2 = randperm(1:m);                         % drawn without replacement.
        s1 = r1(1:nP);                              % This is slower and requires a
        s2 = r2(1:nP);                              % minimum number of original datapoints
    else
        error('convex_pseudo_data: not enough datapoints');
    end
end

w1 = rand(nP,1)*ones(1,n);      % Generate random weights.
w2 = ones(nP,n) - w1;           % By setting w2 = 1-w1, the pseudo-data lies in the same domain as the original data
                                % => CONVEX!!
P1 = w1.*I(s1,:);               %
P2 = w2.*I(s2,:);               % 


sP = P1+P2;                     % Output: linear combination of weighted random input datapoints.