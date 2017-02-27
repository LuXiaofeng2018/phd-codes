% Example 5.24
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load iris
% This defines the domain that will be plotted.
theta=(-pi+eps):0.1:(pi-eps);
n = 50;
p = 4;
ysetosa = zeros(n,p);       
% There will n curves plotted, 
% one for each data point.
yvirginica=zeros(n,p);
% Take dot product of each row with observation.
ang = zeros(length(theta),p);   
fstr = '[1/sqrt(2) sin(i) cos(i) sin(2*i)]';
k = 0;
% Evaluate sin and cos functions at each angle theta.
for i=theta
   k=k+1;
   ang(k,:)=eval(fstr);
end
% Now generate a ‘y’ for each observation.
for i=1:n 
  for j=1:length(theta)
     % Find dot product with observation.
     ysetosa(i,j)=setosa(i,:)*ang(j,:)';    
     yvirginica(i,j)=virginica(i,:)*ang(j,:)';
  end
end
% Do all of the plots.
plot(theta,ysetosa(1,:),'r',...
				theta,yvirginica(1,:),'b-.')
legend('Iris Setosa','Iris Virginica')
hold
for i=2:n
  plot(theta,ysetosa(i,:),'r',...
				theta,yvirginica(i,:),'b-.')
end
hold off
title('Andrews Plot')
xlabel('t')
	ylabel('Andrews Curve')
    