function [y] = MyEmprand(X,k)
 bw = .1;
 y = X(floor(1+rand(k,1)*numel(X))) + bw*randn(k,1);
end