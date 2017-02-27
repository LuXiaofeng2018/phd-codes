% function rt = sqrer(y,n)
% This function will determine the squared error for
% regression trees.

function rt = sqrer(y,n)

if ~isempty(y)
   rt = sum((y-mean(y)).^2)/n;
else
   rt =0;
end


