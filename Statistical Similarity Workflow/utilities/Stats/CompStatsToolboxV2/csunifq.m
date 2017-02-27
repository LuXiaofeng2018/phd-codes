function x = csunifq(prob,a,b)
% CSUNIFQ Inverse uniform cumulative distribution function.
%
%	X = CSUNIFQ(PROB,A,B) Returns the values of the inverse
% 	cumulative distribution function for the uniform distribution
%	with paramters A and B at the locations given in PROB. Note
%	that this is the quantiles of the distribution.
%
%	See also CSUNIFP, CSUNIFC, CSUNIPAR

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


if a > b
   error('A must be less than B.')
   return
end

if ~isempty(find(prob<0 | prob >1))
   error('Probabilities must be between 0 and 1')
   return
end

x=prob*(b-a)+a; 
