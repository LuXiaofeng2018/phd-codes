% Example 3.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% generate the random sample and sort
x=sort(rand(1,100));
% find the median of the lower half - first quartile
q1=median(x(1:50)); 
% find the median
q2=median(x);
% find the median of the upper half - third quartile
q3=median(x(51:100));
