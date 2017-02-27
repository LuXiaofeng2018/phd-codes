function D = chebydist(X, Q)
% D = chebydist(X, Q)
%
% Chebychev distance of two matrices X,Q
% Colums are variables, rows observations
%
% Input:    X, Q    Data matrices. Of mX, mQ rows and nX, nQ columns. 
%                   Rows are observations, columns are variables.
%
% Output:   D       Distance matrix (mX,mQ)
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


[mX nX] = size(X);
[mQ nQ] = size(Q);

D = zeros(mX,mQ);

for i=1:mX
    x = ones(mQ,1)*X(i,:);
    l = abs(x-Q);
    D(i,:) = max(l, [],2)';
end