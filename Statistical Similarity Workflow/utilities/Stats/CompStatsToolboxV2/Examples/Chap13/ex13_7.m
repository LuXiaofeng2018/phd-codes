% Example 13.7 
% This shows the Reincsh algorithm for the smoothing splines.
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


load vineyard
% Sort the x values, so they can be knots.
[x,ind] = sort(row);
y = totlugcount(ind);
x = x(:); y = y(:);
n = length(x);
alpha = 5;

% Next we get the Q and R matrices.
h = diff(x);
% Find 1/h_i;
hinv = 1./h;
% Keep the Q matrix as n by n orginally, 
% so the subscripts match the book.
% Then remove the first and last column.
qDs = -hinv(1:n-2) - hinv(2:n-1);
I = [1:n-2, 2:n-1, 3:n];
J = [2:n-1,2:n-1,2:n-1];
S = [hinv(1:n-2), qDs, hinv(2:n-1)];
% Create a sparse matrix.
Q = sparse(I,J,S,n,n);
% Delete the first and last columns.
Q(:,n) = []; Q(:,1) = [];
% Now find the R matrix. 
I = 2:n-2;  
J = I + 1;
tmp = sparse(I,J,h(I),n,n);
t = (h(1:n-2) + h(2:n-1))/3;
R = tmp'+tmp+sparse(2:n-1,2:n-1,t,n,n);
% Get rid of the rows/cols that are not needed.
R(n,:) = []; R(1,:) = [];
R(:,n) = []; R(:,1) = [];

% Get the smoothing spline.
S1 = Q'*y;
S2 = R + alpha*Q'*Q;
% Solve for gamma;
gam = S2\S1;
% Find f^hat.
fhat = y - alpha*Q*gam;

plot(x,y,'o',x,fhat)
title(['Alpha = ' num2str(alpha)])
xlabel('Row'),ylabel('Total Number of Lugs')

