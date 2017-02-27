function [pies,mus,vars]=csfinmix(data,muin,varin,piesin,max_it,tol)
% CSFINMIX  Expectation-Maximization algorithm for finite mixtures.
%
%   [WTS,MUS,VARS] = CSFINMIX(DATA,MUIN,VARIN,WTSIN,MAXIT,TOL)
%
%   This function implements the EM algorithm for estimating finite mixtures.
%   It requires an initial model for the component densities. This assumes
%   component densities are normals (univariate or multivariate). 
%
%   INPUTS: DATA is a matrix of observations, one on each row.
%           MUIN is an array of means, each column corresponding to a mean.
%           VARIN is a vector of variances in the univariate case. In the
%           multivariate case, it is a 3-D array of covariance matrix, one
%           page per component density.
%           WTSIN is a vector of weights.
%           MAXIT is the maximum allowed number of iterations.
%           TOL is the convergence tolerance.
%
%   An example of a bivariate. 2-term VARIN is:
%           varin(:,:,1) = 2*eye(2);
%           varin(:,:,2) = 3*eye(2);

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

[n,p] =  size(data);
if n==1 | p==1
    % then it is univariate data.
    data = data(:);
    p = 1;
end

num_term = length(piesin);

if p==1
    [n,p] = size(data);
    % init the vectors/matrices
    % posterior(i,j)=probability the ith data point was drawn from jth term
    posterior=zeros(n,num_term);  
    num_it=1;
    deltol=tol+1;
    while num_it <= max_it & deltol > tol;
        posterior=postup(data,muin,varin,piesin);
        pies=piup(posterior);
        mus=muup(data,posterior,pies);
        vars=varup(data,posterior,pies,mus);
        deltol=max([abs(piesin-pies),abs(mus-muin),abs(vars-varin)]);
        num_it=num_it+1;
        piesin=pies;
        muin=mus;
        varin=vars;
    end    % while loop
    
else
    % reset the parameters to the right names.
    mu = muin;
    var_mat = varin;
    mix_cof = piesin;
    
    % get necessary parameters
    tol = 0.001;
    [n,d]=size(data);	% n=# pts, d=# dims
    c=length(mix_cof);	% c=# terms
    % init the vectors/matrices
    % posterior(i,j)=probability the ith obsv is drawn from jth term
    num_it=1;
    deltol=tol+1;	% to get started
    while num_it <=max_it & deltol > tol
                
        posterior=postupm(data,mu,var_mat,mix_cof);
        mix_coff=piupm(posterior);
        muf=muupm(data,posterior,mix_cof);
        varf=varupm(data,posterior,mix_cof,mu);
        delvar = zeros(1,c);
        for j = 1:c
            delvar(j)=max(max(abs(varf(:,:,j)-var_mat(:,:,j))));
        end
        delmu=max(max(abs(muf-mu)));
        delpi=max(mix_cof-mix_coff);
        deltol=max([max(delvar),delmu,delpi]);
        
        % reset parameters
        num_it=num_it+1;
        mix_cof=mix_coff;
        mu=muf;
        var=varf;
    end  % while loop
    
    % assign the output variables.
    pies = mix_coff;
    mus = muf;
    vars = varf;
    
end


% function posterior=postup(data,mu,var,mix_cof)
function posterior=postup(data,mu,var,mix_cof)
c=length(mu);	% number of terms
totprob=zeros(size(data));
num=zeros(1,c);
for i=1:c	%loop to find total prob in denominator (hand, pg 37)
  posterior(:,i)=(mix_cof(i)/sqrt(var(i)))*exp(-(data-mu(i)).^2/(2*var(i)));
  totprob=totprob+posterior(:,i);
end
den=totprob*ones(1,c);  % this should work!!!
posterior=posterior./den;

% piup.m
%function mix_cof=piup(posterior)
function mix_cof=piup(posterior)
[n,c]=size(posterior);
mix_cof=sum(posterior)/n;

% function mu=muup(data,posterior,mix_cof)
function mu=muup(data,posterior,mix_cof)
[n,c]=size(posterior);
mu=data'*posterior;
mu=mu./mix_cof;
mu=mu/n;

% function var=varup(data,posterior,mix_cof,mu)
function var=varup(data,posterior,mix_cof,mu)
[n,c]=size(posterior);
data=data*ones(1,c)-ones(n,1)*mu;
data=data.^2;
var=(diag(posterior'*data))';
var=var./mix_cof;
var=var/n;

% function posterior=postupm(data,mu,var_mat,mix_cof)
function posterior=postupm(data,mu,var_mat,mix_cof)

[n,d]=size(data);
[d,c]=size(mu);
totprob=zeros(n,1);	% need one per data point, denon of eq 2.19, pg 37
for i=1:c	%loop to find total prob in denominator (hand, pg 37)
  posterior(:,i)=mix_cof(i)*csevalnorm(data,mu(:,i)',var_mat(:,(i-1)*d+1:i*d));
  totprob=totprob+posterior(:,i);
end

den=totprob*ones(1,c);  % this should work!!!
posterior=posterior./den;

% function var_mat=varupm(data,posterior,mix_cof,mu)
function var_mat=varupm(data,posterior,mix_cof,mu)

[n,c]=size(posterior);
[n,d]=size(data);
var_mat=zeros(d,d,c);
for i=1:c
  cen_data=data-ones(n,1)*mu(:,i)';
  mat=cen_data'*diag(posterior(:,i))*cen_data;
  var_mat(:,:,i)=mat./(mix_cof(i)*n);
end

%function mix_cof=piupm(posterior)
function mix_cof=piupm(posterior)

[n,c]=size(posterior);
mix_cof=sum(posterior)/n;

% function mu=muupm(data,posterior,mix_cof)
function mu=muupm(data,posterior,mix_cof)

[n,c]=size(posterior);
[n,d]=size(data);
mu=data'*posterior;
MIX=ones(d,1)*mix_cof;
mu=mu./MIX;
mu=mu/n;


