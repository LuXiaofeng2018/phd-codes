% Example 15.9
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

load cardiff
X = [x,y];
d = 0:30;
nd = length(d);
nx = length(x);
khatobs = cskhat(X, cardpoly, d);
% Get the lhat function.
lhatobs = sqrt(khatobs/pi) - d;

% Get the simulations.
B = 20;
% Each row is a Khat from a simulated CSR process.
simul = zeros(B,nd);
for b = 1:B
		[xt,yt] = csbinproc(cardpoly(:,1),...
				cardpoly(:,2), nx);
		temp = cskhat([xt,yt],cardpoly, d);
		simul(b,:) = sqrt(temp/pi) -d;
end
% Get the envelopes.
lhatup = max(simul);
lhatlo = min(simul);
plot(d,lhatobs,'k',d,lhatup,'k--',d,lhatlo,'k--')
