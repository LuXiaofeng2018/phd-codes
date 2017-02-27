% Example 5.18
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


load iris
% This loads up three matrices, one for each species.
% Get the plotmatrix display of the Iris setosa data.
[H,ax,bigax,P]=plotmatrix(setosa);
axes(bigax),title('Iris Setosa')

% Create the labels as a cell array of strings.
labs={'Sepal Length','Sepal Width',...
				'Petal Length', 'Petal Width'};
[H,ax,bigax,P]=plotmatrix(virginica);
axes(bigax)
title('Virginica')

% Delete the histograms.
delete(P)
%Pput the labels in - the positions might have
% to be adjusted depending on the text. 
for i = 1:4
   txtax = axes('Position',get(ax(i,i),'Position'),...
      'units','normalized');
   text(.1, .5,labs{i})
   set(txtax,'xtick',[],'ytick',[],...
      'xgrid','off','ygrid','off','box','on')
end
