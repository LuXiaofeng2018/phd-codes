function y = csbinop(x,n,p)
% CSBINOP Binomial probability mass function.
%
%   Y = CSBINOP(X,TRIALS,P) Returns the value of the probability
%   mass function for the binomial distribution with parameters
%   TRIALS and success probability P, at the values given in the
%   vector X.
%
%   See also CSBINOC, CSBINRND, CSBINPAR, CSBINOQ   

%   W. L. and A. R. Martinez, 4/10/00
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

% find the values
y = zeros(size(x));
ind=find(x>=0 & x<=n); %defined only for this range
for i = ind
   y(i) = comb(n,x(i));
end
y = y.*(p.^x).*(1-p).^(n-x);
   
function com = comb(n,x)
% this function finds the combination of n things taken x at a time

df = n-x;
tmp=max([df,x])+1;
num = prod(n:-1:tmp) ;
den = prod(2:min([df, x]));
com = num/den;
