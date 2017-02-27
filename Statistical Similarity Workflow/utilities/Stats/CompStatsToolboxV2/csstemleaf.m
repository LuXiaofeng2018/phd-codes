function csstemleaf(x,nstem)
% CSSTEMLEAF Stem-and-leaf plot.
%
%   CSSTEMLEAF(X,NSTEM) Constructs a stem-and-leaf plot using
%   the data given in X. 
%   
%   NSTEM = 1 shows one line per stem. NSTEM = 2 uses two lines
%   per stem. The default value for NSTEM is 1.
%
%   Note that the input data must be 1-D and integers.

%   W. L. and A. R. Martinez, 9/15/01
%   Computational Statistics Toolbox 

if nargin == 2 & ~(nstem == 1 | nstem == 2 )
    error('The number of lines per stem must be 1 or 2.')
end

if nargin == 1
   nstem = 1;
end

% first truncate and sort the data. This function does
% not account for decimal places.
x = sort(floor(x));
n=length(x);
% convert to a cell array of strings for easier plotting
xstr = cell(1,n);
for i = 1:n
   xstr{i} = int2str(x(i));
end
% get the first stem from the first string in cell array
tmp = xstr{1};
nch = length(tmp)-1;
stem1 = str2num(tmp(1:nch));
% find last stem
tmp = xstr{n};
nch = length(tmp)-1;
stemf = str2num(tmp(1:nch));
tmp = stem1:1:stemf;
N=length(tmp)*nstem;   % this will be the total number of lines
stems=zeros(1,N);  % set up array
temp=tmp*10;  % these are the full stems
leafstr=cell(1,N);

if nstem==1
   stems=tmp;
   % get the leaves
   for i=1:(N-1)
   ind=find(x>=temp(i) & x< temp(i+1));
   	for j=1:length(ind)
     		t=xstr{ind(j)};
     		leafstr{i}((2*j-1):2*j)=[t(end) ' '];
    	end
   end
   ind=find(x>=temp(end));
   for j=1:length(ind)
   	t=xstr{ind(j)};
   	leafstr{end}((2*j-1):2*j)=[t(end) ' '];
   end
elseif nstem==2
   for i=1:length(tmp)
      stems((2*i-1):2*i)=tmp(i);
   end
   % get the leaves
   i=0;
   for k=temp
      i=i+1;
      ind=find(x>=k & x< k+5);
      for j=1:length(ind)
          t=xstr{ind(j)};
          leafstr{i}((2*j-1):2*j)=[t(end) ' '];
      end
      ind=find(x>=k+5 & x < k+10);
      i=i+1;
      for j=1:length(ind)
         t=xstr{ind(j)};
         leafstr{i}((2*j-1):2*j)=[t(end) ' '];
      end
   end
   ind=find(x>=temp(end) & x< temp(end)+5);
   for j=1:length(ind)
     	t=xstr{ind(j)};
        leafstr{end-1}((2*j-1):2*j)=[t(end) ' '];
   end
   ind=find(x>=temp(end)+5);
   for j=1:length(ind)
      t=xstr{ind(j)};
      leafstr{end}((2*j-1):2*j)=[t(end) ' '];
   end
else
   error('Number of stems must be 1 or 2')
   return
end
% convert stems to cell arrays of strings
stemstr = cell(1,N);
for i = 1:N
   stemstr{i}=int2str(stems(i));
end
% get coordinates for plotting strings and stems
xx = 0.7*ones(1,N);
y = (N:-1:1);
plot([1 1] , [0.3 N+0.3])
text(xx, y, stemstr)
xx = ones(1,N)+0.25;
text(xx,y,leafstr)
axis off
axs=axis;
axis([axs(1) axs(2)+3 axs(3)-1 axs(4)+1])

   

   