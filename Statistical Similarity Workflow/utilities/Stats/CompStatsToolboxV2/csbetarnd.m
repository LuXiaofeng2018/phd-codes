function X = csbetarnd(a,b,n)
% CSBETARND Generate variates from the univariate beta distribution.
%
%   Y = CSBETARND(ALPHA,BETA,N) Returns a row vector of random
%   variables from the beta distribution with parameters
%   ALPHA and BETA.
%
%   See also CSBETAP, CSBETAC

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

if a == 1 & b ==1 % then the beta is uniform
   X = rand(1,n);
else  % use acceptance-rejection method
   % set up the space to store the random variables.
   X=zeros(1,n);
   % get the constant in the beta pdf
   const = gamma(a+b)/(gamma(a)*gamma(b));
   % get the value of pdf at the mode
   if a > 1 & b > 1
      arg1 = (a-1)/(a+b-2);
      arg2 = (b-1)/(b+a-2);
      mode = const*arg1^(a-1)*arg2^(b-1);
   else
      mode = 4;   % set peak to arbitrary value
   end
   % start generating the random variables
   i=1;
   while i <= n
      % this will be used to evaluate the beta pdf
      u1 = rand(1);	
      u2 = rand(1);
      tmp = const*u1^(a-1)*(1-u1)^(b-1);
      if mode*u2 <= tmp
         % accept that variate
         X(i)=u1;
         i=i+1;
      end
   end
end


