% function im = impure(pclass)
%
%  It uses the Gini index.

function im = impure(pclass)

% page 103 - CART book
im = 1 - sum(pclass.^2);
