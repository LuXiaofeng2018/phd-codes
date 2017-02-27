function X = csmvrnd(mu,covm,n)
% CSMVRND Generate multivariate normal random variables.
%
%   R = CSMVRND(MU,COVM,N) Generates a sample of size N
%   random variables from the multivariate normal 
%   distribution. MU is the d-dimensional mean as a 
%   column vector. COVM is the d x d covariance matrix.
%

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 


if det(covm) <=0
    % Then it is not a valid covariance matrix.
    error('The covariance matrix must be positive definite')
end

mu = mu(:); % Just in case it is not a column vector.
d = length(mu);
% get cholesky factorization of covariance
R = chol(covm);
% generate the standard normal random variables
Z = randn(n,d);
X = Z*R + ones(n,1)*mu';