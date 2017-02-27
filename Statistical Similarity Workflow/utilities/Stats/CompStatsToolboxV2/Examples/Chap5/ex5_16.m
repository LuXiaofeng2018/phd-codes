% Example 5.16
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% The Z matrix is obtained in Example 5.15.
bar3(Z,1)
% Use some Handle Graphics.
set(gca,'YTickLabel',' ','XTickLabel',' ')
set(gca,'YTick',0,'XTick',0)
grid off


% Make a histogram with see-through bars. The
% hist3 function is in the Statistics Toolbox.
% We use the data (x) generated in Example 5.15.
hist3(x,[10 10],'FaceAlpha',0.35);
set(gcf,'renderer','opengl');
axis tight


% Plot the 2-D histogram as a scatter plot with
% heights proportional to marker size.
% Find the bin centers.
n1 = length(t1);
n2 = length(t2);
tt1 = linspace((t1(1)+t1(2))/2,...
			(t1(n1-1)+t1(n1))/2,nb1);
tt2 = linspace((t2(1)+t2(2))/2,...
			(t2(n2-1)+t2(n2))/2,nb2);
[xxs,yys] = meshgrid(tt1,tt2);
scatter(xxs(:),yys(:),(Z(:)+eps)*1000,...
				(Z(:)+eps)*1000,'filled')
% Create a colorbar and set the axis 
% to the correct scale
h_ax = colorbar;
% Get the current labels.
temp = get(h_ax,'Yticklabel');
[nr,nc] = size(temp);
% Convert from strings to numbers.
newlab = cell(nr,1);
tempcell = cellstr(temp);
% Re-scale and convert back to numbers.
for i=1:nr
   newlab{i}=num2str((str2num(tempcell{i})/1000));
end
set(h_ax,'Yticklabel',newlab)
