%% Third demo, datasize: 400.
%% sin function
%% 100 iterations.
%% draw emphasized characters
%% movie

% This is boosting code
% from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.

%x = rand(400, 2) * 2 - 1;
%y = (x(:, 2) > sin(pi * x(:, 1))) * 2 - 1;
load demo3.mat

[w, h] = ...
    adabstdemo(x, y, 100, @stumplearn, @stumpfunc, 1, 1, 100);
