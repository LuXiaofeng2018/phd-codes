function x = csbinoq(prob,n,p)
% CSBINOQ Quantiles of the binomial distribution.
%
%   X = CSBINOQ(PROB,TRIALS,P) calculates the inverse
%   (or quantiles) of the binomial cumulative distribution 
%   function with parameters TRIALS and success probability P
%   at a given vector of probability values PROB.
%
%   See also CSBINOP, CSBINOC, CSBINRND, CSBINPAR    


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 



if p < 0 | p > 1
   error('Success probability must be between 0 and 1')
   return
end

if ~isempty(find(prob<0 | prob >1))
   error('Probabilities must be between 0 and 1')
   return
end

x=zeros(size(prob));
% Find all values of the cdf over 0:n
t = 0:n;
cdf = binoc(t,n,p);
for i=1:length(prob)
   ind = find(cdf <= prob(i));
   if ~isempty(ind); x(i) = t(length(ind));
   end
end
