function y = cspoisp(x,lambda)
% CSPOISP Poisson probability mass function.
%
%   Y = CSPOISP(X,LAMBDA) Returns the value of the
%   probability mass function for the Poisson 
%   distribution with parameter LAMBDA at the 
%   values given in X.
%
%   See also CSPOISC, CSPOIRND, CSPOIPAR, CSPOISSPLOT


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


% CHECK FOR DISCRETE X VALUES
if any(find(floor(x) ~= x))
   error('X values must be discrete')
   return
end

if lambda <= 0
   error('Lambda must be greater than 0')
   return
end
y=zeros(size(x));
ind=find(x>=0);
y(ind) = exp(-lambda)*lambda.^(x(ind))./gamma(x(ind)+1);