% Example 5.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

k=0:6;  % vector of counts
n_k = [156 63 29 8 4 1 1];
N=sum(n_k);
% get vector of factorials
fact=zeros(size(k));
for i=k
   fact(i+1)=factorial(i);
end
% get phi(n_k) for plotting
phik=log(fact.*n_k/N);
% find the counts that are equal to 1
% plot these with the symbol 1
% plot rest with a symbol
ind=find(n_k~=1);
plot(k(ind),phik(ind),'o')
ind=find(n_k==1);
if ~isempty(ind)
   text(k(ind),phik(ind),'1')
end
% add some whitespace to see better
axis([-0.5 max(k)+1 min(phik)-1 max(phik)+1])
xlabel('Number of Occurrences - k')
ylabel('\phi (n_k)')
