function [w, h, trainerr, testerr] = csboost(x, y, T, learn, func, tx, ty)

%   CSBOOST     ADA Boost Classifier
%
%   [w, h, trainerr, testerr] = csboost(x, y, T, @learn, @func, tx, ty)
%
%   or
%
%   [w, h, trainerr] = csboost(x, y, T, @learn, @func)
%
%   The outputs are the weights w, the classifier h, the training error
%   (trainerr), and the testing error (testerr). 
%
%   The inputs to the function are the features x (an n by d) matrix, a
%   vector of class labels y {-1,1}, the number of iterations T, a handle
%   to the learning function (@learn), and a handle to the function that
%   evaluates the classifier (@func). 
%
%   One can also provide optional data for testing in the input arguments
%   tx and ty. 
%
%   EXAMPLE:
%
%   load iris
%   x = [versicolor;virginica];
%   y = [ones(50,1); -1*ones(50,1)];
%   [w, h, trainerr] = csboost(x, y, 100, @stumplearn, @stumpfunc);
%
%   x = [versicolor(1:25,:);virginica(1:25,:)];
%   y = [ones(25,1); -1*ones(25,1)];
%   xt = [versicolor(26:50,:);virginica(26:50,:)];
%   [w, h, trainerr,tsterr] = csboost(x, y, 100, @stumplearn, @stumpfunc,xt,y);
%
%   See also ADABSTDEMO, DEMO1, DEMO2, DEMO3, AGGREGATE, STUMPFUNC,
%   STUMPLEARN
%
% This is boosting code from Hsuan-Tien Lin, Cal Tech.
% This is included in the text and the CS Toolbox, 
% with his permission.

%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 



N = size(x, 1);
w = zeros(T, 1);
d = ones(N, 1) ./ N;
h = cell(T, 1);

trainerr = [];
testerr = [];

for t=1:T
  t
%   tic,
  h{t} = learn(x, y, d);
%   toc
  
  hx = func(h{t}, x);

%   tic,
  w(t) = fminsearch(@(wt) (sum(repmat(d, 1, length(wt)) .* ...
                        exp(- (y .* hx) .* wt))), 0);
%   toc
  d = d .* exp(- (y .* hx) * w(t));
  d = d ./ sum(d);
  
  [yy, mgn] = aggregate(w, h, func, x);  
  trainerr(t) = sum(yy ~= y) ./ N * 100; 
  if nargin == 7
      [yy, mgn] = aggregate(w, h, func, tx);  
      testerr(t) = sum(yy ~= ty) ./ length(ty) * 100;  
  end
end

  
  
