% Example 5.17
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% Load the insect data
load insect
% Create a 3-D scatter plot using a 
% 		different color and marker
% for each class of insect.
% Plot the first class and hold the plot.
plot3(insect(1:10,1),insect(1:10,2),...
			insect(1:10,3),'ro')
hold on
% Plot the second class.
plot3(insect(11:20,1),insect(11:20,2),...
			insect(11:20,3),'gx')
% Plot the third class.
plot3(insect(21:30,1),insect(21:30,2),...
			insect(21:30,3),'b*')
grid on
box on       
hold off


