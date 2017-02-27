function y = binoc(x,n,p)
% CSBINOC Binomial cumulative distribution function.
%
%   Y = CSBINOC(X,TRIALS,P) returns the value of the binomial 
%   cumulative distribution function with parameters
%   TRIALS and success probability P at
%   given vector of X values.
%
%   See also CSBINOP, CSBINRND, CSBINPAR, CSBINOQ   


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if p < 0 | p > 1
   error('Success probability must be between 0 and 1')
   return
end

% CHECK FOR DISCRETE X VALUES
if any(find(floor(x) ~= x))
   error('X values must be discrete')
   return
end

y = zeros(size(x));  % NOTE: x < 0 yields y = 0
ind = find(x > n);
if ~isempty(ind)  % these get a value of 1
   y(ind) = 1;
end

ind = find(x>=0 & x<=n);
for i = ind
      y(i)=sum(binop(0:x(i),n,p));
end
