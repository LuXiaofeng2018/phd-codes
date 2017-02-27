function Z = cshist2d(x,flag,h)
% CSHIST2D  Bivariate histogram.
%
%   Z = CSHIST2D(DATA,FLAG,H)
%
%   Constructs a bivariate histogram using the observed DATA. Each row
%   of DATA corresponds to a bivariate observation. 
%   H is the smoothing parameter. This is optional. The default is the 
%   Normal Reference Rule bin width.
%   FLAG indicates what type of plot to provide: 1 = SURF,2 = Square bins
%   
%   X and Y provide the coordinates of the bins. Z is the height of the
%   histogram.
%
%   See also CSHISTDEN, CSFREQPOLY, CSASH

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

%   Revision 1/02 - Fixed bug for axes - they were set at (-3,3) for the
%   standard normal. Removed the X and Y axes limits. 

%   Revision 1/02  - A user wrote in with a problem: the surface was not plotting. The
%   data had a covariance matrix where one variance was 1400 and the other
%   was 600. This resulted in 1 bin for each direction, using the default h. When the default
%   bin width calculation yields too few bins, the user needs to input 
%   the window widths, h. Put in some code to catch this.

[n,p] = size(x);
if p ~= 2
    error('Must be bivariate data.')
end

if nargin == 2
    % then get the default bin width
    covm = cov(x);
    h(1) = 3.5*covm(1,1)*n^(-1/4);
    h(2) = 3.5*covm(2,2)*n^(-1/4);
else
    if length(h)~=2
        error('Must have two bin widths in h.')
    end
end

% Need bin origins.
bin0=[floor(min(x(:,1))) floor(min(x(:,2)))]; 
% find the number of bins
nb1 = ceil((max(x(:,1))-bin0(1))/h(1));
nb2 = ceil((max(x(:,2))-bin0(2))/h(2));

% check the number of bins. If too small, then the user should enter
% the h values.
if nb1 < 5 | nb2 < 5
    disp(['Number of bins in the X_1 direction is ' int2str(nb1)])
    disp(['Number of bins in the X_2 direction is ' int2str(nb2)])
    error('You must enter the window width h to yield 5 or more bins in each direction.')
end

% find the mesh
t1 = bin0(1):h(1):(nb1*h(1)+bin0(1));
t2 = bin0(2):h(2):(nb2*h(2)+bin0(2));
[X,Y] = meshgrid(t1,t2);
% Find bin frequencies.
[nr,nc] = size(X);
vu = zeros(nr-1,nc-1);
for i = 1:(nr-1)
   for j = 1:(nc-1)
      xv = [X(i,j) X(i,j+1) X(i+1,j+1) X(i+1,j)];
      yv = [Y(i,j) Y(i,j+1) Y(i+1,j+1) Y(i+1,j)];
      in = inpolygon(x(:,1),x(:,2),xv,yv);
      vu(i,j) = sum(in(:));
   end
end
Z = vu/(n*h(1)*h(2));

    
if flag == 1
    surf(Z)
    grid off
    axis tight
    set(gca,'YTickLabel',' ','XTickLabel',' ')
    set(gca,'YTick',0,'XTick',0)
elseif flag == 2
    % The Z matrix is obtained in Example 5.14
    bar3(Z,1)
    % Use some Handle Graphics.
    set(gca,'YTick',0,'XTick',0)
    grid off
    axis tight
else
    error('Flag must be 1 for surface plot or 2 for square bins.')
end


