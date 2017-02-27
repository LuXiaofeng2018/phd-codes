% Example 5.21
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

for i=[0.4 0.6]
		figure
		hpatch=patch(isosurface(data,i),...
			'Facecolor','blue',...
			'Edgecolor','none',...
			'AmbientStrength',.2,...
			'SpecularStrength',.7,...
			'DiffuseStrength',.4);
		isonormals(data,hpatch)
		patch(isocaps(data,i),...
			'Facecolor','interp',...
			'EdgeColor','none')
		colormap hsv
		title(['alpha level = ' num2str(i)])
		daspect([1,1,1])
		axis tight
		axis off
		view(3)
		camlight right
		camlight left
		lighting phong
		drawnow
end
