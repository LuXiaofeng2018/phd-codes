function bound = csgetregion
% CSGETREGION Interactively obtain the study region.
%
%   REGION = CSGETREGION This function returns the vertices
%   of a polygonal region that is chosen interactively. The
%   user can create a connected polygon by clicking the left
%   mouse button. When finished, press the right mouse button.
%   There is no need to close the boundary, that will be done
%   after the right mouse button is clicked.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox

[X(1),Y(1)]=ginput(1);
ii = 1;
nn = 1;
hold on
plot(X(1),Y(1),'k*');
while 1
	ii = ii+1;
	[X(ii),Y(ii),butt]=ginput(1);
	if butt == 3	% right mouse button clicked
		break
	else
		nn = nn+1;
		plot([X(ii-1) X(ii)], [Y(ii-1) Y(ii)],X(ii),Y(ii),'k*');
		drawnow
	end
end
% get rid of the last vertex - not needed
X(end) = [];
Y(end) = [];
t = length(X);
X(t+1) = X(1);
Y(t+1) = Y(1);
bound = [X', Y'];
plot(bound(:,1),bound(:,2));


