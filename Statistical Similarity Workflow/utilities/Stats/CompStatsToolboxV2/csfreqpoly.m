function [fp,varargout] = csfreqpoly(data,h)
% CSFREQPOLY    Univariate or bivariate frequency polygon density estimate.
% 
%   [FP,X] = CSFREQPOLY(DATA,H)
%   Used in the 1-D case. This returns the values of X where FP is evaluated.
%
%   [FP,X,Y] = CSFREQPOLY(DATA,H)
%   Used in the 2-D case. This returns the values of X and Y where FP is
%   evaluated.
%
%   See also CSHISTDEN, CSHIST2D, CSFREQPOLY, CSKERN1D


%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

[n,d] = size(data);
% just in case it is a row vector ...
if n ==1 | d ==1
    d = 1;
end

% Get the stuff for the output arguments.
nout = max(nargout,1)-1;

if d == 1
    % do the univariate case.
    n = length(data); % just in case it is a row vector.
    if nargin==1
        % get the h from the normal reference rule
        h = 2.15*std(data)*n^(-1/5);
    end
    t0 = min(data)-1;
    tm = max(data)+1;
    bins = t0:h:tm;
    vk = histc(data,bins);
    vk(end) = [];
    fhat = vk/(n*h);
    % For freq polygon, get the bin centers, with empty
    % bin center on each end.
    bc2=(t0-h/2):h:(tm+h/2);
    binh = [0 fhat 0];
    % Use linear interpolation between bin centers
    % get the interpolated values at x.
    xinterp = linspace(min(bc2),max(bc2));
    fp = interp1(bc2, binh, xinterp);
    % to plot this, use bar with the bin centers
    tm = max(bins);
    bc = (t0+h/2):h:(tm-h/2);
    bar(bc,fhat,1,'w')
    hold on
    plot(xinterp,fp)
    hold off
    varargout{1} = xinterp;
    
elseif d==2
    [n,d] = size(data);
    x = data;
    if nargin == 1
        % then get the default bin width
        covm = cov(x);
        h(1) = 2*covm(1,1)*n^(-1/6);
        h(2) = 2*covm(2,2)*n^(-1/6);
    else
        if length(h)~=2
            error('Must have two bin widths in h.')
        end
    end
    bin0 = min(x)-1;
    % do the bivariate case.
    % Find the number of bins.
    nb1 = ceil((max(x(:,1))-bin0(1))/h(1));
    nb2 = ceil((max(x(:,2))-bin0(2))/h(2));
    % Find the mesh or bin edges.
    t1 = bin0(1):h(1):(nb1*h(1)+bin0(1));
    t2 = bin0(2):h(2):(nb2*h(2)+bin0(2));
    [X,Y] = meshgrid(t1,t2);
    
    % Find bin frequencies. 
    [nr,nc]=size(X);
    vu = zeros(nr-1,nc-1);
    for i=1:(nr-1)
        for j=1:(nc-1)
            xv = [X(i,j) X(i,j+1) X(i+1,j+1) X(i+1,j)];
            yv = [Y(i,j) Y(i,j+1) Y(i+1,j+1) Y(i+1,j)];
            in = inpolygon(x(:,1),x(:,2),xv,yv);
            vu(i,j) = sum(in(:));
        end
    end
    fhat = vu/(n*h(1)*h(2));
    % Now get the bin centers for the frequency polygon.
    % We add bins at the edges with zero height.
    t1=(bin0(1)-h(1)/2):h(1):(max(t1)+h(1)/2);
    t2=(bin0(2)-h(2)/2):h(2):(max(t2)+h(2)/2);
    [bcx,bcy]=meshgrid(t1,t2);
    [nr,nc]=size(fhat);
    binh = zeros(nr+2,nc+2);  % add zero bin heights
    binh(2:(1+nr),2:(1+nc))=fhat;
    % Get points where we want to interpolate to get
    % the frequency polygon.
    [xint,yint]=meshgrid(linspace(min(t1),max(t1),30),...
        linspace(min(t2),max(t2),30));
    fp = interp2(bcx,bcy,binh,xint,yint,'linear');
    varargout{1} = xint;
    varargout{2} = yint;
    surf(xint,yint,fp)
    axis tight
else
    % can't do here.
    error('Must be univariate or bivariate data.')
end