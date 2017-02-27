% Example 10.15
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% In this example, we will use the boosting code
% from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.

% This uses a data set that he provided.

% The data are generated according to:
% x = rand(400, 2) * 2 - 1;
% y = (x(:, 2) > sin(pi * x(:, 1))) * 2 - 1;
% They are saved in:
load demo3.mat

% Run for ten iterations.
[w, h] =  adabstdemo(x, y, 10, ...
    @stumplearn, @stumpfunc, 1, 0, 100);

% Run for 100 iteration. 
[w, h] =  adabstdemo(x, y, 100, ...
    @stumplearn, @stumpfunc, 1, 0, 100);

