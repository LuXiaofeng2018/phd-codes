% Example 5.20
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez


% Get some data that will be between 0 and 1.
data = rand(10,10,10);
data=smooth3(data,'gaussian');
% Just in case there are some figure windows 
% open - we should start anew.
close all
for i=[0.4 0.6]
    figure
    hpatch=patch(isosurface(data,i),...
        'Facecolor','blue',...
        'Edgecolor','none',...
        'AmbientStrength',.2,...
        'SpecularStrength',.7,...
        'DiffuseStrength',.4);
    isonormals(data,hpatch)
    title(['f(x,y,z) = ' num2str(i)])
    daspect([1,1,1])
    axis tight
    axis off
    view(3)
    camlight right
    camlight left
    lighting phong
    drawnow
end
