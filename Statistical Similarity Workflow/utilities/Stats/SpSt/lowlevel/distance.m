function D = distance(X,Y, mode)
% D = distance(X, Q, mode)
%
% Distance matrix of two matrices X, Q
% Colums are variables, rows observations.
%
% Input:    X, Y    Data matrices. Of mX, mY rows and nX, nY columns. 
%                   Rows are observations, columns are variables.
%
%           mode    distance mode. Possible values include:
%                   'euc':      Euclidean distance
%                   'cheby':    Chebychev distance
%                   'city':     City-Block (Manhattan) Distance
%
% Output:   D       Distance matrix (mX,mY)
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

if (strcmpi(mode, 'euc'))
    D = sqeudist(X,Y);
    D(D<0) = 0;
    D = sqrt(D);
elseif(strcmpi(mode, 'cheby'))
    D = chebydist(X,Y);
elseif(strcmpi(mode, 'city'))
    D = citydist(X,Y);
else
    error(strcat('distance: mode=', mode, 'not supported'));
end