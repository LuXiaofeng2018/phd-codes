function rhat = csgelrub(nu)
% CSGELRUB Gelman and Rubin convergence diagnostic.
%
%   RHAT = CSGELRUB(NU) Returns the Gelman and Rubin convergence 
%   diagnostic for Markov chain Monte Carlo. The input to the
%   function is a mtarix of scalar summaries NU. Each row of the
%   matrix is a sequence of scalar summaries from the chain.
%   For example, the scalar summaries might be the mean, median, etc.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


[k,n]=size(nu);
% First find the Between Sequence variance
museq = mean(nu');	% mean of each row
mutot = mean(nu(:));
% square each element and sum
B = n/(k-1)*sum((museq - mutot).^2);

% Find the within-sequence variance
varseq = var(nu');	% variance of each row
W = mean(varseq);

varhat = (n-1)/n*W + B/n;

rhat = varhat/W;