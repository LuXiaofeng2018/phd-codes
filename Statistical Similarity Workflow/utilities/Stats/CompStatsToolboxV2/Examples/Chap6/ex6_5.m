% Example 6.5
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% This is for the iris data
load iris
% Put data into one matrix.
x = [setosa;virginica;versicolor];  
% Set up vector of frequencies.
th = sqrt([2 3]);
% Set up other constants.
[n,d]=size(x);
% This is a small irrational number:
delt=eps*10^14; 
% Do the tour for some specified time steps.
maxit = 1000;					
cof = sqrt(2/d);
% Set up storage space for projection vectors.
a = zeros(d,1);
b = zeros(d,1);
z=zeros(n,2);

% Get an initial plot, so the tour can be implemented 
% using Handle Graphics.
Hlin1 = plot(z(1:50,1),z(1:50,2),'ro');
set(gcf,'backingstore','off')
set(gca,'Drawmode','fast')
hold on
Hlin2 = plot(z(51:100,1),z(51:100,2),'go');
Hlin3 = plot(z(101:150,1),z(101:150,2),'bo');
hold off
axis equal,axis vis3d,axis off

% Start the tour.
for t=0:delt:(delt*maxit)
		% Find the transformation vectors.
		for j=1:d/2
			a(2*(j-1)+1)=cof*sin(th(j)*t);
			a(2*j)=cof*cos(th(j)*t);
			b(2*(j-1)+1)=cof*cos(th(j)*t);
			b(2*j)=cof*(-sin(th(j)*t));
		end
		% Project onto the vectors.
		z(:,1)=x*a;
		z(:,2)=x*b;
		set(Hlin1,'xdata',z(1:50,1),'ydata',z(1:50,2))
		set(Hlin2,'xdata',z(51:100,1),'ydata',z(51:100,2))
		set(Hlin3,'xdata',z(101:150,1),'ydata',z(101:150,2))
		drawnow
end
