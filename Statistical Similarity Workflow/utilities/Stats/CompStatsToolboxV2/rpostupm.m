function posterior=rpostupm(x,pies,mus,vars,nterms)
% RPOSTUPM  Helper function for adaptive mixtures.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox


totprob=0;
posterior=zeros(1,nterms);

[d,c]=size(mus);

for i=1:nterms	%loop to find total prob in denominator (hand, pg 37)
  posterior(i)=pies(i)*csevalnorm(x',mus(:,i)',vars(:,(i-1)*d+1:i*d));
  totprob=totprob+posterior(i);
end


posterior=posterior/totprob;



