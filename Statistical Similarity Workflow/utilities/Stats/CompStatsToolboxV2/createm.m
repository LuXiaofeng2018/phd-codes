function true=createm(datapt,pies,mus,vars,tc,nterms,maxterms)
% CREATEM   Helper function - multivariate adaptive mixtures.
%  Implements the create rule. 

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

% compute functional value at data point

true=0;

[d,c]=size(mus);

% this rule says that if the point is greater than
% tc sigmas away from each term, then we create

distance=zeros(1,nterms);
for i=1:nterms
  distance(i)=(datapt'-mus(:,i))'*inv(vars(:,(i-1)*d+1:i*d))*(datapt'-mus(:,i));
end

if min(distance)>tc & nterms < maxterms
	true=1;
end


