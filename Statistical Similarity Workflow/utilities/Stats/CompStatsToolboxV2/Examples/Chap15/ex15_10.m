% Example 15.10
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Set the lambda. 
lambda = 2;
r = 5;
tol = 0;
i=1;
% Generate the exponential random variables.
while tol < pi*r^2
			x(i) = exprnd(1/lambda,1,1);
			tol = sum(x);
			i=i+1;
end
x(end)=[];
N = length(x);
% Get the coordinates for the angles.
th = 2*pi*rand(1,N);
R = zeros(1,N);
% Find the R_i.
for i = 1:N
			R(i) = sqrt(sum(x(1:i))/pi);
end
[Xc,Yc]=pol2cart(th,R);

% estimate the overall intensity
lamhat = length(Xc)/(pi*r^2);
