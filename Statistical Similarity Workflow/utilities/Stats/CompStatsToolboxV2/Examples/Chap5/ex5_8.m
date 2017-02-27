% Example 5.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Poissoness plot - modified
k=0:6;  % vector of counts
% Find n*_k.
n_k = [156 63 29 8 4 1 1];
N=sum(n_k);
phat=n_k/N;
nkstar=n_k-0.67-0.8*phat;
% Get vector of factorials.
fact=zeros(size(k));
for i=k
   fact(i+1)=factorial(i);
end
% Find the frequencies that are 1; nkstar=1/e.
ind1=find(n_k==1);
nkstar(ind1)= 1/2.718;
% Get phi(n_k) for plotting.
phik=log(fact.*nkstar/N);
ind=find(n_k~=1);
plot(k(ind),phik(ind),'o')
if ~isempty(ind1)
   text(k(ind1),phik(ind1),'1')
end
% Add some whitespace to see better.
axis([-0.5 max(k)+1 min(phik)-1 max(phik)+1])
xlabel('Number of Occurrences - k')
ylabel('\phi (n^*_k)')
