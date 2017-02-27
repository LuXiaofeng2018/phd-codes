function [S, u] = spst_dixonS(D, class_labels, options)
%
% S = spst_dixonS(D, map, options)
%
% For n datasets of events of different classes, S(i,j) is the fraction of
% nearest neighbors of class i that belong to class j. S has the dimensions
% (n,n).
%
% Input:    D               Data matrix (m,n). Rows=observations, columns=variables.
%
%           class_labels    Vector (numeric!) identifying class membership in D.
%                           (m,1).
%
%           options         Options struct variable. Default values are indicated
%                           by *asterisks*.
%
%           options.distmode:   *'euc'*, 'city', 'cheby'
%           options.sort:       *false*, boolean, sort class_labels and
%                               corresonding S in ascending order.
%
% Output:   S               Matrix with intra- and interset nearest
%                           neighbor distributions. (n,n)
%
%           u               class labels to entries in S. (n,1)
%
% Copyright:        Sebastian Rohrer
%                   University of Braunschweig, Institute of Technology
%                   Department of Pharmaceutical Chemistry
%                   2008

% get the number and labels of classes
u = unique(class_labels);
ni = size(u,1);

if (nargin < 3)
    options.sort = false;
    options.distmode='euc';
end

% get number of columns.
[m n] = size(D);

% initialize result S
S = zeros(ni,ni);

for i = 1:ni;
    t = class_labels == u(i);
    [dnn ind] = nndist(D(t,:), D, 2, options.distmode);
    
    % we need the "second" nearest neighbor, because D1 itself is in the
    % set...
    ind = ind(:,2);    
    
    for j = 1:ni
        S(i,j) = sum(class_labels(ind) == j);
    end
end
S = S./m;
        
        
        
        
        
        
        
        