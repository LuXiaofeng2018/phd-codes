function D = sqeudist(X, Q)
% D = sqeudist(X, Q);
%
% Squared euclidean distance matrix
% 
% Input:    X, Q    Data matrices. Of mX, mQ rows and nX, nQ columns. 
%                   Rows are observations, columns are variables.
%
% Output:   D       Distance matrix (mX,mQ)
%
% Copyright:        Knut Baumann, Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008


[m, n] = size(X);
[mQ, nQ] = size(Q);

xSq = sum(X .* X, 2);
qSq = sum(Q .* Q, 2);

qxCp = X * Q';

D = xSq*ones(1,mQ) + ones(m,1)*qSq' - 2 .* qxCp; % Binomic formula

D(D<eps)=0;

