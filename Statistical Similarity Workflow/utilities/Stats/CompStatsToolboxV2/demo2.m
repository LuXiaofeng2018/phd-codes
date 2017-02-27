%% Second demo, datasize: 200, 
%% donut shape
%% 50 iterations.
%% draw original characters
%% movie

% This is boosting code
% from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.

%x = randn(200, 2);
%y = (x(:, 1) .^ 2 + x(:, 2) .^ 2) > 1;
%x(find(y), :) = x(find(y), :) * 1.4;
%y = -y * 2 + 1;
load demo2.mat

[w, h] = ...
    adabstdemo(x, y, 50, @stumplearn, @stumpfunc, 1, 0, 100);
