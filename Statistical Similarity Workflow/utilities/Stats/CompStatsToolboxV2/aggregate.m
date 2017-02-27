function [y, mgn] = aggregate(w, h, func, x)

%   AGGREGATE     Evaluate boosting classifier
%
%   [Y,MGN] = AGGREGATE(W,H,@FUNC,X)
%   
%   This function produces the classification for features in X, given the
%   boosting classifier with weights W and ensemble classifiers H. The
%   input argument FUNC is a function handle to the individual
%   classification function. 
%
%   The class labels are provided in the output variable Y.
%
%   Note that this is implemented for the stump classifier.
%
%   EXAMPLE:
%
%   load iris
%   x = [versicolor(1:25,:);virginica(1:25,:)];
%   y = [ones(25,1); -1*ones(25,1)];
%   xt = [versicolor(26:50,:);virginica(26:50,:)];
%   [w, h, trainerr] = csboost(x, y, 100, @stumplearn, @stumpfunc);
%   [yt, mgn] = aggregate(w, h, @stumpfunc, xt);
%
%   See also ADABSTDEMO, CSBOOST, STUMPFUNC, STUMPLEARN
%
% This is boosting code from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.

%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

N = size(x, 1);
mgn = zeros(N, 1);
for t=1:length(w)
  if size(h{t}, 1) == 0 || w(t) == 0
    break;
  end  
  mgn = mgn + w(t) * func(h{t}, x);
end
y = sign(mgn);
