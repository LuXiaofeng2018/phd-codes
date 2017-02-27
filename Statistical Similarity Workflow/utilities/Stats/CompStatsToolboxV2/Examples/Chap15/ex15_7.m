% Example 15.7
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load bodmin
X = [x,y];
% Note that we are using a smaller range 
% for w than before.
w = 0:.1:6;
nw = length(w);
nx = length(x);
ghatobs = csghat(X,w);

% Get the simulations.
B = 99;
% Each row is a Ghat from a simulated CSR process.
simul = zeros(B,nw);
for b = 1:B
		[xt,yt] = csbinproc(bodpoly(:,1), bodpoly(:,2), nx);
		simul(b,:) = csghat([xt,yt],w);
end

% Get the average.
ghatmu = mean(simul);
% Get the envelopes.
ghatup = max(simul);
ghatlo = min(simul);
plot(ghatmu,ghatobs,'k',ghatmu,ghatup,...
			'k--',ghatmu,ghatlo,'k--')
        