% Example 2.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% First get the domain over which to 
% evaluate the functions.
x=0:.1:3;
% Now get the functions values for
% different values of lambda.
y1=gampdf(x,1,1/1);
y2=gampdf(x,2,1/2);
y3=gampdf(x,3,1/3);
% Plot the functions.
plot(x,y1,'r',x,y2,'g',x,y3,'b')
title('Gamma Distribution')


