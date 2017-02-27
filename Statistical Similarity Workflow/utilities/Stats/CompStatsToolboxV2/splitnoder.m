% this function will try to split the node
% function [split,vars] = splitnoder(x,y,impurity,n)
%
% This splits the nodes in regression trees.
% The input argument x is the data set for the node
% The input argumet impurity is the impurity for the node
% The output argument split will be the number to split on
% The output argument vars will be the dimension that is split on

function [split,dim]=splitnoder(x,y,impurity,n)

[n,d]=size(x);
gos = zeros(n-1,d);
asplit = zeros(n-1,d);
for j =1:d  % check each variable and find the best split
   [xs,ind]=sort(x(:,j));  
   for i=1:(n-1)
      asplit(i,j)=xs(i)+(xs(i+1)-xs(i))/2; %split bet points
      indl = find(x(:,j) <= asplit(i,j));
      yl = y(indl);
      indr = find(x(:,j) > asplit(i,j));
      yr = y(indr);
      gos(i,j)=impurity-sqrer(yr,n)-sqrer(yl,n);
   end
end
% we have a matrix of all possible splits - asplit
% we have a matrix of the goodness of the splits - gos
% find the largest gos - largest decrease in impurity
% the function max should give the largest value for each
% column along with the row number that gave us that
[mgos,indg]=max(gos);  % max goodness of split for each variable
[msplit,dim]=max(mgos); % max gos over all variables
split=asplit(indg(dim),dim);
