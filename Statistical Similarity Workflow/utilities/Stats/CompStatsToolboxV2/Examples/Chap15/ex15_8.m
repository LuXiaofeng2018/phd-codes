% Example 15.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load bodmin
X = [x,y];
d = 0:.5:10;
nd = length(d);
nx = length(x);
% Now get the Khat for the observed pattern.
khatobs = cskhat(X, bodpoly, d);

% Get the simulations.
B = 20;
% Each row is a Khat from a simulated CSR process.
simul = zeros(B,nd);
for b = 1:B
		[xt,yt] = csbinproc(bodpoly(:,1), bodpoly(:,2), nx);
		simul(b,:) = cskhat([xt,yt],bodpoly, d);
end

% Get the envelopes.
khatup = max(simul);
khatlo = min(simul);
% And plot the results.
plot(d,khatobs,'k',d,khatup,'k--',d,khatlo,'k--')
