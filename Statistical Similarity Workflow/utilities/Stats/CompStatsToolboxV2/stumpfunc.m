function hx = stumpfunc(theta, x)

%   STUMPFUNC     Evaluates the decision stump classifier
%
%   HX = STUMPFUNC(THETA,X)
%   
%   This function produces the stump classification for the classifier THETA,
%   which is an output from STUMPLEARN.
%
%   The class labels are provided in the output variable HX.
%
%   See also STUMPLEARN
%
% This is boosting code from Hsuan-Tien Lin, Cal Tech, htlin@caltech.edu
% This is included in the text and the CS Toolbox, 
% with his permission.


%   W. L. and A. R. Martinez, 12/14/07
%   Computational Statistics Toolbox, V 2 

dir = theta(1);
alpha = theta(2);
dim = theta(3);

hx = sign((x(:, dim) - alpha));
hx = hx + (hx == 0);
hx = dir .* hx;
