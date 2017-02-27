function mus=rmuupm(x,pies,mus,posterior,nterms,n)
% RMUUPM    Helper function for adaptive mixtures.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


betan=1/(n);

[d,c]=size(mus);

for i=1:nterms

  mus(:,i)=mus(:,i)+betan*posterior(i)*(x'-mus(:,i))/pies(i);

end

