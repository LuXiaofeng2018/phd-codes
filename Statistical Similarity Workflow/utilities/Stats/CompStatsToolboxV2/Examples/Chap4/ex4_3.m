% Example 4.3
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% set up storage space for the variables
n = 1000;
X=zeros(1,n);
% these are the x's in the domain
x = 0:2; 
% these are the probability masses
pr = [0.3 0.2 0.5];  
% generate 1000 rv’s from the desired distribution
for i=1:n
   u=rand;  % generate the U
   if u<=pr(1)
      X(i)=x(1);
   elseif u<= sum(pr(1:2)) 
				% it has to be between 0.3 and 0.5
      X(i)=x(2);
  else 
      X(i)=x(3); % it has to be between 0.5 and 1
   end
end

% find the proportion of each number
x0=length(find(X==0))/n;
x1=length(find(X==1))/n;
x2=length(find(X==2))/n;