function fx = csecdf(data,x)
% CSECDF Empirical cumulative distribution function.
%
%   FHAT = CSECDF(DATA,X) Returns the empirical
%   distribution function at a given vector of X
%   locations, using the sample contained in DATA.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


n=length(data);
data=sort(data);
fx=zeros(size(x));
for i = 1:length(x)
   ind=find(data<=x(i));
   if ~isempty(ind)
      fx(i)=length(ind)/n;
   else
      fx(i)=0;
   end
end
