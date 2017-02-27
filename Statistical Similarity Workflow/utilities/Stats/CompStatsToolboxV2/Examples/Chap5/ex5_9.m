% Example 5.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

% Binomialness plot.
k=0:9;
n=10;
n_k=[1 3 4 23 25 19 18 5 1 1];
N=sum(n_k);
nCk=zeros(size(k));
for i=k
   nCk(i+1)=nchoosek(n,i); 
end
phat=n_k/N;
nkstar=n_k-0.67-0.8*phat;
% Find the frequencies that are 1; nkstar=1/e.
ind1=find(n_k==1);
nkstar(ind1)= 1/2.718;
% Get phi(n_k) for plotting.
phik=log(nkstar./(N*nCk));
% Find the counts that are equal to 1.
ind=find(n_k~=1);
plot(k(ind),phik(ind),'o')
if ~isempty(ind1)
   text(k(ind1),phik(ind1),'1')
end
% Add some whitespace to see better.
axis([-0.5 max(k)+1 min(phik)-1 max(phik)+1])
xlabel('Number of Females - k')
ylabel('\phi (n^*_k)')
