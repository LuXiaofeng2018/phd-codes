% Example 13.11
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

close all
% Generate bivariate data.
X(1:50,1)=unifrnd(0.1,1,50,1);
X(1:50,2)=unifrnd(0.6,1,50,1);
y(1:50) = 2;
X(51:100,1)=unifrnd(-1,-.1,50,1);
X(51:100,2)=unifrnd(-0.4,1,50,1);
y(51:100)=3;
X(101:150,1)=unifrnd(-1,-.1,50,1);
X(101:150,2)=unifrnd(-1,-0.6,50,1);
y(101:150)=10;
X(151:200,1)=unifrnd(0.1,1,50,1);
X(151:200,2)=unifrnd(-1,0.4,50,1);
y(151:200)=-10;

% Do the plot.
plot(X(1:50,1),X(1:50,2),'o')
hold on
plot(X(51:100,1),X(51:100,2),'.')
plot(X(101:150,1),X(101:150,2),'*')
plot(X(151:200,1),X(151:200,2),'+')
xlabel('X_1'),ylabel('X_2')


% Use the MATLAB Statistics Toolbox functions to
% fit a regression tree. This functionality is
% now obsolete with Version 6. It is still supported
% for backwards compatability.
tree = treefit(X,y(:),'method','regression')
treedisp(tree)

% Here is the decision tree that appears in the 
% command window.
% 1  if x1<-0.0107576 then node 2 else node 3
% 2  if x2<-0.498968 then node 4 else node 5
% 3  if x2<0.464465 then node 6 else node 7
% 4  fit = 10
% 5  fit = 3
% 6  fit = -10
% 7  fit = 2

% Plot the decision region on the scatterplot
figure(1)
plot([-0.0107576 -0.0107576], [-1 1])
plot([-1 -0.0107576], [-0.498968 -0.498968])
plot([-0.0107576, 1], [0.464465 0.464465])


