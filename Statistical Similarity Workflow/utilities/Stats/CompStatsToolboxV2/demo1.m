%% First demo, very simple, datasize: 10, 
%% until zero training error
%% draw emphasized characters
%% step by step.

% This is boosting code from
% Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.

load demo1.mat

[w, h] = ...
    adabstdemo(x, y, 10, @stumplearn, @stumpfunc, 0, 1, 1);
