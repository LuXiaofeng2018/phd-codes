function csqqplot(x,y)
% CSQQPLOT Q-Q Plot.
%
%   CSQQPLOT(X,Y) This function will create a q-q plot 
%   using the data in X and Y. The samples do not have
%   to be the same size.
%
%   See also CSBINOPLOT, CSPOISSPLOT, CSEXPOPLOT

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

m=length(x);
n=length(y);
xs=sort(x);
ys=sort(y);

if m==n  % then just do the plot
   plot(xs,ys,'o')
   xlabel('X'),ylabel('Y')
elseif m<n
   % then interpolate from the y's - the one with more data
   prob=((1:n)-0.5)/n;  % x's that go with the ys data set
   qs = ((1:m)-0.5)/m;	% interpolate at these values
   ysi = interp1(prob,ys,qs,'linear');
   plot(xs,ysi,'o')
   xlabel('X'),ylabel('Y - Interpolated')
else
   % then interpolate from the x's - the one with more data
   prob=((1:m)-0.5)/m;  %x's that go with the xs data set
   qs=((1:n)-0.5)/n;		% interpolate at these values
   xsi=interp1(prob,xs,qs,'linear');
   plot(xsi,ys,'o')
   xlabel('X - Interpolated'),ylabel('Y')
end

   