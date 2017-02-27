function h = stumplearn(x, y, d)

%   STUMPLEARN     Learns the decision stump classifier
%
%   THETA = STUMPLEARN(X,Y)
%   
%   This function learns the stump classification for the features X and
%   class labels Y.
%
%   The classifier is provided in the output variables THETA.
%
%   See also STUMPFUNC
%
% This is boosting code from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.


%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

if nargin == 2
    N = size(x, 1);
    d = ones(N, 1) ./ N;
end

maxgrad = -1;
for dim=1:size(x, 2)
  xx = x(:, dim);
  xxx = sort(xx);
  alpha = 0.5 * (xxx(1:(length(xx)-1)) + xxx(2:length(xx)));
  alpha = [-inf, alpha', inf];

  hxa = sign(repmat(xx, 1, length(alpha)) - ...
             repmat(alpha, size(xx, 1), 1));
  hxa = hxa + (hxa == 0);

  grad = sum(repmat(y .* d, 1, length(alpha)) .* hxa);
  
  [best, idx] = max(abs(grad));
  idx = idx(1);

  alpha = alpha(idx);
  dir = (grad(idx) >= 0) * 2 - 1;

  if best > maxgrad
    maxalpha = alpha;
    maxdir = dir;
    maxgrad = best;
    maxdim = dim;
  end  
end

h = [];
h(1) = maxdir;
h(2) = maxalpha;
h(3) = maxdim;









