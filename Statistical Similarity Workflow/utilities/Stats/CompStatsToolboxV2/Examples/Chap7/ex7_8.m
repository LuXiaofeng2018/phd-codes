% Example 7.8
% Computational Statistics Handbook with MATLAB, 2nd Edition
% Wendy L. and Angel R. Martinez

M = 1000;
alpha = 0.05;
% Get the critical value, using z as test statistic.
cv = norminv(alpha,0,1);
% Start the simulation.
Im = 0;
for i = 1:M
		% Generate a random sample under H_0.
		xs = sigma*randn(1,n) + 454;
		Tm = (mean(xs)-454)/sigxbar;
		if Tm <= cv	 				% then reject H_0
			Im = Im +1;
		end
end
alphahat = Im/M;

% Now check the probability of Type II error.
% Get some alternative hypotheses:
mualt = 445:458;
betahat = zeros(size(mualt));
for j = 1:length(mualt)
   Im = 0;
   % Get the true mean.
   mu = mualt(j);
   for i = 1:M
      % Generate a sample from H_1.
      xs = sigma*randn(1,n) + mu;
      Tm = (mean(xs)-454)/sigxbar;
      if Tm > cv   % Then did not reject H_0.
         Im = Im +1;
      end
   end
   betahat(j) = Im/M;
end
% Get the estimated power.
powhat = 1-betahat;

% Get the plot in Figure 7.5
plot(mualt, powhat, '*-')
ylabel('Estimated Power')
xlabel('\mu')

